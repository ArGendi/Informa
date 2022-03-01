import 'package:informa/models/excercise.dart';
import 'package:informa/models/workout.dart';

class Muscle{
  String? id;
  String name;
  String image;
  String? imageInFullBody;
  List<Exercise>? exercises;

  Muscle({this.id, required this.name, required this.image, this.exercises, this.imageInFullBody});
}