class AppUser {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? token;
  bool premium;
  bool fromSocialMedia = false;
  //0 = none, 1 = male, 2 = female
  int gender;
  //0 = none, 1 = workout + nutrition, 2 = workout, 3 = nutrition
  int program;
  // 0 = none,
  int goal;
  //0 = none, 1 = home, 2 = gym
  int workoutPlace;
  int points;
  List achievements = [];
  int weight;
  int goalWeight;
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
      this.fitnessLevel = 0, this.goalWeight = 80, this.trainingPeriodLevel = 0});

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
    goalWeight = json['goalWeight'];
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
      'goalWeight': goalWeight,
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

}