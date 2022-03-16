import 'package:informa/models/cardio.dart';
import 'package:informa/models/workout.dart';

class WorkoutDay{
  int? day;
  String? name;
  List<Workout>? warmUps = [];
  List<Workout>? warmUpSets = [];
  List<Workout>? exercises = [];
  List<Cardio>? cardio = [];
  List<Workout>? stretching = [];
  //1= rest, 2= still, 3= done
  int? status = 1;

  WorkoutDay({this.day, this.name, this.warmUps, this.warmUpSets, this.exercises,
      this.cardio, this.stretching, this.status});
}