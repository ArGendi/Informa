import 'package:informa/models/cardio.dart';
import 'package:informa/models/workout.dart';


class WorkoutDay{
  String? id;
  String? programId;
  int? day;
  String? name;
  List<String>? warmUps = [];
  List<Workout>? warmUpSets = [];
  List<Workout>? exercises = [];
  List<Cardio>? cardio = [];
  List<String>? stretching = [];
  //1= rest, 2= still, 3= done
  int status;
  bool isDone;

  WorkoutDay({this.id, this.programId, this.day, this.name, this.warmUps, this.warmUpSets, this.exercises,
    this.cardio, this.stretching, this.status = 1, this.isDone = false});

  copyObject(WorkoutDay workoutDay){
    id = workoutDay.id;
    programId = workoutDay.programId;
    day = workoutDay.day;
    name = workoutDay.name;
    warmUps = workoutDay.warmUps;
    warmUpSets = workoutDay.warmUpSets;
    exercises = workoutDay.exercises;
    cardio = workoutDay.cardio;
    stretching = workoutDay.stretching;
    status = workoutDay.status;
    isDone = workoutDay.isDone;
  }

   List<Map> getWorkoutIdAndSetsOfWorkoutList(List<Workout>? list){
     List<Map> returnList = [];
     for(var item in list!){
       Map map = new Map();
       map['workoutId'] = item.id;
       List<Map> sets = [];
       for(var set in item.sets){
         sets.add({
           'weight': set.weight,
           'number': set.number,
         });
       }
       map['sets'] = sets;
       returnList.add(map);
     }
     return returnList;
   }

  ///json for workout history
  Map<String, dynamic> toWorkoutHistoryJson(){
    return {
      'isDone': isDone,
      'warmUps': getWorkoutIdAndSetsOfWorkoutList(warmUpSets),
      'exercises': getWorkoutIdAndSetsOfWorkoutList(exercises),
    };
  }

  List<String> convertWorkoutListToIdsList(List workouts){
    List<String> ids = [];
    for(var workout in workouts){
      ids.add(workout.id);
    }
    return ids;
  }

  Map<String, dynamic> toJson(){
    return {
      'day': day,
      'name': name,
      'warmUps': warmUps,
      'warmUpSets': warmUpSets != null? convertWorkoutListToIdsList(warmUpSets!) : null,
      'exercises': exercises != null? convertWorkoutListToIdsList(exercises!) : null,
      'cardio': cardio != null? convertWorkoutListToIdsList(cardio!) : null,
      'stretching': stretching,
    };
  }

  fromJson(Map<String, dynamic> json, List<Workout> allWorkouts, List<Cardio> allCardio){
    day = json['day'];
    name = json['name'];
    warmUps = json['warmUps'] != null ? json['warmUps'].cast<String>() : null;
    warmUpSets = json['warmUpSets'] != null ?
    getWorkoutsByIds(allWorkouts, json['warmUpSets']) : null;
    exercises = json['exercises'] != null ?
    getWorkoutsByIds(allWorkouts, json['exercises']) : null;
    cardio = json['cardio'] != null ?
    getCardioByIds(allCardio, json['cardio']) : null;
    stretching = json['stretching'] != null ? json['stretching'].cast<String>() : null;
  }

  List<Workout> getWorkoutsByIds(List<Workout> allWorkouts, List ids){
    List<Workout> workoutsList = [];
    for(var workout in allWorkouts){
      if(ids.contains(workout.id)) workoutsList.add(workout);
    }
    return workoutsList;
  }

  List<Cardio> getCardioByIds(List<Cardio> allCardio, List ids){
    List<Cardio> cardioList = [];
    for(var workout in allCardio){
      if(ids.contains(workout.id)) cardioList.add(workout);
    }
    return cardioList;
  }

}