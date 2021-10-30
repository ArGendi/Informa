import 'package:flutter/material.dart';
import 'package:informa/models/workout.dart';
import 'package:informa/widgets/workout_banner.dart';

class FreeWorkoutScreen extends StatefulWidget {
  static String id = 'free workout';
  const FreeWorkoutScreen({Key? key}) : super(key: key);

  @override
  _FreeWorkoutScreenState createState() => _FreeWorkoutScreenState();
}

class _FreeWorkoutScreenState extends State<FreeWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('تمارين أنفورما'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Image.asset(
            'assets/images/Hands-Clapping-Chaulk-Kettlebell.jpg',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          //SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'تمارين صدر',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'CairoBold'
                      ),
                    ),
                    Text(
                      '(3) تمرين',
                      style: TextStyle(
                        //fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                WorkoutBanner(
                  workout: new Workout(
                    name: 'تمرين جديد',
                    level: 2,
                  ),
                ),
                SizedBox(height: 10,),
                WorkoutBanner(
                  workout: new Workout(
                    name: 'تمرين جديد',
                    level: 3,
                  ),
                ),
                SizedBox(height: 10,),
                WorkoutBanner(
                  workout: new Workout(
                    name: 'تمرين جديد',
                    level: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
