import 'dart:collection';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/meal_category.dart';
import 'package:informa/models/meal_category_list.dart';
import 'package:informa/models/meals_list.dart';
import 'package:informa/models/snacks_list.dart';
import 'package:informa/models/user.dart';
import 'package:informa/services/informa_service.dart';

class MealsService{
  InformaService _informaService = new InformaService();

  Future<List<List<dynamic>>> loadAsset(String fileName) async{
    var data = await rootBundle.loadString(fileName);
    return CsvToListConverter().convert(data);
  }

  Future setAllMeals() async{
    List<List<dynamic>> breakfast = await loadAsset('assets/files/breakfast.csv');
    List<List<dynamic>> lunch = await loadAsset('assets/files/lunch.csv');
    List<List<dynamic>> dinner = await loadAsset('assets/files/dinner.csv');
    List<List<dynamic>> allMeals = await loadAsset('assets/files/allMeals.csv');
    for(int i=1; i<breakfast.length; i++){
      MealsList.breakfast.add(
        Meal(
          id: i.toString(),
          otherId: breakfast[i][9].toString(),
          name: breakfast[i][8].toString().trim(),
          engName: breakfast[i][1].toString().trim(),
          serving: breakfast[i][2],
          unit: breakfast[i][3],
          protein: breakfast[i][4].toDouble(),
          carb: breakfast[i][5].toDouble(),
          fats: breakfast[i][6].toDouble(),
          calories: breakfast[i][7].toDouble(),
          category: 'الفطار',
        ),
      );
    }
    for(int i=1; i<lunch.length; i++){
      MealsList.lunch.add(
        Meal(
          id: (i + 100).toString(),
          otherId: lunch[i][9].toString(),
          name: lunch[i][8].toString().trim(),
          engName: lunch[i][1].toString().trim(),
          serving: lunch[i][2],
          unit: lunch[i][3],
          protein: lunch[i][4].toDouble(),
          carb: lunch[i][5].toDouble(),
          fats: lunch[i][6].toDouble(),
          calories: lunch[i][7].toDouble(),
          category: 'الغداء',
        ),
      );
    }
    for(int i=1; i<dinner.length; i++){
      MealsList.dinner.add(
        Meal(
          id: (i + 200).toString(),
          otherId: dinner[i][9].toString(),
          name: dinner[i][8].toString().trim(),
          engName: dinner[i][1].toString().trim(),
          serving: dinner[i][2],
          unit: dinner[i][3],
          protein: dinner[i][4].toDouble(),
          carb: dinner[i][5].toDouble(),
          fats: dinner[i][6].toDouble(),
          calories: dinner[i][7].toDouble(),
          category: 'العشاء',
        ),
      );
    }
    for(int i=1; i<allMeals.length; i++){
      if(allMeals[i][1] != 52 && allMeals[i][1] < 70)
        MealsList.allMealsList.add(
          Meal(
            otherId: allMeals[i][1].toString(),
            name: allMeals[i][2].toString().trim(),
            engName: allMeals[i][0].toString().trim(),
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
      if(meal.serving != 2){
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

  Map<Meal, int>? otherCalculateFullMealNumbers(MealCategory mealCategory, int protein, int carb, int fats){
    int counter = 0, pointer = 0;
    double myProtein = 0, myCarb = 0, myFats = 0;
    Map<Meal, int> result = Map();
    List<Meal> outMeals = [];
    print('Starting the loop');
    while(outMeals.length < mealCategory.meals!.length){
      if(counter > 400) break;
      if((myProtein - protein).abs() < 1 && (myCarb - carb).abs() < 1 &&
          (myFats - fats).abs() < 1) break;

      double p = 0, c = 0, f = 0;
      Meal meal = mealCategory.meals![pointer];
      print(meal.name);
      bool isBalanced = isMealBalanced(meal, protein, carb, fats);
      if(((!isBalanced || meal.serving == 1) && (counter%4 != 0)) || outMeals.contains(meal)){
        print(meal.name! + ' not balanced');
        if(pointer+1 >= mealCategory.meals!.length) counter++;
        pointer = (pointer+1) % mealCategory.meals!.length;
        continue;
      }
      if(meal.serving != 1){
        print(meal.name! + ' take 5 gram');
        p = meal.protein! * 0.05;
        c = meal.carb! * 0.05;
        f = meal.fats! * 0.05;
      }
      else{
        p = meal.protein!;
        c = meal.carb!;
        f = meal.fats!;
      }

      if((myProtein + p < protein + 1) && (myCarb + c < carb + 1) && (myFats + f < fats + 1)){
        print(meal.name! + ' confirmed');
        myProtein += p;
        myCarb += c;
        myFats += f;
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
      else {
        print(meal.name! + ' go to out meal');
        outMeals.add(meal);
      }
      if(pointer+1 >= mealCategory.meals!.length) counter++;
      pointer = (pointer+1) % mealCategory.meals!.length;
    }
    print('Out of calculation loop');
    if(mealCategory.extra != null){
      if(fats > myFats){
        int diff = fats - myFats.round();
        myFats += diff;
        if(diff > 0)
          result[mealCategory.extra!] = diff;
      }
    }
    result.forEach((key, value) {
      print(key.name! + ": " + value.toString());
    });
    if((myProtein < protein - 3) || (myCarb < carb - 3) || (myFats < fats - 3))
      return null;
    return result;
  }

  bool isMealBalanced(Meal meal, int protein, int carb, int fats){
    if((meal.protein! / protein) > 1) return false;
    else if((meal.carb! / carb) > 1) return false;
    else if((meal.fats! / fats) > 1) return false;
    return true;
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
      // snacks[SnacksList.snacks[5]] = 2;
      // snacks[SnacksList.snacks[6]] = 2;
      // snacks[SnacksList.snacks[7]] = 2;
      // snacks[SnacksList.snacks[8]] = 2;

      protein += SnacksList.snacks[4].protein! * 2;
      carb += SnacksList.snacks[4].carb! * 2;
      fats += SnacksList.snacks[4].fats! * 2;
    }
    else if(user.wheyProtein == 2 && proteinNeeded >= 150) {
      snacks[SnacksList.snacks[4]] = 1;
      // snacks[SnacksList.snacks[5]] = 1;
      // snacks[SnacksList.snacks[6]] = 1;
      // snacks[SnacksList.snacks[7]] = 1;
      // snacks[SnacksList.snacks[8]] = 1;

      protein += SnacksList.snacks[4].protein! * 1;
      carb += SnacksList.snacks[4].carb! * 1;
      fats += SnacksList.snacks[4].fats! * 1;
    }

    if(carbNeeded >= 350) {
      snacks[SnacksList.snacks[5]] = 1;
      snacks[SnacksList.snacks[8]] = 1;

      protein += SnacksList.snacks[5].protein! * 1;
      protein += SnacksList.snacks[8].protein! * 1;
      carb += SnacksList.snacks[5].carb! * 1;
      carb += SnacksList.snacks[8].carb! * 1;
      fats += SnacksList.snacks[5].fats! * 1;
      fats += SnacksList.snacks[8].fats! * 1;
    }
    else if(carbNeeded >= 300) {
      snacks[SnacksList.snacks[5]] = 1;
      snacks[SnacksList.snacks[7]] = 1;

      protein += SnacksList.snacks[5].protein! * 1;
      protein += SnacksList.snacks[7].protein! * 1;
      carb += SnacksList.snacks[5].carb! * 1;
      carb += SnacksList.snacks[7].carb! * 1;
      fats += SnacksList.snacks[5].fats! * 1;
      fats += SnacksList.snacks[7].fats! * 1;
    }
    else if(carbNeeded >= 250) {
      snacks[SnacksList.snacks[5]] = 1;

      protein += SnacksList.snacks[5].protein! * 1;
      carb += SnacksList.snacks[5].carb! * 1;
      fats += SnacksList.snacks[5].fats! * 1;
    }
    else if(carbNeeded >= 200) {
      snacks[SnacksList.snacks[8]] = 1;

      protein += SnacksList.snacks[8].protein! * 1;
      carb += SnacksList.snacks[8].carb! * 1;
      fats += SnacksList.snacks[8].fats! * 1;
    }
    else if(carbNeeded >= 125) {
      snacks[SnacksList.snacks[7]] = 1;

      protein += SnacksList.snacks[7].protein! * 1;
      carb += SnacksList.snacks[7].carb! * 1;
      fats += SnacksList.snacks[7].fats! * 1;
    }
    snacksWithRest.add(snacks);
    snacksWithRest.add([protein, carb, fats]);
    return snacksWithRest;
  }

  List<FullMeal> calculateBreakfast(int protein, int carb, int fats, int percent, AppUser user){
    List<FullMeal> allFullMeals = [];
    double newProtein = protein * (percent / 100);
    double newCarb = carb * (percent / 100);
    double newFats = fats * (percent / 100);

    for(var mealCategory in MealCategoryList.breakfast){
      bool unWantedMealCategory = false;
      for(var meal in mealCategory.meals!){
        if(user.unWantedMeals.contains(meal.otherId)) {
          unWantedMealCategory = true;
          break;
        }
      }
      if(unWantedMealCategory) continue;
      Map<Meal, int>? result = otherCalculateFullMealNumbers(mealCategory, newProtein.toInt(), newCarb.toInt(), newFats.toInt());
      if(result != null){
        FullMeal fullMeal = new FullMeal(
          id: mealCategory.id,
          name: mealCategory.name,
          engName: mealCategory.engName,
          components: result,
          protein: newProtein.toInt(),
          carb: newCarb.toInt(),
          fats: newFats.toInt(),
          calories: (newProtein.toInt() * 4 + newCarb.toInt() * 4 + newFats.toInt() * 9),
        );
        allFullMeals.add(fullMeal);
      }
    }

    return allFullMeals;
  }

  List<FullMeal> calculateLunch(int protein, int carb, int fats, int percent, AppUser user){
    List<FullMeal> allFullMeals = [];
    double newProtein = protein * (percent / 100);
    double newCarb = carb * (percent / 100);
    double newFats = fats * (percent / 100);

    for(var mealCategory in MealCategoryList.lunch){
      bool unWantedMealCategory = false;
      for(var meal in mealCategory.meals!){
        if(user.unWantedMeals.contains(meal.otherId)) {
          unWantedMealCategory = true;
          break;
        }
      }
      if(unWantedMealCategory) continue;
      Map<Meal, int>? result = otherCalculateFullMealNumbers(mealCategory, newProtein.toInt(), newCarb.toInt(), newFats.toInt());
      if(result != null){
        FullMeal fullMeal = new FullMeal(
          id: mealCategory.id,
          name: mealCategory.name,
          engName: mealCategory.engName,
          components: result,
          protein: newProtein.toInt(),
          carb: newCarb.toInt(),
          fats: newFats.toInt(),
          calories: (newProtein.toInt() * 4 + newCarb.toInt() * 4 + newFats.toInt() * 9),
        );
        allFullMeals.add(fullMeal);
      }
    }

    return allFullMeals;
  }

  List<FullMeal> calculateDinner(int protein, int carb, int fats, int percent, AppUser user){
    List<FullMeal> allFullMeals = [];
    double newProtein = protein * (percent / 100);
    double newCarb = carb * (percent / 100);
    double newFats = fats * (percent / 100);

    for(var mealCategory in MealCategoryList.dinner){
      bool unWantedMealCategory = false;
      for(var meal in mealCategory.meals!){
        if(user.unWantedMeals.contains(meal.otherId)) {
          unWantedMealCategory = true;
          break;
        }
      }
      if(unWantedMealCategory) continue;
      Map<Meal, int>? result = otherCalculateFullMealNumbers(mealCategory, newProtein.toInt(), newCarb.toInt(), newFats.toInt());
      if(result != null){
        FullMeal fullMeal = new FullMeal(
          id: mealCategory.id,
          name: mealCategory.name,
          engName: mealCategory.engName,
          components: result,
          protein: newProtein.toInt(),
          carb: newCarb.toInt(),
          fats: newFats.toInt(),
          calories: (newProtein.toInt() * 4 + newCarb.toInt() * 4 + newFats.toInt() * 9),
        );
        allFullMeals.add(fullMeal);
      }
    }

    return allFullMeals;
  }

}