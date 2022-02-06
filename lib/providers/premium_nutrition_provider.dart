import 'package:flutter/cupertino.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/meal_category.dart';

class PremiumNutritionProvider extends ChangeNotifier{
  bool _snacks = false;
  List<FullMeal> _breakfast = [];
  List<FullMeal> _lunch = [];
  List<FullMeal> _lunch2 = [];
  List<FullMeal> _dinner = [];
  int? _snackDone;
  int? _breakfastDone;
  int? _lunchDone;
  int? _lunch2Done;
  int? _dinnerDone;

  bool get snacks => _snacks;
  List<FullMeal> get breakfast => _breakfast;
  List<FullMeal> get lunch => _lunch;
  List<FullMeal> get lunch2 => _lunch2;
  List<FullMeal> get dinner => _dinner;
  int? get snackDone => _snackDone;
  int? get breakfastDone => _breakfastDone;
  int? get lunchDone => _lunchDone;
  int? get lunch2Done => _lunch2Done;
  int? get dinnerDone => _dinnerDone;

  setSnack(bool value){
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

  setLunch2(List<FullMeal> value){
    _lunch2 = value;
    notifyListeners();
  }

  setDinner(List<FullMeal> value){
    _dinner = value;
    notifyListeners();
  }

  setSnackDone(int value){
    _snackDone = value;
    notifyListeners();
  }

  setBreakfastDone(int value){
    _breakfastDone = value;
    _breakfast[value].isDone = true;
    notifyListeners();
  }

  setLunchDone(int value){
    _lunchDone = value;
    _lunch[value].isDone = true;
    notifyListeners();
  }

  setLunch2Done(int value){
    _lunch2Done = value;
    _lunch2[value].isDone = true;
    notifyListeners();
  }

  setDinnerDone(int value){
    _dinnerDone = value;
    _dinner[value].isDone = true;
    notifyListeners();
  }
}