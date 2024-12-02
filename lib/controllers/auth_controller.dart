import 'package:sinchai_sathi/utils/local_storage.dart';

import '../models/user.dart';
import '../services/api_service.dart';

class AuthController {
  final ApiService _apiService = ApiService();
  final SLocalStorage _localStorage = SLocalStorage();

  Future<User> signup(User user) async {
    final newUser = await _apiService.signup(user);
    await _localStorage.saveUserName(newUser.name); 
    return newUser;
  }

  Future<User> login(String contactNumber) async {
    final user = await _apiService.login(contactNumber);
    await _localStorage.saveUserName(user.name);
    return user;
  }
}
