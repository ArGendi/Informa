import 'package:informa/models/meal.dart';

class MealCategory{
  String? id;
  String? name;
  String? engName;
  String? image;
  List<Meal>? meals;
  int index;
  Meal? extra;

  MealCategory({this.name, this.id, this.meals, this.image, this.index = 0, this.extra,
          this.engName});
}