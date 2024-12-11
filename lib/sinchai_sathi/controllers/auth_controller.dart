import 'package:sinchai_sathi/sinchai_sathi/utils/local_storage.dart';

import '../models/user.dart';
import '../services/api_service.dart';

class AuthController {
  final ApiService _apiService = ApiService();
  final SLocalStorage _localStorage = SLocalStorage();

  Future<User> signup(User user) async {
    try {
      final newUser = await _apiService.signup(user);
      await _localStorage.saveUserName(newUser.name);
      await _localStorage.saveUserId(newUser.id.toString());
      return newUser;
    } on Exception catch (e) {
      if (e.toString().contains('USER_ALREADY_EXISTS')) {
        throw Exception('User already exists');
      }
      throw Exception('Signup failed. Please try again.');
    }
  }

  Future<User> login(String contactNumber) async {
    final user = await _apiService.login(contactNumber);
    await _localStorage.saveUserName(user.name);
    await _localStorage.saveUserId(user.id.toString());
    return user;
  }
}
