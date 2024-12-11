import 'package:flutter/material.dart';
import 'package:sinchai_sathi/sinchai_sathi/models/schedule_model.dart';
import 'package:sinchai_sathi/sinchai_sathi/services/api_service.dart';
import 'package:sinchai_sathi/sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/sinchai_sathi/utils/local_storage.dart';
import 'package:sinchai_sathi/sinchai_sathi/views/irrigation/schedule_list_tile.dart';
import 'package:sinchai_sathi/sinchai_sathi/views/irrigation/switch_button.dart';
import 'package:sinchai_sathi/sinchai_sathi/views/irrigation/water_saving_chart.dart';
import 'package:sinchai_sathi/sinchai_sathi/views/irrigation/schedule_dialog.dart';

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
    fetchMotorStatus();
  }

  // Fetch schedules working fine
  void fetchSchedules() async {
    try {
      final fetchedSchedules = await apiService.getSchedules(1);
      print('Schedules fetched successfully');
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

  // Motor status working fine
  void fetchMotorStatus() async {
    try {
      final status = await apiService.getPumpStatus(1);
      print('Motor status fetched successfully');
      setState(() {
        motorStatus = status == 'on';
      });
    } catch (e) {
      print('Error fetching motor status: $e');
    }
  }

  // Toggling motor working fine
  void toggleMotor() async {
    final userId = await SLocalStorage().getUserId();
    print('User ID: $userId');
    try {
      final userIdInt = int.tryParse(userId!);
      if (userIdInt == null) {
        print('Invalid user ID: $userId');
        return;
      }
      setState(() {
        motorStatus = !motorStatus;
      });
      final status = await apiService.togglePumpStatus(userIdInt, motorStatus);
      print('Motor status toggled successfully: $status');
    } catch (e) {
      print('Error toggling motor: $e');
      setState(() {
        motorStatus = !motorStatus;
      });
    }
  }

  // Create schedule working fine
  void addSchedule(String startTime, String endTime, String repeat) async {
    final userId = await SLocalStorage().getUserId();
    print('User ID from local storage: $userId');

    try {
      final userIdInt = int.tryParse(userId!);

      if (userIdInt == null) {
        print('Invalid user ID: $userId');
        return;
      }

      final newSchedule = await apiService.createSchedule({
        'farmerId': userIdInt,
        'startTime': startTime,
        'endTime': endTime,
        'repeat': repeat,
      });

      setState(() {
        schedules.add(newSchedule);
      });
    } catch (e) {
      print('Error creating schedule: $e');
    }
  }

  // Delete Schedule working fine
  void deleteSchedule(int id) async {
    try {
      await apiService.deleteSchedule(id);
      fetchSchedules();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Scheduling'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchSchedules,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
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
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: SColors.primary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => ScheduleDialog(
                              onScheduleAdded: (startTime, endTime, repeat) {
                                addSchedule(startTime, endTime, repeat);
                              },
                            ),
                          ),
                          child: const Text('Add Schedule'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

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
            ),
    );
  }
}
