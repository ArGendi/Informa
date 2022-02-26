import 'package:informa/models/meal_section.dart';

import 'meals_list.dart';

class Meal {
  String? id;
  String? otherId;
  String? name;
  String? engName;
  String? image;
  String? video;
  String? category;
  String? description;
  //String? period;
  double? carb = 0;
  double? calories = 0;
  double? protein = 0;
  double? fats = 0;
  bool isSelected;
  List<String>? components;
  List<MealSection>? sections;
  List<Meal>? salads;
  double serving = 0;
  String? unit;
  int? amount = 0;
  int? sectionIndex;

  Meal({this.id, this.name, this.category, this.image, this.description,
        this.fats, this.protein, this.calories, this.components, this.carb,
        this.video, this.isSelected = true, this.engName, this.serving = 0,
        this.unit, this.otherId, this.sections, this.amount, this.sectionIndex,
        this.salads});

  List<Map<String, dynamic>>? convertSectionsToMap(){
    if(sections == null) return null;
    List<Map<String, dynamic>> listOfMaps = [];
    for(var section in sections!){
      Map<String, dynamic> mealsMap = Map();
      for(var meal in section.meals!){
        mealsMap[meal.id!] = meal.amount!;
      }
      listOfMaps.add({
        'name': section.name,
        'engName': section.engName,
        'meals': mealsMap,
      });
    }
    return listOfMaps;
  }

  List<MealSection> convertMapToSections(List listOfMaps){
    List<MealSection> sections = [];
    for(var map in listOfMaps){
      MealSection mealSection = new MealSection(
        name: map['name'],
        engName: map['engName'],
      );
      List<Meal> meals = [];
      map['meals'].forEach((key, value) {
        int index = int.parse(key);
        late Meal meal;
        if(index < 100)
          meal = MealsList.breakfast[index-1].copyObject();
        else if(index < 200)
          meal = MealsList.lunch[index-100-1].copyObject();
        else if(index >= 200)
          meal = MealsList.dinner[index-200-1].copyObject();
        meal.amount = value;
        meals.add(meal);
      });
      mealSection.meals = meals;
      sections.add(mealSection);
    }
    return sections;
  }

  List<String>? convertSaladsToListOfStrings(){
    if(salads == null) return null;
    List<String> ids = [];
    for(var salad in salads!){
      ids.add(salad.id!);
    }
    return ids;
  }

  convertListOfStringsToSalads(List? jsonSalads){
    if(jsonSalads == null){
      return null;
    }
    List<Meal> temp = [];
    for(var id in jsonSalads){
      temp.add(MealsList.salads[int.parse(id) - 1]);
    }
    return temp;
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'engName': engName,
      'description': description,
      'image': image,
      'components': components,
      'calories': calories,
      'protein': protein,
      'carb': carb,
      'fats': fats,
      'sections': convertSectionsToMap(),
      'salads': convertSaladsToListOfStrings(),
    };
  }

  fromJson(Map<String, dynamic> json){
    name = json['name'];
    engName = json['engName'];
    description = json['description'];
    image = json['image'];
    components = json['components'] != null ? json['components'].cast<String>() : null;
    calories = json['calories'];
    protein = json['protein'];
    carb = json['carb'];
    fats = json['fats'];
    sections = json['sections'] != null ? convertMapToSections(json['sections']) : null;
    salads = convertListOfStringsToSalads(json['salads']);
  }

  Meal copyObject(){
    return new Meal(
      id: id,
      otherId: otherId,
      name: name,
      engName: engName,
      description: description,
      image: image,
      video: video,
      category: category,
      calories: calories,
      protein: protein,
      carb: carb,
      fats: fats,
      isSelected: isSelected,
      serving: serving,
      components: components,
      sections: sections,
      amount: amount,
      sectionIndex: sectionIndex,
      unit: unit,
      salads: salads,
    );
  }

}