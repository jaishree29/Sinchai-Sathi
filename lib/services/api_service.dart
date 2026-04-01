import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sinchai_sathi/models/schedule_model.dart';
import 'package:sinchai_sathi/models/soildata_model.dart';
import 'package:sinchai_sathi/models/weather_model.dart';
import 'package:sinchai_sathi/utils/api_endpoints.dart';
import 'package:sinchai_sathi/utils/local_storage.dart';
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'https://ladybird-frank-deeply.ngrok-free.app';



  //Sign Up
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
      // Extracting tokens from headers
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
      Uri.parse('$baseUrl/$loginFarmer'),
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

  Future<User> getFarmerDetails(String token) async {
    if (token.isEmpty) {
      throw Exception('Token is empty');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/$getFarmer'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return User.fromJson(responseBody);
    } else if (response.statusCode == 404) {
      throw Exception('Farmer not found');
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  //Pump Status working fine
  Future<bool> togglePumpStatus(String token, bool motorStatus) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$changePumpStatus/0'), // ID ignored by server but required by route
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({'power': motorStatus}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['status'] == true ? true : false;
    } else {
      debugPrint(response.body.toString());
      throw Exception('Failed to toggle pump status');
    }
  }

  //Get pump status working fine
  Future<bool> getPumpStatus(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$pumpStatus/0'), // ID ignored by server but required by route
      headers: {
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['status'] == true ? true : false;
    } else {
      debugPrint(response.body.toString());
      throw Exception('Failed to get pump status');
    }
  }

  //Get Schedules working fine
  Future<List<Schedule>> getSchedules(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$schedule'),
      headers: {
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> schedulesData = data['data']; // Server returns { "message": ..., "data": [...] } usually, checking controller...
      // Controller: utils.Success(c, http.StatusOK, "Schedules retrieved successfully", schedules)
      // utils.Success usually wraps in "data" field?
      // Let's assume standard response format.
      // Wait, previous code was: data['schedules'].
      // I should check utils.Success in server if possible, or assume 'data' based on other methods.
      // CreateSchedule returns `schedule` object.
      // GetSchedules returns `schedules` array.
      // Let's assume the response body IS the data or it's wrapped.
      // Looking at GetSoilAnalysis: responseData['data'].
      // So likely 'data'.
      return schedulesData.map((json) => Schedule.fromJson(json)).toList();
    } else {
      debugPrint(response.body.toString());
      throw Exception('Failed to load schedules');
    }
  }

  //Create Schedule is working fine
  Future<Schedule> createSchedule(String token, Map<String, dynamic> scheduleData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$schedule'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(scheduleData),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Schedule.fromJson(data['data']);
    } else {
      debugPrint(response.body.toString());
      print('Status code: ${response.statusCode}');
      throw Exception('Failed to create schedule');
    }
  }

  //Update Schedule not functional yet
  Future<Schedule> updateSchedule(
      String token, String id, Map<String, dynamic> scheduleData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$schedule/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(scheduleData),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Schedule.fromJson(data['data']);
    } else {
      debugPrint(response.body.toString());
      print('Status code: ${response.statusCode}');
      throw Exception('Failed to update schedule');
    }
  }

  //Delete Schedule working fine
  Future<void> deleteSchedule(String token, String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$schedule/$id'),
      headers: {
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return;
    }
    if (response.statusCode != 204) {
      debugPrint(response.body.toString());
      throw Exception('Failed to delete schedule');
    }
  }

  //get soil data
  Future<SoilData> getSoilAnalysis(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$getSoil'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return SoilData.fromJson(responseData['data']);
    } else {
      print(
          'Failed to load soil analysis data. Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to load soil analysis data');
    }
  }

  Future<WeatherData> fetchWeatherForUser(String token) async {
    print("This is the token: $token");
    if (token.isEmpty) {
      throw Exception('Token is empty');
    }
    try {
      final user = await getFarmerDetails(token);
      print("This is the user: $user");
      if (user.farmer.location.isEmpty) {
        throw Exception('User location not found');
      }
      return await fetchWeatherData(token, user.farmer.location);
    } catch (e) {
      print('Error fetching weather data: $e');
      throw Exception('Failed to fetch weather data: $e');
    }
  }

  Future<WeatherData> fetchWeatherData(String token, String location) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/weather?query=$location'),
        headers: {
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Weather API response: $data');
        // Server returns { "message": ..., "data": { ... } }
        return WeatherData.fromJson(data['data']);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchWeatherData: $e');
      throw Exception('Failed to fetch weather data: $e');
    }
  }

  Future<void> initiateIVRCall(String token, String phone) async {
    // Assuming the endpoint will be /api/v1/ivr/call
    // And it takes query params id and phone, or body.
    // MakeIVRCall in ivr.go takes query params: id, phone.
    // I need to pass the farmer ID.
    // I'll get the farmer ID from local storage or let the backend handle it if I pass token?
    // MakeIVRCall uses c.Query("id"). It doesn't seem to use JWT middleware in the "Public routes" section of routes.go?
    // Wait, the user said "Make a new api".
    // I will add the route to Protected routes or Public?
    // If public, I need to pass ID.
    // If protected, I can extract ID from token.
    // MakeIVRCall reads "id" from query.
    // I'll stick to that for now.
    
    final userId = await SLocalStorage().getUserId();
    if (userId == null) throw Exception('User ID not found');

    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/ivr/call?id=$userId&phone=$phone'),
      headers: {
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode != 200) {
      print('Failed to initiate IVR call: ${response.body}');
      throw Exception('Failed to initiate IVR call');
    }
  }

  Future<List<Map<String, dynamic>>> getAlerts(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$getAlert'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> alertsData = data['data'];
      return alertsData.cast<Map<String, dynamic>>();
    } else {
      debugPrint(response.body.toString());
      throw Exception('Failed to load alerts');
    }
  }
}
