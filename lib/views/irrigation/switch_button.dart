import 'package:flutter/material.dart';

class MotorStatusWidget extends StatelessWidget {
  final bool motorStatus;
  final Function(bool) onChanged;

  const MotorStatusWidget({
    super.key,
    required this.motorStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Motor Status', style: TextStyle(fontSize: 18)),
        Switch(
          value: motorStatus,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
