import 'package:shared_preferences/shared_preferences.dart';

class HelpFunction {
  static String sharedPreferenceUserLanguage = "LANGUAGEKEY";
  static String sharedPreferenceInitScreen = "INITSCREEN";
  static String sharedPreferenceUserName = "NAME";
  static String sharedPreferenceUserEmail = "EMAIL";
  static String sharedPreferenceUserPhone = "PHONE";
  static String sharedPreferenceUserPremium = "PREMIUM";
  static String sharedPreferenceUserGender = "GENDER";
  static String sharedPreferenceUserProgram = "PROGRAM";
  static String sharedPreferenceUserGoal = "GOAL";
  static String sharedPreferenceUserWorkoutPlace = "WORKOUTPLACE";
  static String sharedPreferenceUserPoints = "POINTS";
  static String sharedPreferenceUserWeight = "WEIGHT";
  static String sharedPreferenceUserGoalWeight = "GOALWEIGHT";
  static String sharedPreferenceUserTall = "TALL";
  static String sharedPreferenceUserFatsPercent = "FATSPERCENT";
  static String sharedPreferenceUserAge = "AGE";
  static String sharedPreferenceUserFitnessLevel = "fitnessLevel";
  static String sharedPreferenceUserTrainingPeriodLevel = "trainingPeriodLevel";
  static String sharedPreferenceUserITrainingDays = "iTrainingDays";
  static String sharedPreferenceUserAchievements = "achievements";
  static String sharedPreferenceUserTrainingTools = "trainingTools";
  static String sharedPreferenceUserTrainingDays = "trainingDays";
  static String sharedPreferenceWaterIsActivated = "waterIsActivated";
  static String sharedPreferenceWaterNumberOfTimes = "waterNumberOfTimes";

  static Future<bool> saveUserLanguage(String lang) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setString(sharedPreferenceUserLanguage, lang);
  }

  static Future<String?> getUserLanguage() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(sharedPreferenceUserLanguage);
  }

  static Future<bool> saveInitScreen(String screen) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setString(sharedPreferenceInitScreen, screen);
  }

  static Future<String?> getInitScreen() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(sharedPreferenceInitScreen);
  }

  static Future<bool> saveUserPhone(String value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setString(sharedPreferenceUserPhone, value);
  }

  static Future<String?> getUserPhone() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(sharedPreferenceUserPhone);
  }

  static Future<bool> saveUserName(String value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setString(sharedPreferenceUserName, value);
  }

  static Future<String?> getUserName() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(sharedPreferenceUserName);
  }

  static Future<bool> saveUserEmail(String value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setString(sharedPreferenceUserEmail, value);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(sharedPreferenceUserEmail);
  }

  static Future<bool> saveUserPremium(bool value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setBool(sharedPreferenceUserPremium, value);
  }

  static Future<bool?> getUserPremium() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getBool(sharedPreferenceUserPremium);
  }

  static Future<bool> saveUserGender(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceUserGender, value);
  }

  static Future<int?> getUserGender() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceUserGender);
  }

  static Future<bool> saveUserProgram(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceUserProgram, value);
  }

  static Future<int?> getUserProgram() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceUserProgram);
  }

  static Future<bool> saveUserGoal(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceUserGoal, value);
  }

  static Future<int?> getUserGoal() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceUserGoal);
  }

  static Future<bool> saveUserWorkoutPlace(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceUserWorkoutPlace, value);
  }

  static Future<int?> getUserWorkoutPlace() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceUserWorkoutPlace);
  }

  static Future<bool> saveUserPoints(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceUserPoints, value);
  }

  static Future<int?> getUserPoints() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceUserPoints);
  }

  static Future<bool> saveUserWeight(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceUserWeight, value);
  }

  static Future<int?> getUserWeight() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceUserWeight);
  }

  static Future<bool> saveUserGoalWeight(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceUserGoalWeight, value);
  }

  static Future<int?> getUserGoalWeight() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceUserGoalWeight);
  }

  static Future<bool> saveUserTall(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceUserTall, value);
  }

  static Future<int?> getUserTall() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceUserTall);
  }

  static Future<bool> saveUserFatsPercent(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceUserFatsPercent, value);
  }

  static Future<int?> getUserFatsPercent() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceUserFatsPercent);
  }

  static Future<bool> saveUserAge(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceUserAge, value);
  }

  static Future<int?> getUserAge() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceUserAge);
  }

  static Future<bool> saveUserFitnessLevel(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceUserFitnessLevel, value);
  }

  static Future<int?> getUserFitnessLevel() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceUserFitnessLevel);
  }

  static Future<bool> saveUserTrainingPeriodLevel(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceUserTrainingPeriodLevel, value);
  }

  static Future<int?> getUserTrainingPeriodLevel() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceUserTrainingPeriodLevel);
  }

  static Future<bool> saveUserITrainingDays(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceUserITrainingDays, value);
  }

  static Future<int?> getUserITrainingDays() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceUserITrainingDays);
  }

  static Future<bool> saveUserAchievements(List achievements) async {
    List<String> list = [];
    for(var item in achievements){
      list.add(item.toString());
    }
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setStringList(sharedPreferenceUserAchievements, list);
  }

  static Future<List<int>?> getUserAchievements() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    List<String>? list = preference.getStringList(sharedPreferenceUserAchievements);
    List<int>? iList = [];
    for(var item in list!){
      iList.add(int.parse(item));
    }
    return iList;
  }

  static Future<bool> saveUserTrainingTools(List values) async {
    List<String> list = [];
    for(var item in values){
      list.add(item.toString());
    }
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setStringList(sharedPreferenceUserTrainingTools, list);
  }

  static Future<List<int>?> getUserTrainingTools() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    List<String>? list = preference.getStringList(sharedPreferenceUserTrainingTools);
    List<int>? iList = [];
    for(var item in list!){
      iList.add(int.parse(item));
    }
    return iList;
  }

  static Future<bool> saveUserTrainingDays(List values) async {
    List<String> list = [];
    for(var item in values){
      list.add(item.toString());
    }
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setStringList(sharedPreferenceUserTrainingDays, list);
  }

  static Future<List<int>?> getUserTrainingDays() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    List<String>? list = preference.getStringList(sharedPreferenceUserTrainingDays);
    List<int>? iList = [];
    for(var item in list!){
      iList.add(int.parse(item));
    }
    return iList;
  }

  static Future<bool> saveUserWaterIsActivated(bool value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setBool(sharedPreferenceWaterIsActivated, value);
  }

  static Future<bool?> getUserWaterIsActivated() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getBool(sharedPreferenceWaterIsActivated);
  }

  static Future<bool> saveUserWaterNumberOfTimes(int value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return await preference.setInt(sharedPreferenceWaterNumberOfTimes, value);
  }

  static Future<int?> getUserWaterNumberOfTimes() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt(sharedPreferenceWaterNumberOfTimes);
  }

}
