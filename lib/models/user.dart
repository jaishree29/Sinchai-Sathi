class Farmer {
  String id;
  String name;
  String contactNumber;
  String location;
  String cropType;
  int waterPumpWatt;
  String irrigationState;
  DateTime createdAt;
  DateTime updatedAt;

  Farmer({
    required this.id,
    required this.name,
    required this.contactNumber,
    required this.location,
    required this.cropType,
    required this.waterPumpWatt,
    required this.irrigationState,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      id: json['id'] ?? json['_id'],
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
      'irrigationState': irrigationState,
    };
  }
}

class User {
  Farmer farmer;
  String message;
  String? token;
  String? refreshToken;

  User({
    required this.farmer,
    required this.message,
    this.token,
    this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      farmer: Farmer.fromJson(json['farmer']),
      message: json['message'],
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  @override
  String toString() {
    return 'User(farmer: $farmer, message: $message, token: $token, refreshToken: $refreshToken)';
  }
}
