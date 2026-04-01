import 'package:flutter/material.dart';
import 'package:sinchai_sathi/models/schedule_model.dart';
import 'package:sinchai_sathi/services/api_service.dart';
import 'package:sinchai_sathi/utils/colors.dart';
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
    fetchMotorStatus();
  }

  // Fetch schedules working fine
  void fetchSchedules() async {
    final token = await SLocalStorage().getToken();
    if (token == null) return;
    try {
      final fetchedSchedules = await apiService.getSchedules(token);
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
    final token = await SLocalStorage().getToken();
    if (token == null) return;
    try {
      final status = await apiService.getPumpStatus(token);
      print('Motor status fetched successfully');
      setState(() {
        motorStatus = status == true;
      });
    } catch (e) {
      print('Error fetching motor status: $e');
    }
  }

  // Toggling motor working fine
  // Toggling motor
  void toggleMotor() async {
    final token = await SLocalStorage().getToken();
    if (token == null) return;
    
    // Optimistic update
    setState(() {
      motorStatus = !motorStatus;
    });

    try {
      // Send boolean, expect boolean or 'on'/'off'
      // The API service currently returns 'on'/'off' string. 
      // I will update it to return boolean if possible, or just ignore the return if I trust the optimistic update,
      // but better to verify.
      final status = await apiService.togglePumpStatus(token, motorStatus);
      
      // If status is 'on' or true, set to true.
      bool newStatus = status == true;
      
      if (newStatus != motorStatus) {
         // If server disagrees, revert
         setState(() {
           motorStatus = newStatus;
         });
      }
      print('Motor status toggled successfully: $status');
    } catch (e) {
      print('Error toggling motor: $e');
      // Revert on error
      setState(() {
        motorStatus = !motorStatus;
      });
    }
  }

  // Create schedule working fine
  void addSchedule(String startTime, String endTime, String repeat) async {
    final token = await SLocalStorage().getToken();
    if (token == null) return;

    try {
      final newSchedule = await apiService.createSchedule(token, {
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
  void deleteSchedule(String id) async {
    final token = await SLocalStorage().getToken();
    if (token == null) return;
    try {
      await apiService.deleteSchedule(token, id);
      fetchSchedules();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SColors.primary,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text('Irrigation'),
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
