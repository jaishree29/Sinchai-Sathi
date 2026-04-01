import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
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
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://floor-bot-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref();
  StreamSubscription<DatabaseEvent>? _soilStream;
  DateTime? _lastCallTime;
  DateTime? _lowMoistureStartTime;
  String? _contactNumber;
  Timer? _monitorTimer;

  @override
  void initState() {
    super.initState();
    _fetchContactNumber();
    fetchSoilData();
    _setupRealtimeListener();
    _timer = Timer.periodic(const Duration(minutes: 30), (timer) {
      fetchSoilData();
    });
    // Monitor for consecutive low moisture
    _monitorTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_lowMoistureStartTime != null) {
        final duration = DateTime.now().difference(_lowMoistureStartTime!);
        if (duration.inSeconds >= 20) {
          _checkAndTriggerIVR();
        }
      }
    });
  }

  Future<void> _fetchContactNumber() async {
    final token = await SLocalStorage().getToken();
    if (token != null) {
      try {
        final user = await ApiService().getFarmerDetails(token);
        setState(() {
          _contactNumber = user.farmer.contactNumber;
        });
      } catch (e) {
        debugPrint('Error fetching contact number: $e');
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _monitorTimer?.cancel();
    _soilStream?.cancel();
    super.dispose();
  }

  void _setupRealtimeListener() async {
    _soilStream = _database.child('Sensor').onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null && mounted) {
        setState(() {
          if (data['MoistureRaw'] != null) {
            soilData['moisture'] = data['MoistureRaw'];
            _handleMoistureChange(data['MoistureRaw']);
          }
          if (data['Temperature'] != null) {
            soilData['airTemperature'] = data['Temperature'];
          }
        });
      }
    });
  }

  void _handleMoistureChange(dynamic moisture) {
    double val = moisture is int
        ? moisture.toDouble()
        : (moisture as double? ?? 0.0);
    
    if (val > 300) {
      _lowMoistureStartTime ??= DateTime.now();
    } else {
      _lowMoistureStartTime = null;
    }
  }

  void _checkAndTriggerIVR() async {
    final now = DateTime.now();
    if (_lastCallTime == null ||
        now.difference(_lastCallTime!) > const Duration(hours: 1)) {
      _lastCallTime = now;
      if (_contactNumber != null) {
        final token = await SLocalStorage().getToken();
        if (token != null) {
          try {
            await ApiService().initiateIVRCall(token, _contactNumber!);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'Low moisture detected for 1 min! Initiating IVR call...')),
              );
            }
          } catch (e) {
            debugPrint('Error initiating IVR call: $e');
          }
        }
      }
    }
  }

  Future<void> fetchSoilData() async {
    final apiService = ApiService();
    var token = await SLocalStorage().getToken();
    var storedCropType = await SLocalStorage().getCropType();
    var storedLocation = await SLocalStorage().getLocation();

    try {
      final data = await apiService.getSoilAnalysis(token!);
      var farmerName = await SLocalStorage().getUserName();

      setState(() {
        soilData = {
          'id': data.id,
          'farmerName': farmerName ?? 'Unknown Farmer',
          'location': storedLocation ?? data.location,
          'cropType': storedCropType ?? data.cropType,
          'moisture': soilData['moisture'] ?? data.moisture,
          'airTemperature': soilData['airTemperature'] ?? data.airTemperature,
        };
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching soil analysis: $e");
      var farmerId = await SLocalStorage().getUserId();
      var farmerName = await SLocalStorage().getUserName();
      setState(() {
        soilData = {
          "id": farmerId,
          "farmerName": farmerName,
          "location": storedLocation ?? "No data available",
          "cropType": storedCropType ?? "No data available",
          "moisture": soilData['moisture'] ?? 0.0,
          "airTemperature": soilData['airTemperature'] ?? 0.0,
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
                    _buildProgressBar("Moisture (Raw)", soilData['moisture'], max: 2000), // Assuming raw value max around 1024-4096? 
                    _buildProgressBar("Temperature (°C)", soilData['airTemperature']),
                    
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
                        _buildGridItem("Moisture", "${soilData['moisture']}"),
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

  Widget _buildProgressBar(String label, dynamic value, {double max = 100.0}) {
    double? doubleValue = value is int ? value.toDouble() : value as double?;
    // If max is not 100, normalize
    double progress = 0.0;
    if (doubleValue != null) {
       progress = doubleValue / max;
       if (progress > 1.0) progress = 1.0;
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label: ${doubleValue?.toStringAsFixed(1) ?? 'N/A'}"),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress,
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
