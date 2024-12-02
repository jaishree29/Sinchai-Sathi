import 'package:shared_preferences/shared_preferences.dart';

class SLocalStorage {
  static final SLocalStorage _instance = SLocalStorage._internal();

  factory SLocalStorage() {
    return _instance;
  }

  SLocalStorage._internal();

  //Method to save data
  Future<void> saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw Exception("Invalid type");
    }

    print("Data saved with key: $key, value: $value");
  }

  // Get user Name
  Future<String?> getUserName() async {
    return readData<String>('userName');
  }


  // Save user name
  Future<void> saveUserName(String name) async {
    await saveData('userName', name);
  }
  // Save user ID
  Future<void> saveUserId(String userId) async {
    await saveData('userId', userId);
  }

  // Get user ID
  Future<String?> getUserId() async {
    return readData<String>('userId');
  }

  // Remove user ID
  Future<void> removeUserId() async {
    await removeData('userId');
  }

  // Remove user Name
  Future<void> removeuserName() async {
    await removeData('userName');
  }

  //Method to read data
  Future<T?> readData<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    } else {
      throw Exception("Invalid type");
    }
  }

  // Method to remove data
  Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    print("Data removed with key: $key");
  }

  // Clear all data in storage
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print("All data cleared");
  }
}
