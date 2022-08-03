import 'package:flutter/cupertino.dart';
import 'package:informa/models/workout_day.dart';

class WorkoutDaysProvider extends ChangeNotifier{
  List<WorkoutDay> _days = [];

  List<WorkoutDay> get days => _days;

  addDay(WorkoutDay day){
    _days.add(day);
    notifyListeners();
  }

  removeDay(WorkoutDay day){
    _days.remove(day);
    notifyListeners();
  }
}