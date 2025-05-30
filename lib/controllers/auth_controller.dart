import 'package:sinchai_sathi/utils/local_storage.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class AuthController {
  final ApiService _apiService = ApiService();
  final SLocalStorage _localStorage = SLocalStorage();

  Future<User> signup(Farmer farmer) async {
    try {
      final user = await _apiService.signup(farmer);
      await _localStorage.saveAuthData(
        token: user.token!,
        refreshToken: user.refreshToken!,
        userId: user.farmer.id,
        userName: user.farmer.name,
      );
      return user;
    } on Exception {
      // Clear any partial data if signup failed
      await _localStorage.clearAuthData();
      rethrow;
    }
  }

  Future<User> login(String contactNumber) async {
    try {
      final response = await _apiService.login(contactNumber);
      await _localStorage.saveAuthData(
        token: response.token!,
        refreshToken: response.refreshToken!,
        userId: response.farmer.id,
        userName: response.farmer.name,
      );
      return response;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await _localStorage.clearAuthData();
  }

  Future<bool> isLoggedIn() async {
    return await _localStorage.isLoggedIn();
  }
}
