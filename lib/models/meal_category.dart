import 'package:informa/models/meal.dart';

import 'meal_section.dart';

class MealCategory{
  String? id;
  String? name;
  String? engName;
  String? image;
  List<Meal>? meals;
  List<MealSection>? sections;
  int index;
  Meal? extra;

  MealCategory({this.name, this.id, this.meals, this.image, this.index = 0, this.extra,
          this.engName, this.sections});
}