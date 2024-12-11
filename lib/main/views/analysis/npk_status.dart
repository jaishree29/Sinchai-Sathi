import 'package:flutter/material.dart';

class NPKStatus extends StatelessWidget {
  final Map<String, dynamic> npk;

  const NPKStatus({super.key, required this.npk});

  String _getNutrientStatus(dynamic value) {
    if (value == null || value == 0.0) return "No data available";
    if (value >= 15) return "High";
    if (value >= 10) return "Medium";
    return "Low";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Nitrogen: "),
            Text(
              _getNutrientStatus(npk['nitrogen']),
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text("Phosphorus: "),
            Text(
              _getNutrientStatus(npk['phosphorus']),
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text("Potassium: "),
            Text(
              _getNutrientStatus(npk['potassium']),
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
