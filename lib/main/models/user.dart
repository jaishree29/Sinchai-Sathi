class User {
  final int? id;
  final String name;
  final String contactNumber;
  final String location;
  final String cropType;
  final int waterPumpWatt;
  final String irrigationState;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    required this.name,
    required this.contactNumber,
    required this.location,
    required this.cropType,
    required this.waterPumpWatt,
    required this.irrigationState,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      contactNumber: json['contactNumber'],
      location: json['location'],
      cropType: json['cropType'],
      waterPumpWatt: json['waterPumpWatt'],
      irrigationState: json['irrigationState'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contactNumber': contactNumber,
      'location': location,
      'cropType': cropType,
      'waterPumpWatt': waterPumpWatt,
    };
  }
}
