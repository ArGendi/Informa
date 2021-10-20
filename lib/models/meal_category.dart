import 'package:informa/models/meal.dart';

class MealCategory{
  int? id;
  String? name;
  List<Meal>? meals;

  MealCategory({this.name, this.id, this.meals});
}