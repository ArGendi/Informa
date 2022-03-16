import 'package:informa/models/tool.dart';
import 'package:informa/models/workout_day.dart';

class WorkoutPreset{
  String? id;
  String? name;
  int? days;
  List<int>? levels;
  List<Tool>? tools;
  //1= standard, 2= drop, 3= super
  List<int>? techniques;
  //1= gym, 2= home, 3= both
  int? place;
  //0 = none, 1 = male, 2 = female, 3= both
  int? gender;
  int? specialCase;
  List<WorkoutDay>? program;

  WorkoutPreset({this.id, this.name, this.days, this.levels, this.tools,
      this.techniques, this.place, this.gender, this.specialCase});
}