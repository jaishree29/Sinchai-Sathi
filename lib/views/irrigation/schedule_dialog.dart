import 'package:flutter/material.dart';

class ScheduleDialog extends StatefulWidget {
  final Function(String, String, String) onScheduleAdded;

  const ScheduleDialog({super.key, required this.onScheduleAdded});

  @override
  State<ScheduleDialog> createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  List<String> _selectedDays = [];

  void _selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  void _selectEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  void _toggleDay(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }
    });
  }

  void _selectAllDays() {
    setState(() {
      if (_selectedDays.length == 7) {
        _selectedDays.clear();
      } else {
        _selectedDays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Schedule'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Start Time'),
            trailing: Text(_startTime?.format(context) ?? 'Select Time'),
            onTap: _selectStartTime,
          ),
          ListTile(
            title: const Text('End Time'),
            trailing: Text(_endTime?.format(context) ?? 'Select Time'),
            onTap: _selectEndTime,
          ),
          const Divider(),
          Wrap(
            spacing: 8.0,
            children: [
              for (var day in ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'])
                FilterChip(
                  label: Text(day),
                  selected: _selectedDays.contains(day),
                  onSelected: (_) => _toggleDay(day),
                ),
              FilterChip(
                label: const Text('Select All'),
                selected: _selectedDays.length == 7,
                onSelected: (_) => _selectAllDays(),
              ),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_startTime != null &&
                _endTime != null &&
                _selectedDays.isNotEmpty) {
              final startTime = _startTime!.format(context);
              final endTime = _endTime!.format(context);
              final repeat = _selectedDays.join(', ');
              widget.onScheduleAdded(startTime, endTime, repeat);
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
