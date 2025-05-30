import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sinchai_sathi/models/schedule_model.dart';
import 'package:sinchai_sathi/utils/api_endpoints.dart';
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'https://ladybird-frank-deeply.ngrok-free.app';

  //Sign Up is working fine
  Future<User> signup(Farmer farmer) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$createFarmer'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(farmer.toJson()),
    );

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      // Extract tokens from headers
      final token = response.headers['authorization'];
      final refreshToken = response.headers['refresh-token'];

      if (token == null || refreshToken == null) {
        throw Exception('Authentication tokens not received');
      }

      return User.fromJson({
        ...responseBody,
        'token': token.replaceFirst('Bearer ', ''),
        'refreshToken': refreshToken,
      });
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(errorBody['error'] ?? 'Failed to signup');
    }
  }

  Future<User> login(String contactNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$getFarmer'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'contactNumber': contactNumber}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return User.fromJson({
        ...responseBody,
        'token': response.headers['authorization']?.replaceFirst('Bearer ', ''),
        'refreshToken': response.headers['refresh-token'],
      });
    } else if (response.statusCode == 404) {
      throw Exception('Farmer not found');
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  //Pump Status working fine
  Future<String> togglePumpStatus(int farmerId, bool motorStatus) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$changePumpStatus/$farmerId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'power': motorStatus ? 1 : 0}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['irrigationState'];
    } else {
      print(response.body.toString());
      throw Exception('Failed to toggle pump status');
    }
  }

  //Get pump status working fine
  Future<String> getPumpStatus(int farmerId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$pumpStatus/$farmerId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['irrigationState'];
    } else {
      print(response.body.toString());
      throw Exception('Failed to get pump status');
    }
  }

  //Get Schedules working fine
  Future<List<Schedule>> getSchedules(int farmerId) async {
    final response = await http.get(Uri.parse('$baseUrl/$schedule/$farmerId'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> schedulesData = data['schedules'];
      return schedulesData.map((json) => Schedule.fromJson(json)).toList();
    } else {
      print(response.body.toString());
      throw Exception('Failed to load schedules');
    }
  }

  //Create Schedule is working fine
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
      print('Status code: ${response.statusCode}');
      throw Exception('Failed to create schedule');
    }
  }

  //Update Schedule not functional yet
  Future<Schedule> updateSchedule(
      int id, Map<String, dynamic> scheduleData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$schedule/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(scheduleData),
    );
    if (response.statusCode == 200) {
      return Schedule.fromJson(jsonDecode(response.body));
    } else {
      print(response.body.toString());
      print('Status code: ${response.statusCode}');
      throw Exception('Failed to update schedule');
    }
  }

  //Delete Schedule working fine
  Future<void> deleteSchedule(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$schedule/$id'));
    if (response.statusCode == 200) {
      throw Exception('Schedule deleted successfully!');
    }
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
      body: jsonEncode({'farmerId': farmerId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(
          'Failed to load soil analysis data. Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to load soil analysis data');
    }
  }

  //fetch weather data is working fine
  Future<Map<String, dynamic>> fetchWeatherData(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/weather?lat=$lat&lon=$lon'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.body.toString());
      throw Exception('Failed to fetch weather data');
    }
  }
}
