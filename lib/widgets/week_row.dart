import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/workout_day.dart';

class WeekRow extends StatefulWidget {
  final int week;
  final List<WorkoutDay> days;
  const WeekRow({Key? key, required this.week, required this.days}) : super(key: key);

  @override
  _WeekRowState createState() => _WeekRowState();
}

class _WeekRowState extends State<WeekRow> {
  Color getColor(WorkoutDay workoutDay){
    if(workoutDay.status == 1) return Colors.grey.shade400;
    else if(workoutDay.status == 2) return primaryColor;
    else return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
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
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for(int i=0; i<7; i++)
              Container(
                decoration: BoxDecoration(
                  color: getColor(widget.days[i]),
                  borderRadius: BorderRadius.circular(5),
                  //border: Border.all(color: Colors.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 8),
                  child: Center(
                    child: Text(
                      (i+1).toString(),
                      style: TextStyle(
                        color: Colors.white,
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
