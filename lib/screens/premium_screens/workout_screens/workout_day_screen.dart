import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/workout_day.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/workout_card.dart';
import 'package:provider/provider.dart';

import '../../../providers/active_user_provider.dart';

class WorkOutDayScreen extends StatefulWidget {
  final int day;
  final int week;
  //final WorkoutDay workoutDay;
  const WorkOutDayScreen({Key? key, required this.day, required this.week,}) : super(key: key);

  @override
  _WorkOutDayScreenState createState() => _WorkOutDayScreenState();
}

class _WorkOutDayScreenState extends State<WorkOutDayScreen> with SingleTickerProviderStateMixin{
  late ConfettiController _confettiController;
  bool _dayDone = false;
  late AnimationController _animationController;
  late Animation<Offset> _offset;
  FirestoreService _firestoreService = new FirestoreService();

  Future<void> _showDoneDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('AlertDialog Title'),
          content: SlideTransition(
            position: _offset,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'بالهنا والشفة يا وحش',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Image.asset(
                  'assets/images/informa_nutrition.png',
                  width: 300,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'اغلاق',
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  onDone(BuildContext context) async{
    String errorMsg = '';
    var myWorkoutPreset = Provider.of<ActiveUserProvider>(context, listen: false).workoutPreset;
    WorkoutDay workoutDay = myWorkoutPreset!.weeksDays![widget.week-1]![widget.day-1];
    for(int i=0; i<workoutDay.warmUpSets!.length; i++){
      print('warmUpSets done: ' + workoutDay.warmUpSets![i].setsDone.toString());
      print('warmUpSets numberOfSets: ' + workoutDay.warmUpSets![i].numberOfSets.toString());
      if(workoutDay.warmUpSets![i].setsDone < workoutDay.warmUpSets![i].numberOfSets!)
        errorMsg = 'لم تنتهي من المجموعات';
    }
    for(int i=0; i<workoutDay.exercises!.length; i++){
      if(workoutDay.exercises![i].setsDone < workoutDay.exercises![i].numberOfSets!)
        errorMsg = 'لم تنتهي من المجموعات';
    }
    if(errorMsg.isEmpty){
      String id = FirebaseAuth.instance.currentUser!.uid;
      await _firestoreService.saveWorkoutInfoInHistory(
        id,
        widget.week,
        widget.day,
        workoutDay,
      );
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setWorkoutDayIsDone(widget.week-1, widget.day-1, true);
      //setState(() {_dayDone = true;});
      _showDoneDialog();
      _animationController.forward();
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              errorMsg,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
      );
    }
    //_confettiController.play();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(!this.mounted) return;
    //_dayDone = widget.workoutDay.isDone != null? widget.workoutDay.isDone! : false;
    _confettiController = ConfettiController(duration: Duration(seconds: 2));
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _offset = Tween<Offset>(
      begin: Offset(0, -2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var myWorkoutDay = Provider.of<ActiveUserProvider>(context)
        .workoutPreset!.weeksDays![widget.week-1]![widget.day-1];

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
            shrinkWrap: true,
            children: [
              Text(
                myWorkoutDay.name!,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: boldFont,
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Text(
                      '1- التسخين',
                      style: TextStyle(
                        fontSize: 17,
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
              SizedBox(height: 10,),
              Text(
                '2- مجموعات الاحماء',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: boldFont,
                ),
              ),
              SizedBox(height: 5,),
              for(int i=0; i<myWorkoutDay.warmUpSets!.length; i++)
                Column(
                  children: [
                    WorkoutCard(
                      workout: myWorkoutDay.warmUpSets![i],
                    ),
                    SizedBox(height: 5,),
                  ],
                ),
              SizedBox(height: 10,),
              Text(
                '3- المجموعات الأساسية',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: boldFont,
                ),
              ),
              SizedBox(height: 5,),
              for(int i=0; i<myWorkoutDay.exercises!.length; i++)
                Column(
                  children: [
                    WorkoutCard(
                      workout: myWorkoutDay.exercises![i],
                    ),
                    SizedBox(height: 5,),
                  ],
                ),
              SizedBox(height: 10,),
              // Text(
              //   '4- الكارديو',
              //   style: TextStyle(
              //     fontSize: 17,
              //     fontFamily: boldFont,
              //   ),
              // ),
              // SizedBox(height: 5,),
              // for(int i=0; i<widget.workoutDay.cardio!.length; i++)
              //   Column(
              //     children: [
              //       WorkoutCard(
              //         workout: widget.workoutDay.warmUpSets![i],
              //       ),
              //       SizedBox(height: 5,),
              //     ],
              //   ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Text(
                      '5- استرتشات',
                      style: TextStyle(
                        fontSize: 17,
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
              SizedBox(height: 20,),
              CustomButton(
                text: myWorkoutDay.isDone? 'عاش يا وحش' : 'تم',
                onClick: myWorkoutDay.isDone? (){} : (){
                  onDone(context);
                },
                iconExist: false,
                bgColor: myWorkoutDay.isDone? Colors.grey.shade400 : primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
