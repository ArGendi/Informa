import 'package:flutter/cupertino.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/meal_category.dart';

class PremiumNutritionProvider extends ChangeNotifier{
  FullMeal? _snacks;
  List<FullMeal> _breakfast = [];
  List<FullMeal> _lunch = [];
  List<FullMeal> _dinner = [];

  FullMeal? get snacks => _snacks;
  List<FullMeal> get breakfast => _breakfast;
  List<FullMeal> get lunch => _lunch;
  List<FullMeal> get dinner => _dinner;

  setSnack(FullMeal value){
    _snacks = value;
    notifyListeners();
  }

  setBreakfast(List<FullMeal> value){
    _breakfast = value;
    notifyListeners();
  }

  setLunch(List<FullMeal> value){
    _lunch = value;
    notifyListeners();
  }

  setDinner(List<FullMeal> value){
    _dinner = value;
    notifyListeners();
  }
}