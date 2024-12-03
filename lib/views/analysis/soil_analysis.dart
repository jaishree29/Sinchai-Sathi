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
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        getSoilHealth(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
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
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildProgressBar(String label, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label: ${value.toString()}%"),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: (value as double) / 100,
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

  String _getNutrientStatus(dynamic value) {
    if (value == null || value == 0.0) return "No data available";
    if (value >= 15) return "High";
    if (value >= 10) return "Medium";
    return "Low";
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


// import 'package:flutter/material.dart';
// import 'package:sinchai_sathi/services/api_service.dart';
// import 'package:sinchai_sathi/utils/local_storage.dart';
// import 'package:sinchai_sathi/views/analysis/npk_status.dart';
// import 'package:sinchai_sathi/views/analysis/progress_bar.dart';
// import 'package:sinchai_sathi/widgets/grid_item.dart';

// class SoilAnalysis extends StatefulWidget {
//   const SoilAnalysis({super.key});

//   @override
//   State<SoilAnalysis> createState() => _SoilAnalysisState();
// }

// class _SoilAnalysisState extends State<SoilAnalysis> {
//   bool isLoading = true;
//   Map<String, dynamic> soilData = {};

//   @override
//   void initState() {
//     super.initState();
//     fetchSoilData();
//   }

//   Future<void> fetchSoilData() async {
//     final apiService = ApiService();
//     var farmerId = await SLocalStorage().getUserId();

//     try {
//       final data = await apiService.getSoilAnalysis(int.parse('$farmerId'));
//       setState(() {
//         soilData = data;
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error fetching soil analysis: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   String getSoilHealth() {
//     if (soilData['lowNutrient'] == null) return "Good";
//     return soilData['lowNutrient'] == "nitrogen" ||
//             soilData['lowNutrient'] == "phosphorus" ||
//             soilData['lowNutrient'] == "potassium"
//         ? "Moderate"
//         : "Bad";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Soil Analysis"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Soil Analysis Status",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   ProgressBar(
//                       label: "Moisture", value: soilData['moisture'] ?? 25.0),
//                   ProgressBar(
//                       label: "Nitrogen",
//                       value: soilData['npk']?['nitrogen'] ?? 8.0),
//                   ProgressBar(
//                       label: "Phosphorus",
//                       value: soilData['npk']?['phosphorus'] ?? 10.0),
//                   ProgressBar(
//                       label: "Potassium",
//                       value: soilData['npk']?['potassium'] ?? 13.0),
//                   NPKStatus(npk: soilData['npk'] ?? {}),
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Soil Health",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       const Text(
//                         "Your soil status is ",
//                         style: TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                       Text(
//                         getSoilHealth(),
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Expanded(
//                     child: GridView.count(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                       childAspectRatio: 1.5,
//                       children: [
//                         GridItem(
//                             label: "Moisture",
//                             value: "${soilData['moisture'] ?? '25'}%"),
//                         GridItem(
//                             label: "Crop Type",
//                             value: soilData['cropType'] ?? 'Wheat'),
//                         GridItem(
//                             label: "Farmer Name",
//                             value: soilData['farmerName'] ?? 'N/A'),
//                         GridItem(
//                             label: "Location",
//                             value: soilData['location'] ?? 'N/A'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

