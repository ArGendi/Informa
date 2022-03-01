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
}