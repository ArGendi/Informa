import 'dart:async';

import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/providers/challenges_provider.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class PrepareProgramScreen extends StatefulWidget {
  static String id = 'prepare program';
  const PrepareProgramScreen({Key? key}) : super(key: key);

  @override
  _PrepareProgramScreenState createState() => _PrepareProgramScreenState();
}

class _PrepareProgramScreenState extends State<PrepareProgramScreen> {
  Timer? _timer;
  int _counter = 25;
  double _percent = 0.0;
  String _text = '0%';
  bool _dataPrepared = false;
  bool _workoutSchedulePrepared = false;
  bool _dailyTasksPrepared = false;
  FirestoreService _firestoreService = new FirestoreService();

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_counter == 0) {
          setState(() {
            timer.cancel();
          });
          Navigator.of(context)
              .pushNamedAndRemoveUntil(MainScreen.id, (Route<dynamic> route) => false);
        }
        else if (_counter == 22){
          setState(() {
            _percent = 0.19;
            _text = '19%';
            _dataPrepared = true;
          });
        }
        else if (_counter == 14){
          setState(() {
            _percent = 0.45;
            _text = '45%';
            _workoutSchedulePrepared = true;
          });
        }
        else if (_counter == 7){
          setState(() {
            _percent = 0.73;
            _text = '73%';
            _dailyTasksPrepared = true;
          });
        }
        else if (_counter == 1){
          setState(() {
            _percent = 1.0;
            _text = '100%';
          });
        }
        _counter--;
      },
    );
  }

  getChallenges() async{
    List<Challenge> challenges = await _firestoreService.getAllChallenges();
    Provider.of<ChallengesProvider>(context, listen: false)
        .setChallenges(challenges);
  }

  @override
  void dispose(){
    _timer!.cancel();
    HelpFunction.saveInitScreen(MainScreen.id);
    super.dispose();
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    startTimer();
    if(mounted){
      getChallenges();
    }
  }

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 140.0,
                lineWidth: 7.0,
                percent: _percent,
                animation: true,
                animateFromLastPercent: true,
                center: Text(
                  _text,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                progressColor: primaryColor,
                backgroundColor: Colors.grey.shade300,
              ),
              SizedBox(height: 25,),
              Text(
                'جاري تحضير برنامجك',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'CairoBold',
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: _dataPrepared ? Colors.green : Colors.grey[300],
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 13,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    'نقوم بعمل تحليل لبيناتك' + '''          ''',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'CairoBold',
                        color: _dataPrepared ? Colors.black : Colors.grey
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: _workoutSchedulePrepared ? Colors.green : Colors.grey[300],
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 13,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    'جاري تحضير جدول التمرين' + '''         ''',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'CairoBold',
                        color: _workoutSchedulePrepared ? Colors.black : Colors.grey
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: _dailyTasksPrepared ? Colors.green : Colors.grey[300],
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 13,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    'جاري تصمميم المهام اليومية',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'CairoBold',
                        color: _dailyTasksPrepared ? Colors.black : Colors.grey
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
