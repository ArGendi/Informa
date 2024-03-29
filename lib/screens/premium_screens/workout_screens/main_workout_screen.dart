import 'package:flutter/material.dart';
import 'package:informa/models/workout_day.dart';
import 'package:informa/widgets/week_row.dart';

import '../../../constants.dart';

class MainWorkoutScreen extends StatefulWidget {
  const MainWorkoutScreen({Key? key}) : super(key: key);

  @override
  _MainWorkoutScreenState createState() => _MainWorkoutScreenState();
}

class _MainWorkoutScreenState extends State<MainWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: ListView(
          children: [
            Container(
              height: 60,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'شرح مفاهيم',
                      style: TextStyle(
                        fontFamily: boldFont,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Card(
                      elevation: 0,
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          //size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 7,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'انتهيت منه',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 7,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'متبقي',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            radius: 7,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'راحة',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  WeekRow(
                    week: 1,
                    days: [
                      WorkoutDay(status: 1,),
                      WorkoutDay(status: 1,),
                      WorkoutDay(status: 3,),
                      WorkoutDay(status: 1,),
                      WorkoutDay(status: 2,),
                      WorkoutDay(status: 2,),
                      WorkoutDay(status: 1,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  WeekRow(
                    week: 2,
                    days: [
                      WorkoutDay(status: 1,),
                      WorkoutDay(status: 1,),
                      WorkoutDay(status: 2,),
                      WorkoutDay(status: 1,),
                      WorkoutDay(status: 2,),
                      WorkoutDay(status: 2,),
                      WorkoutDay(status: 1,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  WeekRow(
                    week: 3,
                    days: [
                      WorkoutDay(status: 1,),
                      WorkoutDay(status: 1,),
                      WorkoutDay(status: 2,),
                      WorkoutDay(status: 1,),
                      WorkoutDay(status: 2,),
                      WorkoutDay(status: 2,),
                      WorkoutDay(status: 1,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  WeekRow(
                    week: 4,
                    days: [
                      WorkoutDay(status: 1,),
                      WorkoutDay(status: 1,),
                      WorkoutDay(status: 2,),
                      WorkoutDay(status: 1,),
                      WorkoutDay(status: 2,),
                      WorkoutDay(status: 2,),
                      WorkoutDay(status: 1,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
