import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sinchai_sathi/models/weather_model.dart';
import 'package:sinchai_sathi/services/api_service.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/utils/local_storage.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late String formattedDate;
  late Future<WeatherData> weatherDataFuture;
  String token = '';

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat.yMMMMEEEEd().format(DateTime.now());
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      final storedToken = await SLocalStorage().getToken();
      if (mounted) {
        setState(() {
          token = storedToken ?? '';
          weatherDataFuture = _loadWeatherData();
        });
      }
      print('Token from storage: $storedToken');
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<WeatherData> _loadWeatherData() async {
    if (token.isEmpty) {
      final storedToken = await SLocalStorage().getToken();
      if (storedToken == null || storedToken.isEmpty) {
        throw Exception('No authentication token available');
      }
      token = storedToken;
    }
    return ApiService().fetchWeatherForUser(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SColors.primary,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text('Weather Forecasting'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<WeatherData>(
          future: weatherDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            } else {
              final weatherData = snapshot.data!;
              final location = weatherData.location;
              final current = weatherData.current;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${current.temperature}°C",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${location.name}, ${location.region}\n$formattedDate",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          current.weatherIcons.first,
                          width: 75,
                          height: 100,
                        ),
                        Text(
                          current.weatherDescriptions.first,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // const SizedBox(width: 20,)
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Weather details
                    _buildWeatherDetail('Feels Like', '${current.feelslike}°C'),
                    _buildWeatherDetail('Humidity', '${current.humidity}%'),
                    _buildWeatherDetail(
                        'Wind Speed', '${current.windSpeed} km/h'),
                    _buildWeatherDetail('Pressure', '${current.pressure} hPa'),
                    _buildWeatherDetail('UV Index', current.uvIndex.toString()),
                    _buildWeatherDetail(
                        'Visibility', '${current.visibility} km'),
                    _buildWeatherDetail(
                        'Precipitation', '${current.precip} mm'),

                    const SizedBox(height: 16),
                    const Text(
                      "Sun & Moon",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    _buildSunMoonDetail('Sunrise', current.astro.sunrise),
                    _buildSunMoonDetail('Sunset', current.astro.sunset),
                    _buildSunMoonDetail('Moon Phase', current.astro.moonPhase),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSunMoonDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            label.contains('Sun') ? Icons.wb_sunny : Icons.nightlight_round,
            color: Colors.orange,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
