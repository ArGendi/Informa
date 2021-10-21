class User {
  int? id;
  String? name;
  String? email;
  String? token;
  bool premium;

  User({this.id, this.name, this.email, this.token, this.premium = false});
}