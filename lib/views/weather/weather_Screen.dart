import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  final String cityName = "Gurugram";
  final int currentTemp = 30;
  final String currentCondition = "Mostly Clear";
  final int highTemp = 18;
  final int lowTemp = 13;

  // Example five-day forecast data
  final List<Map<String, dynamic>> forecast = [
    {"day": "Mon", "icon": Icons.wb_sunny, "temp": "32°C"},
    {"day": "Tue", "icon": Icons.cloud, "temp": "28°C"},
    {"day": "Wed", "icon": Icons.wb_cloudy, "temp": "25°C"},
    {"day": "Thu", "icon": Icons.grain, "temp": "22°C"},
    {"day": "Fri", "icon": Icons.wb_sunny, "temp": "30°C"},
  ];

  WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$cityName, $currentTemp°C",
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.wb_sunny,
                    size: 100,
                    color: Colors.orange,
                  ),
                  Text(
                    currentCondition,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // High and Low Temperature
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "H - $highTemp°C",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  "L - $lowTemp°C",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 5-Day Forecast Header
            const Text(
              "5-Day Forecast",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // 5-Day Forecast List
            Expanded(
              child: ListView.builder(
                itemCount: forecast.length,
                itemBuilder: (context, index) {
                  final dayForecast = forecast[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              dayForecast["icon"],
                              size: 30,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              dayForecast["day"],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Text(
                          dayForecast["temp"],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
