import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/workout_day.dart';
import 'package:informa/screens/premium_screens/workout_screens/workout_day_screen.dart';
import 'package:provider/provider.dart';

import '../providers/active_user_provider.dart';

class WeekRow extends StatefulWidget {
  final int week;

  const WeekRow({Key? key, required this.week,}) : super(key: key);


  @override
  _WeekRowState createState() => _WeekRowState();
}

class _WeekRowState extends State<WeekRow> {

  Color getColor(WorkoutDay workoutDay){
    print('from week row widget: ' + workoutDay.toString());
    if(workoutDay.status == 1) return Colors.grey.shade300;
    else if(workoutDay.status == 2) return primaryColor;
    else return Colors.green;

  }

  @override
  Widget build(BuildContext context) {
    var myWorkoutPreset = Provider.of<ActiveUserProvider>(context).workoutPreset;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الأسبوع ' + widget.week.toString(),
          style: TextStyle(
            fontSize: 17,
            fontFamily: boldFont,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < 7; i++)
              InkWell(

                onTap: (){
                  if(myWorkoutPreset!.weeksDays![widget.week-1]![i].status != 1)

                    Navigator.push(

                    context,
                    MaterialPageRoute(builder: (context) => WorkOutDayScreen(
                      week: widget.week,
                      day: i+1,
                      // workoutDay: widget.days[i],
                      //workoutDay: widget.days[i],
                      // workoutDay: WorkoutDay(
                      //   name: 'يوم جامد',
                      //   warmUpSets: [
                      //     Workout(
                      //       exercise: Exercise(name: 'احماء 1'),
                      //       fromReps: 5,
                      //       toReps: 10,
                      //       numberOfSets: 4,
                      //       restTime: 30,
                      //     ),
                      //     Workout(
                      //       exercise: Exercise(name: 'احماء 2'),
                      //       fromReps: 5,
                      //       toReps: 10,
                      //       numberOfSets: 4,
                      //       restTime: 30,
                      //     ),
                      //   ],
                      //   exercises: [
                      //     Workout(
                      //       exercise: Exercise(name: 'تمرين 1'),
                      //       fromReps: 5,
                      //       toReps: 10,
                      //       numberOfSets: 4,
                      //       restTime: 30,
                      //     ),
                      //   ],
                      // ),
                    )),
                  );

                },
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: BoxDecoration(
                    color: getColor(myWorkoutPreset!.weeksDays![widget.week-1]![i]),
                    borderRadius: BorderRadius.circular(5),
                    //border: Border.all(color: Colors.white),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
                    child: Center(
                      child: Text(
                        (i + 1).toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
