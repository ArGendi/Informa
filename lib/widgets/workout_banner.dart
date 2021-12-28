import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/workout.dart';
import 'package:informa/screens/single_workout_screen.dart';

class WorkoutBanner extends StatefulWidget {
  final Workout workout;

  const WorkoutBanner({Key? key, required this.workout}) : super(key: key);

  @override
  _WorkoutBannerState createState() => _WorkoutBannerState();
}

class _WorkoutBannerState extends State<WorkoutBanner> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SingleWorkoutScreen(
            workout: widget.workout,
          )),
        );
      },
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.workout.name!,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    widget.workout.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Image.asset(
                widget.workout.image!,
                width: 130,
                //height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
