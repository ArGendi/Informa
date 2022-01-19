import 'package:informa/models/meal.dart';

class MealCategory{
  int? id;
  String? name;
  String? image;
  List<Meal>? meals;
  int index;
  Meal? extra;

  MealCategory({this.name, this.id, this.meals, this.image, this.index = 0});
}