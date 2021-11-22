class User {
  int? id;
  String? name;
  String? email;
  String? token;
  bool premium;
  //0 = none, 1 = male, 2 = female
  int gender;
  //0 = none, 1 = workout + nutrition, 2 = workout, 3 = nutrition
  int program;
  int goal;
  //0 = none, 1 = home, 2 = gym
  int workoutPlace;
  int points;
  List<String>? achievements = [];
  int? weight;
  int? tall;
  int? fatsPercent;
  int? age;
  int fitnessLevel;

  User({this.id, this.name, this.email, this.token, this.premium = false, this.gender = 0, this.program = 0,
      this.goal = 0, this.points = 0, this.weight, this.age, this.fatsPercent, this.tall, this.workoutPlace = 0,
      this.fitnessLevel = 0});
}