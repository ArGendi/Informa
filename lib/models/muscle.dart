import 'package:informa/models/workout.dart';

class Muscle{
  String? id;
  String name;
  String image;
  String? imageInFullBody;
  List<Workout>? workouts;

  Muscle({this.id, required this.name, required this.image, this.workouts, this.imageInFullBody});
}