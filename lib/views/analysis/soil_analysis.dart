import 'package:flutter/material.dart';
import 'package:sinchai_sathi/services/api_service.dart';
import 'package:sinchai_sathi/utils/local_storage.dart';
import 'package:sinchai_sathi/views/analysis/npk_status.dart';
import 'package:sinchai_sathi/views/analysis/progress_bar.dart';
import 'package:sinchai_sathi/widgets/grid_item.dart';

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
          "cropType": "Wheat",
          "npk": {
            "nitrogen": 12.0,
            "phosphorus": 8.0,
            "potassium": 5.0,
          },
          "moisture": 25.0,
          "lowNutrient": "phosphorus",
          "reportDate": "2024-01-01T00:00:00.000Z",
        };
        isLoading = false;
      });
    }
  }

  String getSoilHealth() {
    if (soilData['lowNutrient'] == null) return "Good";
    return soilData['lowNutrient'] == "nitrogen" ||
            soilData['lowNutrient'] == "phosphorus" ||
            soilData['lowNutrient'] == "potassium"
        ? "Moderate"
        : "Bad";
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
                  ProgressBar(label: "Moisture", value: soilData['moisture']),
                  ProgressBar(
                      label: "Nitrogen", value: soilData['npk']['nitrogen']),
                  ProgressBar(
                      label: "Phosphorus",
                      value: soilData['npk']['phosphorus']),
                  ProgressBar(
                      label: "Potassium", value: soilData['npk']['potassium']),
                  NPKStatus(npk: soilData['npk']),
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
                        getSoilHealth(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
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
                        GridItem(
                            label: "Moisture",
                            value: "${soilData['moisture']}%"),
                        GridItem(
                            label: "Crop Type", value: soilData['cropType']),
                        GridItem(
                            label: "Farmer Name",
                            value: soilData['farmerName']),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
