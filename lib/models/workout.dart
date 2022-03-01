import 'package:informa/models/excercise.dart';
import 'package:informa/models/muscle.dart';
import 'package:informa/models/tool.dart';

class Workout{
  String? id;
  int? category;
  Exercise? exercise;
  Exercise? alternative;
  //1= standard, 2= drop, 3= super
  int? technique;
  int? numberOfReps;
  int? numberOfSets;
  int? restTime; //in sec
  Workout? otherWorkout;

  Workout({this.id, this.category, this.exercise, this.alternative, this.technique,
      this.numberOfReps, this.numberOfSets, this.restTime});
}