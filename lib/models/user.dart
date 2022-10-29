import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/meals_list.dart';
import 'package:informa/models/supplement.dart';

class AppUser {
  String? id;
  int appId = 5100;
  String? injuryDetails;
  String? fatPhoto;
  List<String?>? supplementsPhotos;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? token;
  bool premium;
  bool fillPremiumForm;
  bool fromSocialMedia = false;
  //0 = none, 1 = male, 2 = female
  int gender;
  //0 = none, 1 = workout, 2 = workout + nutrition, 3 = nutrition
  int program;
  // 0 = none,
  int goal;
  String? goalDescription;
  //0 = none, 1 = home, 2 = gym
  int workoutPlace;
  int weight;
  int tall;
  int fatsPercent;
  int age;
  //0 = none, from level 1 to 5
  int fitnessLevel;
  int trainingPeriodLevel;
  List trainingTools = [];
  int iTrainingDays = -1;
  DateTime? trainingTime;
  List trainingDays = [];
  List<Supplement?>? addedSupplementsByUser = [];
  //---------------------------
  //0 = none, 1 = ok, 2 = no
  int wheyProtein;
  //0 = none, 1 = I have, 2 = don't have, 3 = don't have but ready to buy
  int haveSupplements;
  List supplements = [];
  int numberOfMeals;
  List datesOfMeals = [];
  List allMeals = List.from(MealsList.allMealsList);
  List unWantedMeals = [];
  //0 = none,
  //1 = yes have with all kind of milk,
  //2 = no, don't have any problem,
  //3 = with milk only (cheese & yogurt ok)
  //4 = with cheese only (milk & yogurt ok)
  //5 = with yogurt only (milk & cheese ok)
  int milkProblem;
  //0 = none, 1 = no, 2 = yes
  int disease;
  String? diseaseDescription;
  DateTime? premiumStartDate;
  DateTime? premiumEndDate;
  // MealsList _mealsList = new MealsList();
  int package;
  String plan;
  bool? inBody;
  //0 = none, 1 = breakfast & lunch, 2 = lunch & dinner
  int? whichTwoMeals;
  int? myProtein;
  int? myCarb;
  int? myFats;
  int? myCalories;
  int? dailyCalories;
  int? dailyProtein;
  int? dailyCarb;
  int? dailyFats;
  int? oldGoal;
  DateTime? lastDataUpdatedDate;
  double? myWater;
  double? dailyWater;
  int dietType;
  List? lowAndHighCarb;
  //--------------------
  DateTime? carbCycleStartDate;
  int? dailyCarbCycle;
  int? carbCycleIndex;
  bool adminConfirm;
  //------------------------
  int workoutGoal;
  String? workoutGoalDescription;
  int trainingLevel;
  int injuryExist;
  int injuryType;
  List<int> weakestMuscles = [];
  List<int> cardioTools = [];
  Map monthWorkoutStatus = {};
  String? workoutPreset;

  AppUser({
    this.id,
    this.premiumEndDate,
    this.name,
    this.email,
    this.injuryDetails,
    this.token,
    this.premium = false,
    this.gender = 0,
    this.program = 0,
    this.goal = 0,
    this.weight = 80,
    this.age = 30,
    this.fatsPercent = 0,
    this.tall = 170,
    this.workoutPlace = 0,
    this.fitnessLevel = 0,
    this.trainingPeriodLevel = 0,
    this.fillPremiumForm = false,
    this.wheyProtein = 0,
    this.haveSupplements = 0,
    this.numberOfMeals = 0,
    this.milkProblem = 0,
    this.disease = 0,
    this.package = 0,
    this.plan = '',
    this.whichTwoMeals = 0,
    this.oldGoal = 0,
    this.dietType = 0,
    this.adminConfirm = false,
    this.workoutGoal = 0,
    this.workoutGoalDescription,
    this.trainingLevel = 0,
    this.injuryExist = 0,
    this.injuryType = 0,
  });

  fromJson(Map<String, dynamic> json) {
    id = json['id'];
    injuryDetails = json['injuryDetails'];
    premiumEndDate = json['premiumEndDate'];
    appId = json['appId'] != null ? json['appId'] : 5100;
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    fromSocialMedia = json['fromSocialMedia'];
    premium = json['premium'];
    fillPremiumForm = json['fillPremiumForm'];
    gender = json['gender'];
    program = json['program'];
    goal = json['goal'];
    goalDescription = json['goalDescription'];
    workoutPlace = json['workoutPlace'];
    weight = json['weight'];
    tall = json['tall'];
    fatsPercent = json['fatsPercent'];
    age = json['age'];
    fitnessLevel = json['fitnessLevel'];
    trainingPeriodLevel = json['trainingPeriodLevel'];
    trainingTools = json['trainingTools'];
    iTrainingDays = json['iTrainingDays'];
    var tsTrainingTime =
        json['trainingTime'] != null ? json['trainingTime'] as Timestamp : null;
    trainingTime = tsTrainingTime != null ? tsTrainingTime.toDate() : null;
    trainingDays = json['trainingDays'];
    wheyProtein = json['wheyProtein'];
    haveSupplements = json['haveSupplements'];
    supplements = json['supplements'] != null ? json['supplements'] : [];
    numberOfMeals = json['numberOfMeals'];
    datesOfMeals = [];
    for (var date in json['datesOfMeals']) {
      var temp = date as Timestamp;
      datesOfMeals.add(temp.toDate());
    }
    // allMeals = premium && fillPremiumForm?
    //     _mealsList.getMealsByIds(json['wantedMeals']) : List.from(MealsList.allMeals);
    unWantedMeals = json['unWantedMeals'] != null ? json['unWantedMeals'] : [];
    milkProblem = json['milkProblem'];
    disease = json['disease'];
    diseaseDescription = json['diseaseDescription'];
    DateTime? dateTime;
    if (json['premiumStartDate'] != null) {
      DateTime now = DateTime.now();
      var temp = json['premiumStartDate'] as Timestamp;
      dateTime = temp.toDate();
      bool before = dateTime.isBefore(now);
      if (before) dateTime = null;
    }
    addedSupplementsByUser = (json['addedSupplementsByUser'] as List)
        .map((e) => Supplement.fromJson(e))
        .toList();
    premiumStartDate = dateTime;
    package = json['package'];
    plan = json['plan'].toString();
    inBody = json['inBody'];
    whichTwoMeals = json['whichTwoMeals'];
    myProtein = json['myProtein'];
    myCarb = json['myCarb'];
    myFats = json['myFats'];
    myCalories = json['myCalories'];
    dailyCalories = json['dailyCalories'];
    dailyProtein = json['dailyProtein'];
    dailyCarb = json['dailyCarb'];
    dailyFats = json['dailyFats'];
    oldGoal = json['oldGoal'];
    DateTime? dtLastDataUpdatedDate;
    if (json['lastDataUpdatedDate'] != null) {
      var temp = json['lastDataUpdatedDate'] as Timestamp;
      dtLastDataUpdatedDate = temp.toDate();
    }
    lastDataUpdatedDate = dtLastDataUpdatedDate;
    myWater = json['myWater'];
    dailyWater = json['dailyWater'];
    dietType = json['dietType'] != null ? json['dietType'] : 0;
    lowAndHighCarb = json['lowAndHighCarb'];
    DateTime? dtCarbCycleDate;
    if (json['carbCycleStartDate'] != null) {
      var temp = json['carbCycleStartDate'] as Timestamp;
      dtCarbCycleDate = temp.toDate();
    }
    carbCycleStartDate = dtCarbCycleDate;
    dailyCarbCycle = json['dailyCarbCycle'];
    workoutGoal = json['workoutGoal'] != null ? json['workoutGoal'] : 0;
    workoutGoalDescription = json['workoutGoalDescription'];
    trainingLevel = json['trainingLevel'] != null ? json['trainingLevel'] : 0;
    injuryExist = json['injuryExist'] != null ? json['injuryExist'] : 0;
    injuryType = json['injuryType'] != null ? json['injuryType'] : 0;
    weakestMuscles = json['weakestMuscles'] != null
        ? json['weakestMuscles'].cast<int>()
        : [];
    cardioTools =
        json['cardioTools'] != null ? json['cardioTools'].cast<int>() : [];
    monthWorkoutStatus =
        json['monthWorkoutStatus'] != null ? json['monthWorkoutStatus'] : {};
    workoutPreset = json['workoutPreset'];
    adminConfirm = json['adminConfirm'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appId': appId,
      'addedSupplementsByUser':
          addedSupplementsByUser!.map((e) => e!.toJson()).toList(),
      'fatPhoto': fatPhoto,
      'supplementsPhotos': supplementsPhotos,
      'email': email,
      'injuryDetails': injuryDetails,
      'name': name,
      'premiumEndDate': premiumEndDate,
      'phone': phone,
      'fromSocialMedia': fromSocialMedia,
      'premium': premium,
      'fillPremiumForm': fillPremiumForm,
      'gender': gender,
      'program': program,
      'goal': goal,
      'goalDescription': goalDescription,
      'workoutPlace': workoutPlace,
      'weight': weight,
      'tall': tall,
      'fatsPercent': fatsPercent,
      'age': age,
      'fitnessLevel': fitnessLevel,
      'trainingPeriodLevel': trainingPeriodLevel,
      'trainingTools': trainingTools,
      'iTrainingDays': iTrainingDays,
      'trainingTime':
          trainingTime != null ? Timestamp.fromDate(trainingTime!) : null,
      'trainingDays': trainingDays,
      'wheyProtein': wheyProtein,
      'haveSupplements': haveSupplements,
      'supplements': supplements,
      'numberOfMeals': numberOfMeals,
      'datesOfMeals': datesOfMeals,
      // 'wantedMeals': premium && fillPremiumForm?
      //       _mealsList.getMealsIds(allMeals) : [],
      'unWantedMeals': unWantedMeals,
      'milkProblem': milkProblem,
      'disease': disease,
      'diseaseDescription': diseaseDescription,
      'premiumStartDate': premiumStartDate != null
          ? Timestamp.fromDate(premiumStartDate!)
          : null,
      'package': package,
      'plan': plan,
      'inBody': inBody,
      'whichTwoMeals': whichTwoMeals,
      'myProtein': myProtein,
      'myCarb': myCarb,
      'myFats': myFats,
      'myCalories': myCalories,
      'dailyCalories': dailyCalories,
      'dailyProtein': dailyProtein,
      'dailyCarb': dailyCarb,
      'dailyFats': dailyFats,
      'oldGoal': oldGoal,
      'lastDataUpdatedDate': lastDataUpdatedDate != null
          ? Timestamp.fromDate(lastDataUpdatedDate!)
          : null,
      'myWater': myWater,
      'dailyWater': dailyWater,
      'dietType': dietType,
      'lowAndHighCarb': lowAndHighCarb,
      'carbCycleStartDate': carbCycleStartDate != null
          ? Timestamp.fromDate(carbCycleStartDate!)
          : null,
      'dailyCarbCycle': dailyCarbCycle,
      'workoutGoal': workoutGoal,
      'workoutGoalDescription': workoutGoalDescription,
      'trainingLevel': trainingLevel,
      'injuryExist': injuryExist,
      'injuryType': injuryType,
      'weakestMuscles': weakestMuscles,
      'cardioTools': cardioTools,
      'monthWorkoutStatus': monthWorkoutStatus,
      'workoutPreset': workoutPreset,
      'adminConfirm': adminConfirm,
    };
  }

  Future saveInSharedPreference() async {
    await HelpFunction.saveUserName(name!);
    await HelpFunction.saveUserEmail(email!);
    await HelpFunction.saveUserPhone(phone!);
    await HelpFunction.saveUserPremium(premium);
    await HelpFunction.saveUserGender(gender);
    await HelpFunction.saveUserProgram(program);
    await HelpFunction.saveUserGoal(goal);
    await HelpFunction.saveUserWorkoutPlace(workoutPlace);
    await HelpFunction.saveUserWeight(weight);
    await HelpFunction.saveUserTall(tall);
    await HelpFunction.saveUserFatsPercent(fatsPercent);
    await HelpFunction.saveUserAge(age);
    await HelpFunction.saveUserFitnessLevel(fitnessLevel);
    await HelpFunction.saveUserTrainingPeriodLevel(trainingPeriodLevel);
    await HelpFunction.saveUserITrainingDays(iTrainingDays);
    await HelpFunction.saveUserTrainingTools(trainingTools);
    await HelpFunction.saveUserTrainingDays(trainingDays);
  }

  Future getFromSharedPreference() async {
    name = await HelpFunction.getUserName();
    email = await HelpFunction.getUserEmail();
    phone = await HelpFunction.getUserPhone();
    premium = (await HelpFunction.getUserPremium())!;
    gender = (await HelpFunction.getUserGender())!;
    program = (await HelpFunction.getUserProgram())!;
    goal = (await HelpFunction.getUserGoal())!;
    workoutPlace = (await HelpFunction.getUserWorkoutPlace())!;
    weight = (await HelpFunction.getUserWeight())!;
    tall = (await HelpFunction.getUserTall())!;
    fatsPercent = (await HelpFunction.getUserFatsPercent())!;
    age = (await HelpFunction.getUserAge())!;
    fitnessLevel = (await HelpFunction.getUserFitnessLevel())!;
    trainingPeriodLevel = (await HelpFunction.getUserTrainingPeriodLevel())!;
    iTrainingDays = (await HelpFunction.getUserITrainingDays())!;
    trainingTools = (await HelpFunction.getUserTrainingTools())!;
    trainingDays = (await HelpFunction.getUserTrainingDays())!;
  }
}
