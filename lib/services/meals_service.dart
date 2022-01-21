import 'dart:collection';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/meal_category.dart';
import 'package:informa/models/meals_list.dart';
import 'package:informa/models/snacks_list.dart';
import 'package:informa/models/user.dart';

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

  List<dynamic> calculateSnacks(AppUser user, int proteinNeeded, int carbNeeded){
    Map<Meal, int> snacks = new Map();
    double protein = 0;
    double carb = 0;
    double fats = 0;
    List<dynamic> snacksWithRest = [];
    if(user.wheyProtein == 1 && proteinNeeded >= 250) {
      snacks[SnacksList.snacks[0]] = 2;
      snacks[SnacksList.snacks[1]] = 1;
      snacks[SnacksList.snacks[2]] = 1;
      snacks[SnacksList.snacks[3]] = 1;

      protein += SnacksList.snacks[0].protein! * 2;
      protein += SnacksList.snacks[1].protein! * 1;
      carb += SnacksList.snacks[0].carb! * 2;
      carb += SnacksList.snacks[1].carb! * 1;
      fats += SnacksList.snacks[0].fats! * 2;
      fats += SnacksList.snacks[1].fats! * 1;
    }
    else if(user.wheyProtein == 1 && proteinNeeded >= 200){
      snacks[SnacksList.snacks[0]] = 1;
      snacks[SnacksList.snacks[1]] = 1;
      snacks[SnacksList.snacks[2]] = 1;
      snacks[SnacksList.snacks[3]] = 1;

      protein += SnacksList.snacks[0].protein! * 1;
      protein += SnacksList.snacks[1].protein! * 1;
      carb += SnacksList.snacks[0].carb! * 1;
      carb += SnacksList.snacks[1].carb! * 1;
      fats += SnacksList.snacks[0].fats! * 1;
      fats += SnacksList.snacks[1].fats! * 1;
    }
    else if(user.wheyProtein == 1 && proteinNeeded >= 150) {
      snacks[SnacksList.snacks[1]] = 1;
      snacks[SnacksList.snacks[2]] = 1;
      snacks[SnacksList.snacks[3]] = 1;

      protein += SnacksList.snacks[1].protein! * 1;
      carb += SnacksList.snacks[1].carb! * 1;
      fats += SnacksList.snacks[1].fats! * 1;
    }
    else if(user.wheyProtein == 2 && proteinNeeded >= 250) {
      snacks[SnacksList.snacks[4]] = 2;
      snacks[SnacksList.snacks[5]] = 2;
      snacks[SnacksList.snacks[6]] = 2;
      snacks[SnacksList.snacks[7]] = 2;
      snacks[SnacksList.snacks[8]] = 2;

      protein += SnacksList.snacks[4].protein! * 2;
      carb += SnacksList.snacks[4].carb! * 2;
      fats += SnacksList.snacks[4].fats! * 2;
    }
    else if(user.wheyProtein == 2 && proteinNeeded >= 150) {
      snacks[SnacksList.snacks[4]] = 1;
      snacks[SnacksList.snacks[5]] = 1;
      snacks[SnacksList.snacks[6]] = 1;
      snacks[SnacksList.snacks[7]] = 1;
      snacks[SnacksList.snacks[8]] = 1;

      protein += SnacksList.snacks[4].protein! * 1;
      carb += SnacksList.snacks[4].carb! * 1;
      fats += SnacksList.snacks[4].fats! * 1;
    }

    if(carbNeeded >= 350) {
      snacks[SnacksList.snacks[9]] = 1;
      snacks[SnacksList.snacks[12]] = 1;

      protein += SnacksList.snacks[9].protein! * 1;
      protein += SnacksList.snacks[12].protein! * 1;
      carb += SnacksList.snacks[9].carb! * 1;
      carb += SnacksList.snacks[12].carb! * 1;
      fats += SnacksList.snacks[9].fats! * 1;
      fats += SnacksList.snacks[12].fats! * 1;
    }
    else if(carbNeeded >= 300) {
      snacks[SnacksList.snacks[9]] = 1;
      snacks[SnacksList.snacks[11]] = 1;

      protein += SnacksList.snacks[9].protein! * 1;
      protein += SnacksList.snacks[11].protein! * 1;
      carb += SnacksList.snacks[9].carb! * 1;
      carb += SnacksList.snacks[11].carb! * 1;
      fats += SnacksList.snacks[9].fats! * 1;
      fats += SnacksList.snacks[11].fats! * 1;
    }
    else if(carbNeeded >= 250) {
      snacks[SnacksList.snacks[9]] = 1;

      protein += SnacksList.snacks[9].protein! * 1;
      carb += SnacksList.snacks[9].carb! * 1;
      fats += SnacksList.snacks[9].fats! * 1;
    }
    else if(carbNeeded >= 200) {
      snacks[SnacksList.snacks[12]] = 1;

      protein += SnacksList.snacks[12].protein! * 1;
      carb += SnacksList.snacks[12].carb! * 1;
      fats += SnacksList.snacks[12].fats! * 1;
    }
    else if(carbNeeded >= 125) {
      snacks[SnacksList.snacks[11]] = 1;

      protein += SnacksList.snacks[11].protein! * 1;
      carb += SnacksList.snacks[11].carb! * 1;
      fats += SnacksList.snacks[11].fats! * 1;
    }
    snacksWithRest.add(snacks);
    snacksWithRest.add([protein, carb, fats]);
    return snacksWithRest;
  }


}