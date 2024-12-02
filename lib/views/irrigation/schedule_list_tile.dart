import 'package:flutter/material.dart';
import 'package:sinchai_sathi/models/schedule_model.dart';

class ScheduleListTile extends StatelessWidget {
  final Schedule schedule;
  final Function(int) onDelete;

  const ScheduleListTile({
    super.key,
    required this.schedule,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Start: ${schedule.startTime} - End: ${schedule.endTime}'),
      subtitle: Text('Repeat: ${schedule.repeat}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => onDelete(schedule.id),
      ),
    );
  }
}
