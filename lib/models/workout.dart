import 'package:informa/models/muscle.dart';

class Workout{
  int? id;
  String? name;
  String? description;
  int? level;
  List<Muscle> targetMuscles = [
    Muscle(
      name: 'عضلة 1',
      imageUrl: 'assets/images/selected_body_chest.png',
    ),
    Muscle(
      name: 'عضلة 2',
      imageUrl: 'assets/images/selected_body_chest.png',
    ),
    Muscle(
      name: 'عضلة 3',
      imageUrl: 'assets/images/selected_body_chest.png',
    ),
    Muscle(
      name: 'عضلة 4',
      imageUrl: 'assets/images/selected_body_chest.png',
    ),
  ];

  Workout({this.name, this.id, this.description, this.level});
}