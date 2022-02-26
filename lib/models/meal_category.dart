import 'package:informa/models/meal.dart';

import 'meal_section.dart';
import 'meals_list.dart';

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

  List<Meal> convertStringsToMeals(List list){
    List<Meal> meals = [];
    for(var id in list){
      int index = int.parse(id);
      late Meal meal;
      if(index < 100)
        meal = MealsList.breakfast[index-1].copyObject();
      else if(index < 200)
        meal = MealsList.lunch[index-100-1].copyObject();
      else if(index >= 200)
        meal = MealsList.dinner[index-200-1].copyObject();
      meals.add(meal);
    }
   return meals;
  }

  List<MealSection> convertMapToSections(List listOfMaps){
    List<MealSection> sections = [];
    for(var map in listOfMaps){
      MealSection mealSection = new MealSection(
        name: map['name'],
        engName: map['engName'],
      );
      List<Meal> meals = [];
      for(var id in map['meals']){
        int index = int.parse(id);
        late Meal meal;
        if(index < 100)
          meal = MealsList.breakfast[index-1].copyObject();
        else if(index < 200)
          meal = MealsList.lunch[index-100-1].copyObject();
        else if(index >= 200)
          meal = MealsList.dinner[index-200-1].copyObject();
        meals.add(meal);
      }
      mealSection.meals = meals;
      sections.add(mealSection);
    }
    return sections;
  }

  Meal getExtraMealById(String id){
    late Meal meal;
    int index = int.parse(id);
    if(index < 100)
      meal = MealsList.breakfast[index-1].copyObject();
    else if(index < 200)
      meal = MealsList.lunch[index-100-1].copyObject();
    else if(index >= 200)
      meal = MealsList.dinner[index-200-1].copyObject();
    return meal;
  }

  fromJson(Map<String, dynamic> json){
    name = json['name'];
    engName = json['engName'];
    meals = json['meals'] != null ? convertStringsToMeals(json[meals]) : null;
    sections = json['sections'] != null ? convertMapToSections(json['sections']) : null;
    extra = json['extra'] != null ? getExtraMealById(json['extra']) : null;
  }
}