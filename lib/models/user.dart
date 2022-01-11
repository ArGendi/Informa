import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/meals_list.dart';
import 'package:informa/services/firestore_service.dart';

class AppUser {
  String? id;
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
  int points;
  List achievements = [];
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
  //---------------------------
  //0 = none, 1 = ok, 2 = no
  int wheyProtein;
  //0 = none, 1 = I have, 2 = don't have, 3 = don't have but ready to buy
  int haveSupplements;
  String? supplements;
  int numberOfMeals;
  List datesOfMeals = [];
  List wantedMeals = List.from(MealsList.allMeals);
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
  DateTime? premiumCountDown;
  MealsList _mealsList = new MealsList();
  int package;
  int plan;

  AppUser({this.id, this.name, this.email, this.token, this.premium = false, this.gender = 0, this.program = 0,
      this.goal = 0, this.points = 0, this.weight = 80, this.age = 30, this.fatsPercent = 0, this.tall = 170, this.workoutPlace = 0,
      this.fitnessLevel = 0, this.trainingPeriodLevel = 0, this.fillPremiumForm=false ,this.wheyProtein = 0, this.haveSupplements = 0,
      this.numberOfMeals = 0, this.milkProblem = 0 ,this.disease = 0, this.package = 0, this.plan = 0});

  fromJson(Map<String, dynamic> json){
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
    points = json['points'];
    achievements = json['achievements'];
    weight = json['weight'];
    tall = json['tall'];
    fatsPercent = json['fatsPercent'];
    age = json['age'];
    fitnessLevel = json['fitnessLevel'];
    trainingPeriodLevel = json['trainingPeriodLevel'];
    trainingTools = json['trainingTools'] ;
    iTrainingDays = json['iTrainingDays'];
    var tsTrainingTime = json['trainingTime'] != null? json['trainingTime'] as Timestamp : null;
    trainingTime = tsTrainingTime != null? tsTrainingTime.toDate() : null;
    trainingDays = json['trainingDays'];
    wheyProtein = json['wheyProtein'];
    haveSupplements = json['haveSupplements'];
    supplements = json['supplements'];
    numberOfMeals = json['numberOfMeals'];
    datesOfMeals = json['datesOfMeals'];
    wantedMeals = premium && fillPremiumForm?
        _mealsList.getMealsByIds(json['wantedMeals']) : List.from(MealsList.allMeals);
    milkProblem = json['milkProblem'];
    disease = json['disease'];
    diseaseDescription = json['diseaseDescription'];
    DateTime? dateTime;
    if(json['premiumCountDown'] != null) {
      DateTime now = DateTime.now();
      var temp = json['premiumCountDown'] as Timestamp;
      dateTime = temp.toDate();
      bool before = dateTime.isBefore(now);
      if(before) dateTime = null;
    }
    premiumCountDown = dateTime;
    package = json['package'];
    plan = json['plan'];
  }

  Map<String, dynamic> toJson(){
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'fromSocialMedia': fromSocialMedia,
      'premium': premium,
      'fillPremiumForm': fillPremiumForm,
      'gender': gender,
      'program': program,
      'goal': goal,
      'goalDescription': goalDescription,
      'workoutPlace': workoutPlace,
      'points': points,
      'achievements': achievements,
      'weight': weight,
      'tall': tall,
      'fatsPercent': fatsPercent,
      'age': age,
      'fitnessLevel': fitnessLevel,
      'trainingPeriodLevel': trainingPeriodLevel,
      'trainingTools': trainingTools,
      'iTrainingDays': iTrainingDays,
      'trainingTime': trainingTime != null? Timestamp.fromDate(trainingTime!) : null,
      'trainingDays': trainingDays,
      'wheyProtein': wheyProtein,
      'haveSupplements': haveSupplements,
      'supplements': supplements,
      'numberOfMeals': numberOfMeals,
      'datesOfMeals': datesOfMeals,
      'wantedMeals': premium && fillPremiumForm?
            _mealsList.getMealsIds(wantedMeals) : [],
      'milkProblem': milkProblem,
      'disease': disease,
      'diseaseDescription': diseaseDescription,
      'premiumCountDown': premiumCountDown != null? Timestamp.fromDate(premiumCountDown!):
        null,
      'package': package,
      'plan': plan,
    };
  }

  Future saveInSharedPreference() async{
    await HelpFunction.saveUserName(name!);
    await HelpFunction.saveUserEmail(email!);
    await HelpFunction.saveUserPhone(phone!);
    await HelpFunction.saveUserPremium(premium);
    await HelpFunction.saveUserGender(gender);
    await HelpFunction.saveUserProgram(program);
    await HelpFunction.saveUserGoal(goal);
    await HelpFunction.saveUserWorkoutPlace(workoutPlace);
    await HelpFunction.saveUserPoints(points);
    await HelpFunction.saveUserWeight(weight);
    await HelpFunction.saveUserTall(tall);
    await HelpFunction.saveUserFatsPercent(fatsPercent);
    await HelpFunction.saveUserAge(age);
    await HelpFunction.saveUserFitnessLevel(fitnessLevel);
    await HelpFunction.saveUserTrainingPeriodLevel(trainingPeriodLevel);
    await HelpFunction.saveUserITrainingDays(iTrainingDays);
    await HelpFunction.saveUserAchievements(achievements);
    await HelpFunction.saveUserTrainingTools(trainingTools);
    await HelpFunction.saveUserTrainingDays(trainingDays);
  }

  Future getFromSharedPreference() async{
    name = await HelpFunction.getUserName();
    email = await HelpFunction.getUserEmail();
    phone = await HelpFunction.getUserPhone();
    premium = (await HelpFunction.getUserPremium())!;
    gender = (await HelpFunction.getUserGender())!;
    program = (await HelpFunction.getUserProgram())!;
    goal = (await HelpFunction.getUserGoal())!;
    workoutPlace = (await HelpFunction.getUserWorkoutPlace())!;
    points = (await HelpFunction.getUserPoints())!;
    weight = (await HelpFunction.getUserWeight())!;
    tall = (await HelpFunction.getUserTall())!;
    fatsPercent = (await HelpFunction.getUserFatsPercent())!;
    age = (await HelpFunction.getUserAge())!;
    fitnessLevel = (await HelpFunction.getUserFitnessLevel())!;
    trainingPeriodLevel = (await HelpFunction.getUserTrainingPeriodLevel())!;
    iTrainingDays = (await HelpFunction.getUserITrainingDays())!;
    achievements = (await HelpFunction.getUserAchievements())!;
    trainingTools = (await HelpFunction.getUserTrainingTools())!;
    trainingDays = (await HelpFunction.getUserTrainingDays())!;
  }

}