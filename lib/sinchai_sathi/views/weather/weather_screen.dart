import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sinchai_sathi/sinchai_sathi/services/api_service.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService().fetchWeatherData(
            28.5726, 76.9344),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final data = snapshot.data!;
            final cityName = data['message'] ?? 'Farrukh Nagar';
            final currentTemp =
                data['forecasts'][0]['extra']['main']['temp'] ?? 17.0;
            final currentCondition = data['forecasts'][0]['weather'] ?? 'Sunny';
            final highTemp =
                data['forecasts'][0]['extra']['main']['temp_max'] ?? 0.0;
            final lowTemp =
                data['forecasts'][0]['extra']['main']['temp_min'] ?? 0.0;
            final forecast = data['forecasts'] ?? [];
            final currentWeatherIcon = _getWeatherIcon(
                data['forecasts'][0]['extra']['weather'][0]['icon']);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$cityName, ${currentTemp.toStringAsFixed(0)}°C",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          currentWeatherIcon,
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
