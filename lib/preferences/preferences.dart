import "package:shared_preferences/shared_preferences.dart";

class Preference {
  static SharedPreferences? _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void putString(String key, String value) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs?.setString(key, value);
  }

  static void putInt(String key, int value) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs?.setInt(key, value);
  }

  static void putBoolean(String key, bool value) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs?.setBool(key, value);
  }

  static Future<String> getString(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs?.getString(key) ?? "";
  }

  static Future<Future<bool>?> removeString(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs?.remove(key);
  }

  static Future<int> getInt(String key) async {
     _prefs = await SharedPreferences.getInstance();
    return _prefs?.getInt(key) ?? 0;
  }

  static Future<bool> getBoolean(String key) async {
     _prefs = await SharedPreferences.getInstance();
    return _prefs?.getBool(key) ?? false;
  }
}
