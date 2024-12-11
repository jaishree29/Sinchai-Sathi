import 'package:flutter/material.dart';
import 'package:sinchai_sathi/sinchai_sathi/utils/colors.dart';

class GridItem extends StatelessWidget {
  final String label;
  final String value;

  const GridItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: SColors.primary.withOpacity(0.2),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
