import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static SharedPreferences? preferences;
  initSharedPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  static setStringValue(String key, String value) {
    return preferences!.setString(key, value);
  }

  static String? getStringValue(String key) {
    return preferences!.getString(key) ?? null;
  }

  static setIntValue(String key, int value) {
    return preferences!.setInt(key, value);
  }

  static int getIntValue(String key) {
    return preferences!.getInt(key) ?? 0;
  }
}
