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
      fatsPercent: 0,
      age: 30,
    );
  }

  User? get user => _user;

  setUser(User user){
    _user = user;
    notifyListeners();
  }

  setName(String name){
    _user!.name = name;
    notifyListeners();
  }

  setEmail(String email){
    _user!.email = email;
    notifyListeners();
  }

  setPassword(String pass){
    _user!.password = pass;
    notifyListeners();
  }

  setFromSocialMedia(bool value){
    _user!.fromSocialMedia = value;
    notifyListeners();
  }

  setPhoneNumber(String phone){
    _user!.phone = phone;
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

  setFatPercent(int percent){
    _user!.fatsPercent = percent;
    notifyListeners();
  }

  setNumberOfTrainingDays(int days){
    print("Entered with: " + days.toString());
    _user!.iTrainingDays = days;
    if(_user!.trainingDays.length > days){
      print(_user!.trainingDays);
      for(int i=_user!.trainingDays.length-1; i >= days; i--) {
        _user!.trainingDays.removeAt(i);
        print(_user!.trainingDays);
      }
      print("Length: " + _user!.trainingDays.length.toString());
    }
    notifyListeners();
  }

  addTrainingDay(int day){
    int trainingDays = _user!.iTrainingDays;
    if(!_user!.trainingDays.contains(day) && _user!.trainingDays.length < trainingDays)
      _user!.trainingDays.add(day);
    notifyListeners();
  }

  removeTrainingDay(int day){
    if(_user!.trainingDays.contains(day))
      _user!.trainingDays.remove(day);
    notifyListeners();
  }

}