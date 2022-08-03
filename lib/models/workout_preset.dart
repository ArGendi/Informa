import 'package:informa/models/tool.dart';
import 'package:informa/models/tools_list.dart';
import 'package:informa/models/workout.dart';
import 'package:informa/models/workout_day.dart';

import 'cardio.dart';

class WorkoutPreset{
  String? id;
  String? programId;
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
  List<WorkoutDay>? programDays;

  WorkoutPreset({this.id, this.programId, this.name, this.days, this.levels, this.tools,
    this.techniques, this.place, this.gender, this.specialCase});

  List<int> convertToolsToIdsList(){
    List<int> ids = [];
    for(var tool in tools!){
      ids.add(tool.id!);
    }
    return ids;
  }

  List<String> convertProgramDaysToIdsList(){
    List<String> ids = [];
    for(var day in programDays!){
      ids.add(day.id!);
    }
    return ids;
  }

  List<Map<String, dynamic>> convertProgramDaysToListOfMaps(){
    List<Map<String, dynamic>> daysMaps = [];
    for(var day in programDays!){
      daysMaps.add(day.toJson());
    }
    return daysMaps;
  }

  List<WorkoutDay> convertListOfMapsToProgramDays(
      List<dynamic> daysMaps,
      List<Workout> allWorkouts,
      List<Cardio> allCardio,
      ){
    List<WorkoutDay> presetDays = [];
    for(var day in daysMaps){
      WorkoutDay workoutDay = new WorkoutDay();
      workoutDay.fromJson(day, allWorkouts, allCardio);
      presetDays.add(workoutDay);
    }
    return presetDays;
  }

  List<Tool> convertListOfIdsIntoTools(List ids){
    List<Tool> tools = [];
    for(var id in ids){
      tools.add(ToolsList.allTools[id-1]);
    }
    return tools;
  }

  List<WorkoutDay> getProgramDaysByIds(List<WorkoutDay> allDays, List ids){
    List<WorkoutDay> days = [];
    for(var day in allDays){
      if(ids.contains(day.id)) days.add(day);
    }
    return days;
  }

  Map<String, dynamic> toJson(){
    return {
      'programId': programId,
      'name': name,
      'days': days,
      'levels': levels,
      'tools': tools != null? convertToolsToIdsList() : null,
      'techniques': techniques,
      'place': place,
      'gender': gender,
      'specialCase': specialCase,
      'programDays': programDays != null? convertProgramDaysToListOfMaps() : null,
    };
  }

  fromJson(Map<String, dynamic> json, List<Workout> allWorkouts, List<Cardio> allCardio){
    programId = json['programId'];
    name = json['name'];
    days = json['days'];
    levels = json['levels'].cast<int>();
    tools = json['tools'] != null? convertListOfIdsIntoTools(json['tools']) : null;
    techniques = json['techniques'].cast<int>();
    place = json['place'];
    gender = json['gender'];
    specialCase = json['specialCase'];
    programDays = json['programDays'] != null ?
    convertListOfMapsToProgramDays(json['programDays'], allWorkouts, allCardio) : null;
  }

}