import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sinchai_sathi/sinchai_sathi/models/schedule_model.dart';
import 'package:sinchai_sathi/sinchai_sathi/utils/colors.dart';

class ScheduleListTile extends StatelessWidget {
  final Schedule schedule;
  final Function(int) onDelete;

  const ScheduleListTile({
    super.key,
    required this.schedule,
    required this.onDelete,
  });

  String formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      final dateFormat = DateFormat('dd MMM yyyy');
      final timeFormat = DateFormat('hh:mm a');
      return '${dateFormat.format(dateTime)} - ${timeFormat.format(dateTime)}';
    } catch (e) {
      print('Error parsing date: $e');
      return 'Invalid Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: SColors.primary)),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start: ${formatDateTime(schedule.startTime)}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'End: ${formatDateTime(schedule.endTime)}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Repeat: ${schedule.repeat}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => onDelete(schedule.id),
            ),
          ],
        ),
      ),
    );
  }
}
