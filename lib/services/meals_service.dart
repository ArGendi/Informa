import 'dart:collection';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/meal_category.dart';
import 'package:informa/models/meals_list.dart';

class MealsService{
  Future<List<List<dynamic>>> loadAsset(String fileName) async{
    var data = await rootBundle.loadString(fileName);
    return CsvToListConverter().convert(data);
  }

  Future setAllMeals() async{
    List<List<dynamic>> breakfast = await loadAsset('assets/files/breakfast.csv');
    List<List<dynamic>> lunch = await loadAsset('assets/files/lunch.csv');
    List<List<dynamic>> dinner = await loadAsset('assets/files/dinner.csv');
    for(int i=1; i<breakfast.length; i++){
      MealsList.breakfast.add(
        Meal(
          id: i.toString(),
          name: breakfast[i][1].toString().trim(),
          engName: breakfast[i][1].toString().trim(),
          serving: breakfast[i][2],
          protein: breakfast[i][4],
          carb: breakfast[i][5],
          fats: breakfast[i][6],
          calories: breakfast[i][7],
        ),
      );
    }
    for(int i=1; i<lunch.length; i++){
      MealsList.lunch.add(
        Meal(
          id: (i+breakfast.length).toString(),
          name: lunch[i][1].toString().trim(),
          engName: lunch[i][1].toString().trim(),
          serving: lunch[i][2],
          protein: lunch[i][4],
          carb: lunch[i][5],
          fats: lunch[i][6],
          calories: lunch[i][7],
        ),
      );
    }
    for(int i=1; i<dinner.length; i++){
      MealsList.dinner.add(
        Meal(
          id: (i+breakfast.length+dinner.length).toString(),
          name: dinner[i][1].toString().trim(),
          engName: dinner[i][1].toString().trim(),
          serving: dinner[i][2],
          protein: dinner[i][4],
          carb: dinner[i][5],
          fats: dinner[i][6],
          calories: dinner[i][7],
        ),
      );
    }
  }

  Map<Meal, int> calculateFullMealNumbers(MealCategory mealCategory, int protein, int carb, int fats){
    mealCategory.meals!.sort((a, b) => b.calories!.compareTo(a.calories!));
    double myProtein = 0, myCarb = 0, myFats = 0;
    Queue<Meal> queue = new Queue();
    Map<Meal, int> result = Map();
    for(var meal in mealCategory.meals!){
      queue.add(meal);
    }

    while(queue.isNotEmpty){
      if((myProtein - protein).abs() == 2 && (myCarb - carb).abs() == 2 &&
          (myFats - fats).abs() == 2) break;
      Meal meal = queue.removeFirst();
      double p = 0, c = 0, f = 0;
      if(meal.serving != 1){
        p = meal.protein! * 0.05;
        c = meal.carb! * 0.05;
        f = meal.fats! * 0.05;
      }
      else{
        p = meal.protein!;
        c = meal.carb!;
        f = meal.fats!;
      }

      if((myProtein + p < protein + 2) && (myCarb + c < carb + 2) && (myFats + f < fats + 2)){
        myProtein += p;
        myCarb += c;
        myFats += f;
        queue.add(meal);
        if(result.containsKey(meal)){
          int? value = result[meal];
          if(meal.serving != 1) result[meal] = value! + 5;
          else result[meal] = value! + 1;
        }
        else{
          if(meal.serving != 1) result[meal] = 5;
          else result[meal] = 1;
        }
      }
    }
    if(mealCategory.extra != null){
      if(fats > myFats){
        int diff = fats - myFats.round();
        if(diff > 0)
          result[mealCategory.extra!] = diff;
      }
    }
    return result;
  }

}