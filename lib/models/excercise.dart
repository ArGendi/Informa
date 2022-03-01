import 'package:informa/models/tool.dart';

import 'muscle.dart';

class Exercise{
  String? id;
  String? name;
  String? description;
  String? image;
  String? video;
  int? category;
  //1= target, 2= helper, 3= settled
  int? muscleType;
  //1= gym, 2= home, 3= both
  int? place;
  List<Tool> tools = [];
  List<Muscle> mainTargetMuscles = [
    Muscle(
      name: 'عضلة 1',
      image: 'assets/images/selected_body_chest.png',
    ),
    Muscle(
      name: 'عضلة 2',
      image: 'assets/images/selected_body_chest.png',
    ),
    Muscle(
      name: 'عضلة 3',
      image: 'assets/images/selected_body_chest.png',
    ),
  ];
  List<Muscle> helpersMuscles = [
    Muscle(
      name: 'عضلة 1',
      image: 'assets/images/selected_body_chest.png',
    ),
    Muscle(
      name: 'عضلة 2',
      image: 'assets/images/selected_body_chest.png',
    ),
  ];
  List<Muscle> settlersMuscles = [
    Muscle(
      name: 'عضلة 1',
      image: 'assets/images/selected_body_chest.png',
    ),
  ];

  Exercise({this.name, this.id, this.description, this.image, this.video, this.category,
      this.muscleType, this.place,});
}