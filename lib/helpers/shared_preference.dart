// import 'package:shared_preferences/shared_preferences.dart';
//
// class HelpFunction {
//   static String sharedPreferenceUserLanguage = "LANGUAGEKEY";
//   static String sharedPreferenceUserId = "USERID";
//   static String sharedPreferenceUserToken = "USERTOKEN";
//   static String sharedPreferenceUserName = "USERNAME";
//   static String sharedPreferenceUserEmail = "USEREMAIL";
//   static String sharedPreferenceUserImage = "USERIMAGE";
//   static String sharedPreferenceUserCountry = "USERCOUNTRY";
//
//   static Future<bool> saveUserLanguage(String lang) async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return await preference.setString(sharedPreferenceUserLanguage, lang);
//   }
//
//   static Future<String?> getUserLanguage() async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return preference.getString(sharedPreferenceUserLanguage);
//   }
//
//   static Future<bool> saveUserId(String id) async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return await preference.setString(sharedPreferenceUserId, id);
//   }
//
//   static Future<String?> getUserid() async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return preference.getString(sharedPreferenceUserId);
//   }
//
//   static Future<bool> saveUserToken(String token) async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return await preference.setString(sharedPreferenceUserToken, token);
//   }
//
//   static Future<String?> getUserToken() async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return preference.getString(sharedPreferenceUserToken);
//   }
//
//   static Future<bool> saveUserName(String name) async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return await preference.setString(sharedPreferenceUserName, name);
//   }
//
//   static Future<String?> getUserName() async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return preference.getString(sharedPreferenceUserName);
//   }
//
//   static Future<bool> saveUserEmail(String email) async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return await preference.setString(sharedPreferenceUserEmail, email);
//   }
//
//   static Future<String?> getUserEmail() async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return preference.getString(sharedPreferenceUserEmail);
//   }
//
//   static Future<bool> saveUserImage(String image) async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return await preference.setString(sharedPreferenceUserImage, image);
//   }
//
//   static Future<String?> getUserImage() async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return preference.getString(sharedPreferenceUserImage);
//   }
//
//   static Future<bool> saveUserCountry(String country) async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return await preference.setString(sharedPreferenceUserCountry, country);
//   }
//
//   static Future<String?> getUserCountry() async {
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     return preference.getString(sharedPreferenceUserCountry);
//   }
//
// }
