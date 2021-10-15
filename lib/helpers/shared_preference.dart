import 'package:shared_preferences/shared_preferences.dart';

class HelpFunction {
  static String sharedPreferenceUserLanguage = "LANGUAGEKEY";

  static Future<bool> saveUserLanguage(String lang) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setString(sharedPreferenceUserLanguage, lang);
  }

  static Future<String?> getUserLanguage() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(sharedPreferenceUserLanguage);
  }
}
