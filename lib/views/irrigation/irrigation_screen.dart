import 'package:flutter/material.dart';
import 'package:sinchai_sathi/models/schedule_model.dart';
import 'package:sinchai_sathi/services/api_service.dart';
import 'package:sinchai_sathi/utils/local_storage.dart';
import 'package:sinchai_sathi/views/irrigation/schedule_list_tile.dart';
import 'package:sinchai_sathi/views/irrigation/switch_button.dart';
import 'package:sinchai_sathi/views/irrigation/water_saving_chart.dart';
import 'package:sinchai_sathi/views/irrigation/schedule_dialog.dart';

class IrrigationScreen extends StatefulWidget {
  const IrrigationScreen({super.key});

  @override
  State<IrrigationScreen> createState() => _IrrigationScreenState();
}

class _IrrigationScreenState extends State<IrrigationScreen> {
  final ApiService apiService = ApiService();
  bool motorStatus = false;
  List<Schedule> schedules = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSchedules();
  }

  void fetchSchedules() async {
    try {
      final fetchedSchedules = await apiService.getSchedules(1);
      setState(() {
        schedules = fetchedSchedules;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  void toggleMotor() async {
    final userId = await SLocalStorage().getUserId();
    print('User ID: $userId');
    try {
      final userIdInt = int.tryParse(userId!);
      if (userIdInt == null) {
        print('Invalid user ID: $userId');
        return;
      }
      final status = await apiService.togglePumpStatus(userIdInt);
      setState(() {
        motorStatus = status == 'on';
      });
    } catch (e) {
      print('Error toggling motor: $e');
    }
  }

  void addSchedule(String startTime, String endTime, String repeat) async {
    final userId = await SLocalStorage().getUserId();
    print(userId);
    try {
      final newSchedule = await apiService.createSchedule({
        'farmerId': int.tryParse('$userId'),
        'startTime': startTime,
        'endTime': endTime,
        'repeat': repeat,
      });
      setState(() {
        schedules.add(newSchedule);
      });
    } catch (e) {
      print(e);
    }
  }

  void deleteSchedule(int id) async {
    try {
      await apiService.deleteSchedule(id);
      setState(() {
        schedules.removeWhere((schedule) => schedule.id == id);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Water Scheduling')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Motor Status
                  MotorStatusWidget(
                    motorStatus: motorStatus,
                    onChanged: (value) => toggleMotor(),
                  ),
                  const SizedBox(height: 20),

                  // Schedule
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Schedule', style: TextStyle(fontSize: 18)),
                      ElevatedButton(
                        child: const Text('Add Schedule'),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => ScheduleDialog(
                            onScheduleAdded: (startTime, endTime, repeat) {
                              addSchedule(startTime, endTime, repeat);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  // List of schedules
                  ...schedules.map((schedule) {
                    return ScheduleListTile(
                      schedule: schedule,
                      onDelete: (id) => deleteSchedule(id),
                    );
                  }),

                  const SizedBox(height: 20),

                  // Water Savings
                  const WaterSavingChart(),
                ],
              ),
            ),
    );
  }
}
