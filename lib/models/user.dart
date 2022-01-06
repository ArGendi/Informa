import 'package:informa/helpers/shared_preference.dart';

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
  //0 = none, 1 = home, 2 = gym
  int workoutPlace;
  int points;
  List achievements = [];
  int weight;
  int tall;
  int fatsPercent;
  int age;
  int fitnessLevel;
  int trainingPeriodLevel;
  List trainingTools = [];
  int iTrainingDays = 0;
  List trainingDays = [];

  AppUser({this.id, this.name, this.email, this.token, this.premium = false, this.gender = 0, this.program = 0,
      this.goal = 0, this.points = 0, this.weight = 80, this.age = 30, this.fatsPercent = 0, this.tall = 170, this.workoutPlace = 0,
      this.fitnessLevel = 0, this.trainingPeriodLevel = 0, this.fillPremiumForm=false});

  fromJson(Map<String, dynamic> json){
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    fromSocialMedia = json['fromSocialMedia'];
    premium = json['premium'];
    gender = json['gender'];
    program = json['program'];
    goal = json['goal'];
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
    trainingDays = json['trainingDays'] ;
  }

  Map<String, dynamic> toJson(){
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'fromSocialMedia': fromSocialMedia,
      'premium': premium,
      'gender': gender,
      'program': program,
      'goal': goal,
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
      'trainingDays': trainingDays,
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