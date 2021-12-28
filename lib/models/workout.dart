import 'package:informa/models/muscle.dart';

class Workout{
  String? id;
  String? name;
  String? description;
  String? image;
  String? video;
  List<Muscle> mainTargetMuscles = [
    Muscle(
      name: 'عضلة 1',
      image: 'assets/images/selected_body_chest.png',
    ),
    Muscle(
      name: 'عضلة 2',
      image: 'assets/images/selected_body_chest.png',
    ),
  ];
  List<Muscle> otherTargetMuscles = [
    Muscle(
      name: 'عضلة 1',
      image: 'assets/images/selected_body_chest.png',
    ),
    Muscle(
      name: 'عضلة 2',
      image: 'assets/images/selected_body_chest.png',
    ),
  ];

  Workout({this.name, this.id, this.description, this.image, this.video});
}