import 'package:informa/models/muscle.dart';

class MusclesList {
  static List<Muscle> allMuscles = [
    Muscle(
      id: '1',
      name: 'الصدر',
      image: 'assets/images/Hands-Clapping-Chaulk-Kettlebell.jpg',
      exercises: [
        // Workout(
        //   id: '1',
        //   name: 'بنش بريس',
        //   image: 'assets/images/Hands-Clapping-Chaulk-Kettlebell.jpg',
        //   video: 'https://www.youtube.com/watch?v=GgB3okbbZr0',
        //   description: 'بنش بريس هو تمرين يساعد علي اي حاجة',
        // ),
        // Workout(
        //   id: '2',
        //   name: 'بنش بريس',
        //   image: 'assets/images/Hands-Clapping-Chaulk-Kettlebell.jpg',
        //   video: 'https://www.youtube.com/watch?v=GgB3okbbZr0',
        //   description: 'بنش بريس هو تمرين يساعد علي اي حاجة',
        // ),
      ],
    ),
    Muscle(
      id: '2',
      name: 'البطن',
      image: 'assets/images/selected_body_chest.png',
      exercises: [],
    ),
    Muscle(
      id: '3',
      name: 'كتف امامي',
      image: 'assets/images/selected_body_chest.png',
      exercises: [],
    ),
    Muscle(
      id: '4',
      name: 'كتف جانبي',
      image: 'assets/images/selected_body_chest.png',
      exercises: [],
    ),
    Muscle(
      id: '5',
      name: 'كتف خلفي',
      image: 'assets/images/selected_body_chest.png',
      exercises: [],
    ),
  ];
}
