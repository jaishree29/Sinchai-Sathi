import 'package:flutter/material.dart';
import 'package:sinchai_sathi/utils/colors.dart';

class ProgressBar extends StatelessWidget {
  final String label;
  final double value;

  const ProgressBar({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label: ${value.toString()}%"),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: value / 100,
          minHeight: 8,
          backgroundColor: Colors.grey.shade300,
          color: SColors.primary,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
