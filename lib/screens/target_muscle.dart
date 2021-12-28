import 'package:flutter/material.dart';
import 'package:informa/models/muscle.dart';
import 'package:informa/models/workout.dart';

class TargetMuscle extends StatelessWidget {
  final Muscle muscle;
  const TargetMuscle({Key? key, required this.muscle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.grey.shade300)
          ),
          child: Image.asset(
            muscle.image,
            fit: BoxFit.cover,
            width: 300,
          ),
        ),
        SizedBox(height: 5,),
        Text(
          muscle.name,
          style: TextStyle(
              color: Colors.grey[600]
          ),
        ),
      ],
    );
  }
}
