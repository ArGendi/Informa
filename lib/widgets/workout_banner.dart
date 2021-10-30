import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/workout.dart';

class WorkoutBanner extends StatefulWidget {
  final Workout workout;

  const WorkoutBanner({Key? key, required this.workout}) : super(key: key);

  @override
  _WorkoutBannerState createState() => _WorkoutBannerState();
}

class _WorkoutBannerState extends State<WorkoutBanner> {
  String _level = 'لا يوجد';

  setLevel(){
    if(widget.workout.level == 1) _level = 'ضعيف';
    else if(widget.workout.level == 2) _level = 'متوسط';
    else if(widget.workout.level == 3) _level = 'قوي';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.workout.name!,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'العضلة المستهدفة, الصدر العلوي',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: widget.workout.level! >= 1 ? primaryColor : Colors.grey[300],
                        borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                          color: widget.workout.level! >= 2 ? primaryColor : Colors.grey[300],
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                          color: widget.workout.level! >= 3 ? primaryColor : Colors.grey[300],
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2,),
                Text(
                  'مستوي التمرين: ' + _level,
                  style: TextStyle(
                    fontSize: 9,
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
              'assets/images/Hands-Clapping-Chaulk-Kettlebell.jpg',
              width: 120,
              //height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
