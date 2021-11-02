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
  int points;
  List<String>? achievements = [];

  User({this.id, this.name, this.email, this.token, this.premium = false, this.gender = 0, this.program = 0,
      this.goal = 0, this.points = 0});
}