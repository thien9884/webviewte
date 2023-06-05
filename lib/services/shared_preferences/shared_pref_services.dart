import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  SharedPrefKeys._();

  static const String token = 'token';
  static const String userName = 'userName';
  static const String customerId = 'customerId';
  static const String password = 'password';
  static const String rememberMe = 'rememberMe';
  static const String checkBox = 'checkBox';
  static const String isLogin = 'isLogin';
  static const String listCategories = 'listCategory';
  static const String listIphone= 'listIphone';
  static const String listIpad = 'listIpad';
  static const String listMac = 'listMac';
  static const String listAppleWatch= 'listAppleWatch';
  static const String listSound = 'listSound';
  static const String listAccessories = 'listAccessories';
  static const String listNewsGroup = 'listNewsGroup';
  static const String listLatestNews = 'listLatestNews';
  static const String listTopBanner = 'listTopBanner';
  static const String listHomeBanner = 'listHomeBanner';
  static const String listTopics = 'listTopics';
  static const String infoCustomer = 'infoCustomer';
  static const String state = 'state';
  static const String avatar = 'avatar';
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

  // Set customer id
  Future<void> setCustomerId(int customerId) async =>
      await _preferences.setInt(SharedPrefKeys.customerId, customerId);

  // Get customer id
  int get customerId => _preferences.getInt(SharedPrefKeys.customerId) ?? 0;

  // Set list categories
  Future<void> setListCategories(String listCategories) async =>
      await _preferences.setString(SharedPrefKeys.listCategories, listCategories);

  // Get list categories
  String get listCategories => _preferences.getString(SharedPrefKeys.listCategories) ?? '';

  // Set list iphone
  Future<void> setListIphone(String listIphone) async =>
      await _preferences.setString(SharedPrefKeys.listIphone, listIphone);

  // Get list iphone
  String get listIphone => _preferences.getString(SharedPrefKeys.listIphone) ?? '';

  // Set list ipad
  Future<void> setListIpad(String listIpad) async =>
      await _preferences.setString(SharedPrefKeys.listIpad, listIpad);

  // Get list ipad
  String get listIpad => _preferences.getString(SharedPrefKeys.listIpad) ?? '';

  // Set list mac
  Future<void> setListMac(String listMac) async =>
      await _preferences.setString(SharedPrefKeys.listMac, listMac);

  // Get list mac
  String get listMac => _preferences.getString(SharedPrefKeys.listMac) ?? '';

  // Set list apple watch
  Future<void> setListAppleWatch(String listAppleWatch) async =>
      await _preferences.setString(SharedPrefKeys.listAppleWatch, listAppleWatch);

  // Get list apple watch
  String get listAppleWatch => _preferences.getString(SharedPrefKeys.listAppleWatch) ?? '';

  // Set list sound
  Future<void> setListSound(String listSound) async =>
      await _preferences.setString(SharedPrefKeys.listSound, listSound);

  // Get list sound
  String get listSound => _preferences.getString(SharedPrefKeys.listSound) ?? '';

  // Set list accessories
  Future<void> setListAccessories(String listAccessories) async =>
      await _preferences.setString(SharedPrefKeys.listAccessories, listAccessories);

  // Get list accessories
  String get listAccessories => _preferences.getString(SharedPrefKeys.listAccessories) ?? '';

  // Set list news group
  Future<void> setListNewsGroup(String listNewsGroup) async =>
      await _preferences.setString(SharedPrefKeys.listNewsGroup, listNewsGroup);

  // Get list news group
  String get listNewsGroup => _preferences.getString(SharedPrefKeys.listNewsGroup) ?? '';

  // Set list latest news
  Future<void> setListLatestNews(String listLatestNews) async =>
      await _preferences.setString(SharedPrefKeys.listLatestNews, listLatestNews);

  // Get list latest news
  String get listLatestNews => _preferences.getString(SharedPrefKeys.listLatestNews) ?? '';

  // Set list top banner
  Future<void> setListTopBanner(String listTopBanner) async =>
      await _preferences.setString(SharedPrefKeys.listTopBanner, listTopBanner);

  // Get list top banner
  String get listTopBanner => _preferences.getString(SharedPrefKeys.listTopBanner) ?? '';

  // Set list home banner
  Future<void> setListHomeBanner(String listHomeBanner) async =>
      await _preferences.setString(SharedPrefKeys.listHomeBanner, listHomeBanner);

  // Get list home banner
  String get listHomeBanner => _preferences.getString(SharedPrefKeys.listHomeBanner) ?? '';

  // Set list topics
  Future<void> setListTopics(String listTopics) async =>
      await _preferences.setString(SharedPrefKeys.listTopics, listTopics);

  // Get list topics
  String get listTopics => _preferences.getString(SharedPrefKeys.listTopics) ?? '';

  // Set list home banner
  Future<void> setInfoCustomer(String infoCustomer) async =>
      await _preferences.setString(SharedPrefKeys.infoCustomer, infoCustomer);

  // Get list home banner
  String get infoCustomer => _preferences.getString(SharedPrefKeys.infoCustomer) ?? '';

  // Set state
  Future<void> setState(String state) async =>
      await _preferences.setString(SharedPrefKeys.state, state);

  // Get state
  String get state => _preferences.getString(SharedPrefKeys.state) ?? '';

  // Set avatar
  Future<void> setAvatar(String avatar) async =>
      await _preferences.setString(SharedPrefKeys.avatar, avatar);

  // Get avatar
  String get avatar => _preferences.getString(SharedPrefKeys.avatar) ?? '';

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

  // Set check box
  Future<void> setCheckBox(bool checkBox) async =>
      await _preferences.setBool(SharedPrefKeys.checkBox, checkBox);

  // Get check box
  bool get checkBox =>
      _preferences.getBool(SharedPrefKeys.checkBox) ?? false;

  // Set is login
  Future<void> setIsLogin(bool isLogin) async =>
      await _preferences.setBool(SharedPrefKeys.isLogin, isLogin);

  // Get login
  bool get isLogin =>
      _preferences.getBool(SharedPrefKeys.isLogin) ?? false;
}
