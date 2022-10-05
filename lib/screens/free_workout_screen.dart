import 'package:flutter/material.dart';
import 'package:informa/models/muscle.dart';
import 'package:informa/widgets/workout_banner.dart';

import '../constants.dart';

class FreeWorkoutScreen extends StatefulWidget {
  static String id = 'free workout';
  final Muscle muscle;
  const FreeWorkoutScreen({Key? key, required this.muscle}) : super(key: key);

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
        leading: IconButton(
          splashRadius: splashRadius,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png'))),
        child: ListView(
          children: [
            Image.asset(
              widget.muscle.image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            //SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: widget.muscle.exercises!.isNotEmpty
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'التمارين',
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'CairoBold'),
                            ),
                            Text(
                              '(' +
                                  widget.muscle.exercises!.length.toString() +
                                  ')' +
                                  ' تمرين',
                              style: TextStyle(
                                //fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        for (var workout in widget.muscle.exercises!)
                          Column(
                            children: [
                              WorkoutBanner(
                                exercise: workout,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                      ],
                    )
                  : Center(
                      child: Text(
                        'لا يوجد تمارين الأن',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
