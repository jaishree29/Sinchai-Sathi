import 'package:flutter/material.dart';
import 'package:sinchai_sathi/sinchai_sathi/utils/crop_details.dart';
import 'package:sinchai_sathi/sinchai_sathi/widgets/list_item.dart';

class CropDetail extends StatelessWidget {
  const CropDetail({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final cropDetails = _getCropDetails(title);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: cropDetails == null
                ? Center(
                    child: Text(
                      'Details for $title not found.',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Optimal Conditions
                      const Text(
                        "Optimal Conditions",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ListItem(
                        leadingIcon: Icons.thermostat,
                        boldText: 'Temperature',
                        trailingText: cropDetails['Temperature'] ?? '',
                      ),
                      const SizedBox(height: 10),
                      ListItem(
                        leadingIcon: Icons.water_drop_rounded,
                        boldText: 'Watering',
                        trailingText: cropDetails['Watering'] ?? '',
                      ),
                      const SizedBox(height: 10),
                      ListItem(
                        leadingIcon: Icons.sunny,
                        boldText: 'Sunlight',
                        trailingText: cropDetails['Sunlight'] ?? '',
                      ),
                      const SizedBox(height: 16),

                      // Cultivation Techniques
                      const Text(
                        "Cultivation Techniques",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ListItem(
                        leadingIcon: Icons.spa_outlined,
                        boldText: 'Soil',
                        trailingText: cropDetails['Soil'] ?? '',
                      ),
                      const SizedBox(height: 10),
                      ListItem(
                        leadingIcon: Icons.space_bar_rounded,
                        boldText: 'Spacing',
                        trailingText: cropDetails['Spacing'] ?? '',
                      ),
                      const SizedBox(height: 10),
                      ListItem(
                        leadingIcon: Icons.data_saver_on_sharp,
                        boldText: 'Depth',
                        trailingText: cropDetails['Dept'] ?? '',
                      ),
                      const SizedBox(height: 16),

                      // Pesticide Information
                      const Text(
                        "Pesticide Information",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ListItem(
                        leadingIcon: Icons.bug_report,
                        boldText: 'Pesticide',
                        trailingText: cropDetails['Pesticide'] ?? '',
                      ),
                      const SizedBox(height: 10),
                      ListItem(
                        leadingIcon: Icons.calendar_today,
                        boldText: 'When to Apply',
                        trailingText: cropDetails['When to App'] ?? '',
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Map<String, String>? _getCropDetails(String cropName) {
    switch (cropName.toLowerCase()) {
      case 'potato':
        return AboutCrops.potato;
      case 'wheat':
        return AboutCrops.wheat;
      case 'tomato':
        return AboutCrops.tomato;
      case 'lettuce':
        return AboutCrops.lettuce;
      default:
        return null;
    }
  }
}
