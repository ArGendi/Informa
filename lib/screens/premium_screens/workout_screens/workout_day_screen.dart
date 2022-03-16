import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/workout_day.dart';

class WorkOutDayScreen extends StatefulWidget {
  final int day;
  final int week;
  final WorkoutDay workoutDay;
  const WorkOutDayScreen({Key? key, required this.day, required this.week, required this.workoutDay}) : super(key: key);

  @override
  _WorkOutDayScreenState createState() => _WorkOutDayScreenState();
}

class _WorkOutDayScreenState extends State<WorkOutDayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('يوم ' + widget.day.toString() + ', اسبوع ' + widget.week.toString()),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListView(
            children: [
              Text(
                widget.workoutDay.name!,
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: boldFont,
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Text(
                      'التسخين',
                      style: TextStyle(
                        fontSize: 18,
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
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 20,),
              Text(
                'مجموعات الاحماء',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: boldFont,
                ),
              ),
              SizedBox(height: 5,),
              for(int i=0; i<widget.workoutDay.warmUpSets!.length; i++)
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          (i+1).toString() + '- ' + widget.workoutDay.warmUpSets![i].exercise!.name!,
                          style: TextStyle(),
                        ),
                        SizedBox(width: 20,),
                        Card(
                          elevation: 0,
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              //size: 25,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                            child: Text(
                              'راحة',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              //size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
