import 'package:webviewtest/services/shared_preferences/base_preferences.dart';

class SharedPrefKeys {
  SharedPrefKeys._();

  static const String token = 'token';
  static const String refreshToken = 'refreshToken';
}

class SharedPreferencesService extends BasePreference {
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  static SharedPreferencesService get instance => _instance;

  SharedPreferencesService._internal();

  // Set token
  Future setToken(String token) async =>
      await setValue(SharedPrefKeys.token, token);

  // Get token
  Future<dynamic> get token => getValue(SharedPrefKeys.token);

  // Set refresh token
  Future setRefreshToken(String token) async =>
      await setValue(SharedPrefKeys.refreshToken, token);

  // Get refresh token
  Future<dynamic> get refreshToken => getValue(SharedPrefKeys.refreshToken);
}
