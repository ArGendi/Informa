import 'package:informa/models/meal.dart';
import 'package:informa/models/meals_list.dart';

class FullMeal{
  String? id;
  String? name;
  String? engName;
  String? description;
  String? image;
  int? calories;
  int? protein;
  int? carb;
  int? fats;
  Map<Meal, int>? components;
  bool isDone;

  FullMeal({this.id, this.name, this.image, this.components, this.engName,
          this.carb, this.protein, this.fats, this.calories,this.description,
          this.isDone = false});

  Map<String, int> convertComponentsToStringInt(){
    Map<String, int> map = Map();
    components!.forEach((key, value) {
      map[key.id!] = value;
    });
    return map;
  }

  Map<Meal, int> convertComponentsToMealInt(Map map){
    Map<Meal, int> comp = new Map();
    map.forEach((key, value) {
      int index = int.parse(key);
      late Meal meal;
      if(index < 100)
        meal = MealsList.breakfast[index-1];
      else if(index < 200)
        meal = MealsList.lunch[index-100-1];
      else if(index >= 200)
        meal = MealsList.dinner[index-200-1];
      comp[meal] = value;
    });
    return comp;
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'engName': engName,
      'description': description,
      'image': image,
      'components': convertComponentsToStringInt(),
      'calories': calories,
      'protein': protein,
      'carb': carb,
      'fats': fats,
      //'isDone':
    };
  }

  fromJson(Map<String, dynamic> json){
    name = json['name'];
    engName = json['engName'];
    description = json['description'];
    image = json['image'];
    components = convertComponentsToMealInt(json['components']);
    calories = json['calories'];
    protein = json['protein'];
    carb = json['carb'];
    fats = json['fats'];
  }

}