import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  SharedPrefKeys._();

  static const String token = 'token';
  static const String userName = 'userName';
  static const String password = 'password';
  static const String rememberMe = 'rememberMe';
}

class SharedPreferencesService {
  static late SharedPreferencesService _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService._internal();

  static Future<SharedPreferencesService> get instance async {
    _instance = SharedPreferencesService._internal();

    _preferences = await SharedPreferences.getInstance();

    return _instance;
  }

  // Set token
  Future<void> setToken(String token) async =>
      await _preferences.setString(SharedPrefKeys.token, token);

  // Get token
  String get token => _preferences.getString(SharedPrefKeys.token) ?? '';

  // Set user name
  Future<void> setUserName(String userName) async =>
      await _preferences.setString(SharedPrefKeys.userName, userName);

  // Get user name
  String get userName => _preferences.getString(SharedPrefKeys.userName) ?? '';

  // Set password
  Future<void> setPassword(String password) async =>
      await _preferences.setString(SharedPrefKeys.password, password);

  // Get password
  String get password => _preferences.getString(SharedPrefKeys.password) ?? '';

  // Set remember me
  Future<void> setRememberMe(bool rememberMe) async =>
      await _preferences.setBool(SharedPrefKeys.rememberMe, rememberMe);

  // Get remember me
  bool get rememberMe =>
      _preferences.getBool(SharedPrefKeys.rememberMe) ?? false;
}
