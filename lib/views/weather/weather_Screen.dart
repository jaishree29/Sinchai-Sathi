import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sinchai_sathi/services/api_service.dart';

class WeatherScreen extends StatelessWidget {


  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService().fetchWeatherData(34, -34),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final data = snapshot.data!;
            final cityName = data['cityName'] ?? 'Farrukh Nagar';
            final currentTemp = data['currentTemp'] ?? 0.0;
            final currentCondition = data['currentCondition'] ?? 'Unknown';
            final highTemp = data['highTemp'] ?? 0.0;
            final lowTemp = data['lowTemp'] ?? 0.0;
            final forecast = data['forecasts'] ?? [];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$cityName, ${currentTemp.toStringAsFixed(0)}°C",
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
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
                        "H - ${highTemp.toStringAsFixed(0)}°C",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "L - ${lowTemp.toStringAsFixed(0)}°C",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 5-Day Forecast Heading
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
                        final date = DateTime.parse(dayForecast['date']);
                        final dayOfWeek = DateFormat('E').format(date);
                        final temp = dayForecast['extra']['main']['temp']
                            .toStringAsFixed(0);
                        final weatherIcon = _getWeatherIcon(
                            dayForecast['extra']['weather'][0]['icon']);

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
                                    weatherIcon,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    dayOfWeek,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Text(
                                "$temp°C",
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
            );
          }
        },
      ),
    );
  }

  IconData _getWeatherIcon(String iconCode) {
    switch (iconCode) {
      case '01d':
      case '01n':
        return Icons.wb_sunny;
      case '02d':
      case '02n':
        return Icons.cloud;
      case '03d':
      case '03n':
        return Icons.cloud;
      case '04d':
      case '04n':
        return Icons.cloud;
      case '09d':
      case '09n':
        return Icons.grain;
      case '10d':
      case '10n':
        return Icons.grain;
      case '11d':
      case '11n':
        return Icons.flash_on;
      case '13d':
      case '13n':
        return Icons.ac_unit;
      case '50d':
      case '50n':
        return Icons.blur_on;
      default:
        return Icons.wb_sunny;
    }
  }
}
