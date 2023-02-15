import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  SharedPrefKeys._();

  static const String token = 'token';
  static const String userName = 'userName';
  static const String password = 'password';
  static const String rememberMe = 'rememberMe';
  static const String isLogin = 'isLogin';
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

  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  Future<bool> clear() async {
    return await _preferences.clear();
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

  // Set is login
  Future<void> setIsLogin(bool isLogin) async =>
      await _preferences.setBool(SharedPrefKeys.isLogin, isLogin);

  // Get login
  bool get isLogin =>
      _preferences.getBool(SharedPrefKeys.isLogin) ?? false;
}
