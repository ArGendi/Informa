import 'package:informa/models/excercise.dart';
import 'package:informa/models/workout.dart';

class Cardio extends Workout{
  //1= standard, 2= hiit
  int? technique;
  int? duration; //in minutes
  int? activeTime; //in sec

  fromCardioJson(Map<String, dynamic> json, List<Exercise> allExercises){
    technique = json['technique'];
    duration = json['duration'];
    activeTime = json['activeTime'];
    numberOfSets = json['numberOfSets'];
    restTime = json['restTime'];
    for(var tempExercise in allExercises)
      if(tempExercise.id == json['exercise'])
        exercise = tempExercise;
  }
}