import 'package:flutter/material.dart';

class ScheduleDialog extends StatefulWidget {
  final Function(String, String, String) onScheduleAdded;

  const ScheduleDialog({super.key, required this.onScheduleAdded});

  @override
  State<ScheduleDialog> createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  List<String> _selectedDays = [];

  void _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDateTime) {
      setState(() {
        _startDateTime = picked;
      });
    }
  }

  void _selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && _startDateTime != null) {
      setState(() {
        _startDateTime = DateTime(
          _startDateTime!.year,
          _startDateTime!.month,
          _startDateTime!.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  void _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDateTime) {
      setState(() {
        _endDateTime = picked;
      });
    }
  }

  void _selectEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && _endDateTime != null) {
      setState(() {
        _endDateTime = DateTime(
          _endDateTime!.year,
          _endDateTime!.month,
          _endDateTime!.day,
          picked.hour,
          picked.minute,
        );
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
            title: const Text('Start Date'),
            trailing: Text(_startDateTime?.toString().split(' ')[0] ?? 'Select Date'),
            onTap: _selectStartDate,
          ),
          ListTile(
            title: const Text('Start Time'),
            trailing: Text(_startDateTime != null ? _startDateTime!.toString().split(' ')[1].substring(0, 5) : 'Select Time'),
            onTap: _selectStartTime,
          ),
          ListTile(
            title: const Text('End Date'),
            trailing: Text(_endDateTime?.toString().split(' ')[0] ?? 'Select Date'),
            onTap: _selectEndDate,
          ),
          ListTile(
            title: const Text('End Time'),
            trailing: Text(_endDateTime != null ? _endDateTime!.toString().split(' ')[1].substring(0, 5) : 'Select Time'),
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
            if (_startDateTime != null &&
                _endDateTime != null &&
                _selectedDays.isNotEmpty) {
              final startTime = _startDateTime!.toIso8601String();
              final endTime = _endDateTime!.toIso8601String();
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