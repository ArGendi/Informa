import 'package:informa/models/meal.dart';

class FullMeal{
  String? id;
  String? name;
  String? engName;
  String? description;
  String? image;
  Map<Meal, int>? components;

  FullMeal({this.id, this.name, this.image, this.components, this.engName});
}