import 'package:informa/models/meal.dart';

class MealSection{
  String? id;
  String? name;
  String? engName;
  List<Meal>? meals;

  MealSection({this.id, this.name, this.meals, this.engName});
}