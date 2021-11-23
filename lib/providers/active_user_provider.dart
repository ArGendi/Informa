import 'package:flutter/cupertino.dart';
import 'package:informa/models/user.dart';

class ActiveUserProvider extends ChangeNotifier{
  User? _user;

  ActiveUserProvider(){
    _user = new User(
      name: 'Abdelrahman',
      email: 'new',
      premium: true,
      weight: 80,
      tall: 170,
      fatsPercent: 15,
      age: 30,
    );
  }

  User? get user => _user;

  setUser(User user){
    _user = user;
    notifyListeners();
  }

  setGender(int gender){
    _user!.gender = gender;
    notifyListeners();
  }

  setProgram(int program){
    _user!.program = program;
    notifyListeners();
  }

  setGoal(int goal){
    _user!.goal = goal;
    notifyListeners();
  }

  setWorkoutPlace(int place){
    _user!.workoutPlace = place;
    notifyListeners();
  }

  setAge(int age){
    _user!.age = age;
    notifyListeners();
  }

  setWeight(int weight){
    _user!.weight = weight;
    notifyListeners();
  }

  setGoalWeight(int weight){
    _user!.goalWeight = weight;
    notifyListeners();
  }

  setTall(int tall){
    _user!.tall = tall;
    notifyListeners();
  }

  setFitnessLevel(int level){
    _user!.fitnessLevel = level;
    notifyListeners();
  }

  setTrainingPeriodLevel(int value){
    _user!.trainingPeriodLevel = value;
    notifyListeners();
  }

  addTrainingTool(int tool){
    if(!_user!.trainingTools.contains(tool))
      _user!.trainingTools.add(tool);
    notifyListeners();
  }

  removeTrainingTool(int tool){
    if(_user!.trainingTools.contains(tool))
      _user!.trainingTools.remove(tool);
    notifyListeners();
  }

}