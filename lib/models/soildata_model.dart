class SoilData {
  final String id;
  final String farmerId;
  final double moisture;
  final double soilHumidity;
  final double airTemperature;
  final double airHumidity;
  final String location;
  final String cropType;
  final DateTime createdAt;
  final double flow;
  final int irrigationDuration;
  final double waterRequired;

  SoilData({
    required this.id,
    required this.farmerId,
    required this.moisture,
    required this.soilHumidity,
    required this.airTemperature,
    required this.airHumidity,
    required this.location,
    required this.cropType,
    required this.createdAt,
    required this.flow,
    required this.irrigationDuration,
    required this.waterRequired,
  });

  factory SoilData.fromJson(Map<String, dynamic> json) {
    return SoilData(
      id: json['id'] ?? '',
      farmerId: json['farmerId'] ?? '',
      moisture: (json['moisture'] ?? 0).toDouble(),
      soilHumidity: (json['soilHumidity'] ?? 0).toDouble(),
      airTemperature: (json['airTemperature'] ?? 0).toDouble(),
      airHumidity: (json['airHumidity'] ?? 0).toDouble(),
      location: json['location'] ?? '',
      cropType: json['cropType'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      flow: (json['flow'] ?? 0).toDouble(),
      irrigationDuration: json['irrigationDuration'] ?? 0,
      waterRequired: (json['waterRequired'] ?? 0).toDouble(),
    );
  }
}
