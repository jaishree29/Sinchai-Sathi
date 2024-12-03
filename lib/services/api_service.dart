import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sinchai_sathi/models/schedule_model.dart';
import 'package:sinchai_sathi/utils/api_endpoints.dart';
import 'package:sinchai_sathi/utils/local_storage.dart';
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'https://sichaisathi.onrender.com';

  //Sign Up
  Future<User> signup(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$createFarmer'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      final farmerId = responseBody['id'];
      await SLocalStorage().saveUserId(farmerId.toString());
      return User.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      print(response.body.toString());
      throw Exception('User already exists');
    } else {
      print(response.body.toString());
      throw Exception('Failed to signup');
    }
  }

  //Login
  Future<User> login(String contactNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$getFarmer'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'contactNumber': contactNumber}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final farmerId = responseBody['id'];
      await SLocalStorage().saveUserId(farmerId.toString());
      return User.fromJson(responseBody);
    } else {
      print(response.body.toString());
      throw Exception('Failed to login');
    }
  }

  //Pump Status
  Future<String> togglePumpStatus(int farmerId) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$changePumpStatus/1'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['irrigationState'];
    } else {
      print(response.body.toString());
      throw Exception('Failed to toggle pump status');
    }
  }

  //Get Schedules
  Future<List<Schedule>> getSchedules(int farmerId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/$schedule?farmerId=$farmerId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Schedule.fromJson(json)).toList();
    } else {
      print(response.body.toString());
      throw Exception('Failed to load schedules');
    }
  }

  //Create Schedule
  Future<Schedule> createSchedule(Map<String, dynamic> scheduleData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$schedule'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(scheduleData),
    );
    if (response.statusCode == 201) {
      return Schedule.fromJson(jsonDecode(response.body));
    } else {
      print(response.body.toString());
      throw Exception('Failed to create schedule');
    }
  }

  //Delete Schedule
  Future<void> deleteSchedule(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/irrigation/schedule/$id'));
    if (response.statusCode != 204) {
      print(response.body.toString());
      throw Exception('Failed to delete schedule');
    }
  }

  //get soil data
  Future<Map<String, dynamic>> getSoilAnalysis(int farmerId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$getSoil/$farmerId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(farmerId),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.body.toString());
      throw Exception('Failed to load soil analysis data');
    }
  }
}
