import 'dart:collection';

import 'package:informa/models/meal.dart';
import 'package:informa/models/meal_category.dart';
import 'package:informa/models/user.dart';

class InformaService{
  late AppUser _user;
  List<List<double>> _goalFactors = [
    [0.375, 0.4, 0.4, 0.425, 0.45],
    [0.275, 0.3, 0.3, 0.35, 0.375],
    [0.05, 0.1, 0.15, 0.2, 0.25],
    [0.3, 0.275, 0.275, 0.25, 0.225],
    [0.45, 0.425, 0.425, 0.4, 0.375],
  ];
  List<List<double>> _proteinFactors = [
    [1.35, 1.3, 1.3, 1.3, 1.2],
    [1.4, 1.35, 1.3, 1.3, 1.2],
    [1.6, 1.55, 1.5, 1.45, 1.4],
    [1.6, 1.55, 1.5, 1.45, 1.4],
    [1.6, 1.55, 1.5, 1.45, 1.4],
  ];
  List<double> _fatFactor = [0.225, 0.25, 0.25, 0.3, 0.35];

  InformaService(AppUser user){
    _user = user;
  }

  double calculateBMRFromInBody(){
    return _user.weight * (1-(_user.fatsPercent/100.0)) * 21.6 + 370;
  }

  double calculateBMRFromPhotos(){
    double initialBMR = 0.0;
    if(_user.gender == 1)
      initialBMR = (10 * _user.weight) + (6.25 * _user.tall) - (5 * _user.age) + 5;
    else
      initialBMR = (10 * _user.weight) + (6.25 * _user.tall) - (5 * _user.age) - 161;
    double inBodyBMR = calculateBMRFromInBody();
    return (inBodyBMR + initialBMR) / 2;
  }

  double calculateActivityLevel(){
    double total = 0;
    //training
    if(_user.iTrainingDays <= 1) total = 1.2;
    else if(_user.iTrainingDays == 2) total = 1.25;
    else if(_user.iTrainingDays == 3) total = 1.3;
    else if(_user.iTrainingDays == 4) total = 1.4;
    else if(_user.iTrainingDays == 5) total = 1.5;
    else if(_user.iTrainingDays == 6) total = 1.6;

    //activity per day
    if(_user.fitnessLevel == 1) total -= 0.05;
    else if(_user.fitnessLevel == 2) total -= 0.025;
    else if(_user.fitnessLevel == 3) total += 0;
    else if(_user.fitnessLevel == 4) total += 0.025;
    else if(_user.fitnessLevel == 5) total += 0.05;

    if(total < 1.2) total = 1.2;
    return total;
  }

  double calculateTotalCaloriesBurn(){
    double bmr = 0;
    double activityLevel = 0;
    if(_user.inBody!)
      bmr = calculateBMRFromInBody();
    else bmr = calculateBMRFromPhotos();
    activityLevel = calculateActivityLevel();
    return bmr * activityLevel;
  }

  int calculateNeededCalories(){
    int index = -1;
    if(_user.fatsPercent < 10) index = 0;
    else if(_user.fatsPercent >= 10 && _user.fatsPercent < 15) index = 1;
    else if(_user.fatsPercent >= 15 && _user.fatsPercent < 20) index = 2;
    else if(_user.fatsPercent >= 20 && _user.fatsPercent < 25) index = 3;
    else if(_user.fatsPercent >= 25) index = 4;

    double factor = _goalFactors[_user.goal-1][index];
    double totalCalBurn = calculateTotalCaloriesBurn();
    double result = 0;
    if(_user.goal <= 3) result = totalCalBurn - (totalCalBurn * factor);
    else if(_user.goal >= 4) result = totalCalBurn + (totalCalBurn * factor);
    int caloriesNeeded = result.toInt();

    if(_user.goal == 1 && caloriesNeeded < 1000) caloriesNeeded = 1000;
    else if(_user.goal == 2 && caloriesNeeded < 1250) caloriesNeeded = 1250;

    return caloriesNeeded;
  }

  int calculateProteinNeeded(){
    int index = -1;
    double activityLevel = calculateActivityLevel();
    double proteinFactor = 0;
    if(activityLevel == 1.2 && (_user.goal == 1 || _user.goal == 2))
      proteinFactor = 1.1;
    else{
      if(_user.fatsPercent < 10) index = 0;
      else if(_user.fatsPercent >= 10 && _user.fatsPercent < 15) index = 1;
      else if(_user.fatsPercent >= 15 && _user.fatsPercent < 20) index = 2;
      else if(_user.fatsPercent >= 20 && _user.fatsPercent < 25) index = 3;
      else if(_user.fatsPercent >= 25) index = 4;
      proteinFactor = _proteinFactors[_user.goal-1][index];
    }
    double leanBodyMass = _user.weight * (1 - (_user.fatsPercent/100));
    double dProteinNeeded = (leanBodyMass * 2.2) * proteinFactor;
    int iProteinNeeded = dProteinNeeded.toInt();
    return iProteinNeeded;
  }

  int calculateFatsNeeded(int caloriesNeeded){
    double fatFac = _fatFactor[_user.goal-1];
    double fatsNeeded = (fatFac * caloriesNeeded) / 9;
    return fatsNeeded.toInt();
  }

  int calculateCarbNeeded(int caloriesNeeded, int protein, int fats){
    double carbNeeded = (caloriesNeeded - ((protein * 4) + (fats * 9))) / 4;
    return carbNeeded.toInt();
  }

  calculateSnacks(int proteinNeeded, int carbNeeded){
    List<Meal>? snack = [];
    if(_user.wheyProtein == 1 && proteinNeeded >= 250) snack = null;
    else if(_user.wheyProtein == 1 && proteinNeeded >= 200) snack = null;
    else if(_user.wheyProtein == 1 && proteinNeeded >= 150) snack = null;
    else if(_user.wheyProtein == 2 && proteinNeeded >= 250) snack = null;
    else if(_user.wheyProtein == 2 && proteinNeeded >= 150) snack = null;

    if(carbNeeded >= 350) snack = null;
    else if(carbNeeded >= 300) snack = null;
    else if(carbNeeded >= 250) snack = null;
    else if(carbNeeded >= 200) snack = null;
    else if(carbNeeded >= 125) snack = null;
  }

}