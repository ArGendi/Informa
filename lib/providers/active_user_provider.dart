import 'package:flutter/cupertino.dart';
import 'package:informa/models/user.dart';

class ActiveUserProvider extends ChangeNotifier{
  User? _user;

  ActiveUserProvider(){
    _user = new User(
      name: 'Abdelrahman',
      email: 'new',
      premium: true,
      weight: 70,
      tall: 190,
      fatsPercent: 15,
      age: 22,
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

  setTall(int tall){
    _user!.tall = tall;
    notifyListeners();
  }

  setFitnessLevel(int level){
    _user!.fitnessLevel = level;
    notifyListeners();
  }


}