import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sinchai_sathi/sinchai_sathi/services/api_service.dart';
import 'package:sinchai_sathi/sinchai_sathi/utils/colors.dart';
import 'package:sinchai_sathi/sinchai_sathi/utils/local_storage.dart';

class SoilAnalysis extends StatefulWidget {
  const SoilAnalysis({super.key});

  @override
  State<SoilAnalysis> createState() => _SoilAnalysisState();
}

class _SoilAnalysisState extends State<SoilAnalysis> {
  bool isLoading = true;
  Map<String, dynamic> soilData = {};

  @override
  void initState() {
    super.initState();
    fetchSoilData();
  }

  Future<void> fetchSoilData() async {
    final apiService = ApiService();
    var farmerId = await SLocalStorage().getUserId();

    try {
      final data = await apiService.getSoilAnalysis(int.parse('$farmerId'));
      print("Successfully fetched analysis:");
      setState(() {
        soilData = data;
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
          "npk": {
            "nitrogen": 0.0,
            "phosphorus": 0.0,
            "potassium": 0.0,
          },
          "moisture": 0.0,
          "lowNutrient": "",
          "reportDate": "",
        };
        isLoading = false;
      });
    }
  }

  String formatDate(String date) {
    return DateFormat('dd MMMM yyyy').format(DateTime.parse(date));
  }

  Map<String, dynamic> getSoilHealth() {
    if (soilData['lowNutrient'] == null || soilData['lowNutrient'] == "") {
      return {"status": "not available", "color": Colors.red};
    }
    return soilData['lowNutrient'] == "nitrogen" ||
            soilData['lowNutrient'] == "phosphorus" ||
            soilData['lowNutrient'] == "potassium"
        ? {"status": "Moderate", "color": Colors.orange}
        : {"status": "Bad", "color": Colors.red};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Soil Analysis"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Soil Analysis Status",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildProgressBar("Moisture", soilData['moisture']),
                  _buildProgressBar("Nitrogen", soilData['npk']['nitrogen']),
                  _buildProgressBar(
                      "Phosphorus", soilData['npk']['phosphorus']),
                  _buildProgressBar("Potassium", soilData['npk']['potassium']),
                  _buildNPKStatus(soilData['npk']),
                  const SizedBox(height: 20),
                  const Text(
                    "Soil Health",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        "Your soil status is ",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        getSoilHealth()['status'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: getSoilHealth()['color'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2,
                      children: [
                        _buildGridItem("Moisture", "${soilData['moisture']}%"),
                        _buildGridItem("Crop Type", soilData['cropType']),
                        _buildGridItem("Farmer Name", soilData['farmerName']),
                        _buildGridItem(
                          "Report date",
                          soilData['reportDate'] == ''
                              ? 'No data available'
                              : formatDate(
                                  soilData['reportDate'],
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
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

  Widget _buildNPKStatus(Map<String, dynamic> npk) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Nitrogen: "),
            Text(
              _getNutrientStatus(npk['nitrogen'])['status'],
              style: TextStyle(
                color: _getNutrientStatus(npk['nitrogen'])['color'],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text("Phosphorus: "),
            Text(
              _getNutrientStatus(npk['phosphorus'])['status'],
              style: TextStyle(
                color: _getNutrientStatus(npk['phosphorus'])['color'],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text("Potassium: "),
            Text(
              _getNutrientStatus(npk['potassium'])['status'],
              style: TextStyle(
                color: _getNutrientStatus(npk['potassium'])['color'],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Map<String, dynamic> _getNutrientStatus(dynamic value) {
    double? doubleValue = value is int ? value.toDouble() : value as double?;
    if (doubleValue == null || doubleValue == 0.0) {
      return {"status": "No data available", "color": Colors.grey};
    }
    if (doubleValue >= 15) {
      return {"status": "High", "color": Colors.green};
    }
    if (doubleValue >= 10) {
      return {"status": "Medium", "color": Colors.orange};
    }
    return {"status": "Low", "color": Colors.red};
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
