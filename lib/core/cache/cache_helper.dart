import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static final CacheHelper _instance = CacheHelper._cacheHelper();

  CacheHelper._cacheHelper();
  factory CacheHelper() => _instance;

  late SharedPreferences _prefs;
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveData({required String key, required dynamic value}) async {
    if (value is String) {
      await _prefs.setString(key, value);
    }
    // ignore: dead_code
    else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    }
  }

  dynamic getData({required String key}) {
    return _prefs.get(key);
  }

  Future<bool> removeData({required String key}) async {
    return await _prefs.remove(key);
  }

  Future<bool> clearData() async {
    return await _prefs.clear();
  }
}
