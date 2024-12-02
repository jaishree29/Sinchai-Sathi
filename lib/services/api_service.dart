import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sinchai_sathi/utils/api_endpoints.dart';
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'https://sichaisathi.onrender.com';

  Future<User> signup(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$createFarmer'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      print(response.body.toString());
      throw Exception('Failed to signup');
    }
  }

  Future<User> login(String contactNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$getFarmer'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'contactNumber': contactNumber}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      print(response.body.toString());
      throw Exception('Failed to login');
    }
  }
}
