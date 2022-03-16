import 'dart:collection';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/meal_category.dart';
import 'package:informa/models/meal_category_list.dart';
import 'package:informa/models/meal_section.dart';
import 'package:informa/models/meals_list.dart';
import 'package:informa/models/snacks_list.dart';
import 'package:informa/models/supplements_list.dart';
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
      bool isBalanced = isMealBalanced(meal, protein, carb, fats, 1, 1, 1);
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
    // result.forEach((key, value) {
    //   print(key.name! + ": " + value.toString());
    // });
    if((myProtein < protein - 3) || (myCarb < carb - 3) || (myFats < fats - 3))
      return null;
    return result;
  }

  List<Meal>? otherCalculateFullMealNumbers2(MealCategory mealCategory, int protein, int carb, int fats){
    int counter = 0, pointer = 0;
    double myProtein = 0, myCarb = 0, myFats = 0;
    List<Meal> meals = [];
    List<Meal> outMeals = [];
    double calories = (protein * 4) + (carb * 4) + (fats * 9);

    if(mealCategory.sections == null) return null;
    for(int i= 0; i<mealCategory.sections!.length; i++){
      for(var tempMeal in mealCategory.sections![i].meals!){
        Meal newMeal = tempMeal.copyObject();
        newMeal.amount = 0;
        newMeal.sectionIndex = i;
        double mealCalories = (newMeal.protein! * 4) + (newMeal.carb! * 4) + (newMeal.fats! * 9);
        if(mealCalories / calories < 0.4) newMeal.workEvery = 1;
        else if(mealCalories / calories < 0.5) newMeal.workEvery = 2;
        else if(mealCalories / calories < 0.8) newMeal.workEvery = 3;
        else if(mealCalories / calories < 1) newMeal.workEvery = 4;
        else newMeal.workEvery = 5;
        meals.add(newMeal);
      }
    }

    for(var meal in meals){
      print('----> ' + meal.name! + ': ' + meal.workEvery.toString());
    }

    List<double> minMacros = getMinMealMacros(meals, protein, carb, fats);
    print('Minimum Macros: ' + minMacros.toString());

    // double avgProtein = 0, avgCarb = 0, avgFats = 0;
    // for(int i=0; i<meals.length; i++){
    //   avgProtein += meals[i].protein! / protein;
    //   avgCarb += meals[i].carb! / carb;
    //   avgFats += meals[i].fats! / fats;
    // }
    // avgProtein = avgProtein / meals.length - 0.2;
    // avgCarb = avgCarb / meals.length - 0.2;
    // avgFats = avgFats / meals.length - 0.2;

    print('Starting the loop');
    while(outMeals.length < meals.length){
      if(counter > 400) break;
      if((myProtein - protein).abs() < 1 && (myCarb - carb).abs() < 1 &&
          myFats  < fats) break;

      double p = 0, c = 0, f = 0;
      //Meal meal = meals[pointer];
      print(meals[pointer].name);
      bool isBalanced = isMealBalanced(
        meals[pointer], protein, carb, fats,
          minMacros[0], minMacros[1], minMacros[2]
      );
      //bool isBalanced = isMealBalanced2(meals[pointer], protein, carb, fats);
      if(((meals[pointer].serving == 1) && (counter%3 != 0))
          || outMeals.contains(meals[pointer]) || (meals[pointer].workEvery > 1 && counter%meals[pointer].workEvery != 0)){
        print(meals[pointer].name! + ' not balanced');
        if(pointer+1 >= meals.length) counter++;
        pointer = (pointer+1) % meals.length;
        continue;
      }
      if(meals[pointer].serving != 1){
        print(meals[pointer].name! + ' take 5 gram');
        p = meals[pointer].protein! * 0.05;
        c = meals[pointer].carb! * 0.05;
        f = meals[pointer].fats! * 0.05;
      }
      else{
        p = meals[pointer].protein!;
        c = meals[pointer].carb!;
        f = meals[pointer].fats!;
      }

      if((myProtein + p < protein + 1) && (myCarb + c < carb + 1) && (myFats + f < fats + 1)){
        print(meals[pointer].name! + ' confirmed');
        myProtein += p;
        myCarb += c;
        myFats += f;
        if(meals[pointer].amount != null){
          if(meals[pointer].serving != 1) meals[pointer].amount = meals[pointer].amount! + 5;
          else meals[pointer].amount = meals[pointer].amount! + 1;
        }
        else{
          if(meals[pointer].serving != 1) meals[pointer].amount = 5;
          else meals[pointer].amount = 1;
        }
      }
      else {
        print(meals[pointer].name! + ' go to out meal');
        outMeals.add(meals[pointer]);
      }
      if(pointer+1 >= meals.length) counter++;
      pointer = (pointer+1) % meals.length;
    }
    print('Out of calculation loop');
    if(mealCategory.extra != null){
      if(fats > myFats){
        int diff = fats - myFats.round();
        myFats += diff;
        if(diff > 0) {
          mealCategory.extra!.amount = diff;
          mealCategory.extra!.sectionIndex = -1;
          meals.add(mealCategory.extra!);
        }
      }
    }
    // result.forEach((key, value) {
    //   print(key.name! + ": " + value.toString());
    // });

    // if((myProtein < protein - 3) || (myCarb < carb - 3) || (myFats < fats - 3))
    //   return null;
    return meals;
  }

  bool isMealBalanced(
      Meal meal, int protein, int carb, int fats,
      double avgProtein, double avgCarb, double avgFats
      ){
    if((meal.protein! / protein) > avgProtein) return false;
    else if((meal.carb! / carb) > avgCarb) return false;
    else if((meal.fats! / fats) > avgFats) return false;
    return true;
  }

  bool isMealBalanced2(Meal meal, int protein, int carb, int fats){
    double mealCalories = (meal.protein! * 4) + (meal.carb! * 4) + (meal.fats! * 9);
    double calories = (protein * 4) + (carb * 4) + (fats * 9);
    if((mealCalories / calories) > 0.8) return false;
    return true;
  }

  List<double> getMinMealMacros(List<Meal> meals, int protein, int carb, int fats){
    double p1 = 0, c1 = 0, f1 = 0;
    double minP = 0, minC = 0, minF = 0;
    minP = meals[0].protein! / protein;
    minC = meals[0].carb! / carb;
    minF = meals[0].fats! / fats;
    for(int i=1; i<meals.length; i++){
      p1 = meals[i].protein! / protein;
      c1 = meals[i].carb! / carb;
      f1 = meals[i].fats! / fats;
      if((p1 + c1 + f1) < (minP + minC + minF)){
        minP = p1;
        minC = c1;
        minF = f1;
      }
    }
    return [minP, minC, minF];
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

  List<double> calculateSupplementsMacros(AppUser user){
    double protein = 0, carb = 0, fats = 0;
    for(var id in user.supplements){
      Meal supplement = SupplementsList.supplements[int.parse(id) - 1];
      protein += supplement.protein != null ? supplement.protein! : 0;
      carb += supplement.carb != null ? supplement.carb! : 0;
      fats += supplement.fats != null ? supplement.fats! : 0;
    }
    return [protein, carb, fats];
  }

  List<Meal> calculateMeal(int protein, int carb, int fats, int percent, AppUser user, int whichMeal, bool includeSalad){
    List<Meal> allMeals = [];
    double newProtein = protein * (percent / 100);
    double newCarb = carb * (percent / 100);
    double newFats = fats * (percent / 100);
    double proteinAfterSalad = 0, carbAfterSalad = 0, fatsAfterSalad = 0;

    List<MealCategory> mealsCategory = [];
    if(whichMeal == 1) mealsCategory = MealCategoryList.breakfast;
    else if(whichMeal == 2) mealsCategory = MealCategoryList.lunch;
    else if(whichMeal == 3) mealsCategory = MealCategoryList.dinner;

    for(var mealCategory in mealsCategory){
      bool unWantedMealCategory = false;
      for(var section in mealCategory.sections!){
        for(var meal in section.meals!){
          if(user.unWantedMeals.contains(meal.otherId)) {
            unWantedMealCategory = true;
            break;
          }
        }
      }
      if(unWantedMealCategory) continue;
      if(whichMeal == 2 && includeSalad){
        proteinAfterSalad = newProtein - MealsList.salads[0].protein!;
        carbAfterSalad = newCarb - MealsList.salads[0].carb!;
        fatsAfterSalad = newFats - MealsList.salads[0].fats!;
      }
      print('Macro: ' + newProtein.toString() + ' ' + newCarb.toString() + ' ' + newFats.toString());

      List<Meal>? result;
      if(whichMeal != 2)
        result = otherCalculateFullMealNumbers2(mealCategory, newProtein.toInt(), newCarb.toInt(), newFats.toInt());
      else
        result = otherCalculateFullMealNumbers2(mealCategory, proteinAfterSalad.toInt(), carbAfterSalad.toInt(), fatsAfterSalad.toInt());

      if(result != null){
        print('-------------- Result ----------------');
        for(var meal in result){
          print(meal.name! + ': ' + meal.amount!.toString());
        }
        print('-------------- End result ----------------');
        Meal meal = new Meal(
          id: mealCategory.id,
          name: mealCategory.name,
          engName: mealCategory.engName,
          protein: newProtein,
          carb: newCarb,
          fats: newFats,
          calories: (newProtein.toInt() * 4 + newCarb.toInt() * 4 + newFats.toInt() * 9),
        );
        List<MealSection> sections = [];
        for(var section in mealCategory.sections!){
          sections.add(
            new MealSection(
              name: section.name,
              engName: section.engName,
              meals: [],
            ),
          );
        }
        for(var tempMeal in result){
          if(tempMeal.sectionIndex != -1)
            sections[tempMeal.sectionIndex!].meals!.add(tempMeal);
          else {
            sections.add(
              MealSection(
                name: 'اخر',
                engName: 'other',
                meals: [tempMeal],
              ),
            );
          }
        }
        if(whichMeal == 2){
          if(meal.salads == null) meal.salads = [];
          for(var salad in MealsList.salads){
            meal.salads!.add(salad);
          }
        }
        meal.sections = sections;
        print('sections from calculate meal: ' + meal.sections.toString());
        allMeals.add(meal);
      }
    }
    return allMeals;
  }

}