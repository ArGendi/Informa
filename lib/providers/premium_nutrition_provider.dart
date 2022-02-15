import 'package:flutter/cupertino.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/meal_category.dart';

class PremiumNutritionProvider extends ChangeNotifier{
  bool _snacks = false;
  List<Meal> _breakfast = [];
  List<Meal> _lunch = [];
  List<Meal> _lunch2 = [];
  List<Meal> _dinner = [];
  int? _snackDone;
  List<int>? _mainSnacksDone = [];
  int? _breakfastDone;
  int? _lunchDone;
  int? _lunch2Done;
  int? _dinnerDone;
  List<int>? _supplementsDone = [];

  bool get snacks => _snacks;
  List<Meal> get breakfast => _breakfast;
  List<Meal> get lunch => _lunch;
  List<Meal> get lunch2 => _lunch2;
  List<Meal> get dinner => _dinner;
  int? get snackDone => _snackDone;
  int? get breakfastDone => _breakfastDone;
  int? get lunchDone => _lunchDone;
  int? get lunch2Done => _lunch2Done;
  int? get dinnerDone => _dinnerDone;
  List<int>? get mainSnacksDone => _mainSnacksDone;
  List<int>? get supplementsDone => _supplementsDone;

  setSnack(bool value){
    _snacks = value;
    notifyListeners();
  }

  setBreakfast(List<Meal> value){
    _breakfast = value;
    notifyListeners();
  }

  setLunch(List<Meal> value){
    _lunch = value;
    notifyListeners();
  }

  setLunch2(List<Meal> value){
    _lunch2 = value;
    notifyListeners();
  }

  setDinner(List<Meal> value){
    _dinner = value;
    notifyListeners();
  }

  setSnackDone(int? value){
    _snackDone = value;
    notifyListeners();
  }

  setBreakfastDone(int? value){
    _breakfastDone = value;
    //_breakfast[value!].isDone = true;
    notifyListeners();
  }

  setLunchDone(int? value){
    _lunchDone = value;
    //_lunch[value!].isDone = true;
    notifyListeners();
  }

  setLunch2Done(int? value){
    _lunch2Done = value;
    //_lunch2[value].isDone = true;
    notifyListeners();
  }

  setDinnerDone(int? value){
    _dinnerDone = value;
    //_dinner[value].isDone = true;
    notifyListeners();
  }

  int? getDoneNumberByMeal(int? mealNumber){
    if(mealNumber == null) return null;
    if(mealNumber == 1) return _breakfastDone;
    else if(mealNumber == 2) return _lunchDone;
    else if(mealNumber == 3) return _lunch2Done;
    else if(mealNumber == 4) return _dinnerDone;
  }

  resetDoneMeals(){
    _breakfastDone = _lunchDone = _lunch2Done = _dinnerDone = _snackDone = null;
    _mainSnacksDone = _supplementsDone = [];
    notifyListeners();
  }

  setMainSnacksDone(List<int>? value){
    _mainSnacksDone = value;
    notifyListeners();
  }

  setSupplementsDone(List<int>? value){
    _supplementsDone = value;
    notifyListeners();
  }

  addToMainSnacksDone(int value){
    _mainSnacksDone!.add(value);
    notifyListeners();
  }

  addToSupplementsDone(int value){
    _supplementsDone!.add(value);
    notifyListeners();
  }

}