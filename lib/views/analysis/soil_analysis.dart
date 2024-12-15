import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sinchai_sathi/services/api_service.dart';
import 'package:sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/utils/local_storage.dart';

class SoilAnalysis extends StatefulWidget {
  const SoilAnalysis({super.key});

  @override
  State<SoilAnalysis> createState() => _SoilAnalysisState();
}

class _SoilAnalysisState extends State<SoilAnalysis> {
  bool isLoading = true;
  Map<String, dynamic> soilData = {};
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchSoilData();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchSoilData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchSoilData() async {
    final apiService = ApiService();
    var farmerId = await SLocalStorage().getUserId();

    try {
      final data = await apiService.getSoilAnalysis(int.parse('$farmerId'));
      print("Successfully fetched analysis:");
      setState(() {
        soilData = {
          ...data,
          'waterRequired': (data['waterRequired'] ?? 0) / 1000,
          'irrigationDuration': (data['irrigationDuration'] / 60000 ?? 0).toInt(),
        };
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching soil analysis: $e");
      var farmerId = await SLocalStorage().getUserId();
      var farmerName = await SLocalStorage().getUserName();
      setState(() {
        soilData = {
          "id": farmerId,
          "farmerName": farmerName,
          "location": "No data available",
          "cropType": "No data available",
          "moisture": 0.0,
          "humidity": 0.0,
          "flow": 0,
          "irrigationDuration": 0,
          "waterRequired": 0,
        };
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Soil Analysis"),
        backgroundColor: SColors.primary,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Analysis Status",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildProgressBar("Moisture%", soilData['moisture']),
                    _buildProgressBar("Humidity%", soilData['humidity']),
                    _buildProgressBar("Flow of Water (mL/s)", soilData['flow']),
                    const SizedBox(height: 20),
                    const Text(
                      "Your plant needs:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Water Requirement: ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: soilData['waterRequired'] != null
                                ? '${soilData['waterRequired']} L'
                                : 'N/A',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Total irrigation duration: ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: soilData['irrigationDuration'] != null
                                ? '${soilData['irrigationDuration']} min'
                                : 'N/A',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "About crop:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2,
                      children: [
                        _buildGridItem("Moisture", "${soilData['moisture']}%"),
                        _buildGridItem("Crop Type", soilData['cropType']),
                        _buildGridItem("Farmer Name", soilData['farmerName']),
                        _buildGridItem("Location", soilData['location']),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildProgressBar(String label, dynamic value) {
    double? doubleValue = value is int ? value.toDouble() : value as double?;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label: ${doubleValue?.toStringAsFixed(1) ?? 'N/A'}"),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: doubleValue != null ? (doubleValue / 100) : 0.0,
          minHeight: 8,
          backgroundColor: Colors.grey.shade300,
          color: SColors.primary,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildGridItem(String label, String value) {
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
