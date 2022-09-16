import 'package:informa/models/excercise.dart';
import 'package:informa/models/workout_set.dart';

class Workout {
  String? id;
  int? category;
  Exercise? exercise;
  Exercise? alternative;
  //1= standard, 2= drop, 3= super
  List<int>? techniques;
  int? fromReps;
  int? toReps;
  int? numberOfSets;
  int? restTime; //in sec
  int setsDone;
  List<WorkoutSet> sets = [];
  Workout? superWorkout;

  Workout({
    this.id,
    this.category,
    this.exercise,
    this.alternative,
    this.techniques,
    this.fromReps,
    this.toReps,
    this.numberOfSets,
    this.restTime,
    this.setsDone = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'exercise': exercise?.id,
      'alternative': alternative?.id,
      'techniques': techniques,
      'fromReps': fromReps,
      'toReps': toReps,
      'numberOfSets': numberOfSets,
      'restTime': restTime,
      'superWorkout': superWorkout != null
          ? {
              'category': superWorkout?.category,
              'exercise': superWorkout?.exercise?.id,
              'alternative': superWorkout?.alternative?.id,
              'techniques': superWorkout?.techniques,
              'fromReps': superWorkout?.fromReps,
              'toReps': superWorkout?.toReps,
              'numberOfSets': superWorkout?.numberOfSets,
              'restTime': superWorkout?.restTime,
            }
          : null,
    };
  }

  fromJson(Map<String, dynamic> json, List<Exercise> allExercises) {
    category = json['category'];
    exercise = getExerciseById(allExercises, json['exercise']);
    alternative = getExerciseById(allExercises, json['alternative']);
    techniques = json['techniques'].cast<int>();
    fromReps = json['fromReps'];
    toReps = json['toReps'];
    numberOfSets = json['numberOfSets'];
    restTime = json['restTime'];
    if (json['superWorkout'] != null) {
      Workout newWorkout = new Workout();
      newWorkout.fromJson(json['superWorkout'], allExercises);
      superWorkout = newWorkout;
    } else
      superWorkout = null;
  }

  Exercise? getExerciseById(List<Exercise> allExercises, String id) {
    for (var exercise in allExercises) {
      if (exercise.id == id) return exercise;
    }
    return null;
  }
}
