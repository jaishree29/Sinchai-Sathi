import 'package:shared_preferences/shared_preferences.dart';

class SLocalStorage {
  static final SLocalStorage _instance = SLocalStorage._internal();

  factory SLocalStorage() => _instance;
  SLocalStorage._internal();

  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';
  static const String _loginKey = 'is_logged_in';
  static const String _cropTypeKey = 'crop_type';
  static const String _locationKey = 'location';

  Future<void> saveAuthData({
    required String token,
    required String refreshToken,
    required String userId,
    required String userName,
    String? cropType,
    String? location,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_userNameKey, userName);
    if (cropType != null) await prefs.setString(_cropTypeKey, cropType);
    if (location != null) await prefs.setString(_locationKey, location);
    await prefs.setBool(_loginKey, true);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  Future<String?> getCropType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cropTypeKey);
  }

  Future<String?> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_locationKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginKey) ?? false;
  }

  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_cropTypeKey);
    await prefs.remove(_locationKey);
    await prefs.setBool(_loginKey, false);
  }
}
