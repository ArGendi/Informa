import 'dart:async';

import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/workout.dart';
import 'package:informa/models/workout_set.dart';

import 'package:informa/screens/single_workout_screen.dart';
import 'package:informa/widgets/countdown_card.dart';

import 'package:informa/widgets/custom_textfield.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WorkoutCard extends StatefulWidget {
  final Workout workout;
  const WorkoutCard({Key? key, required this.workout}) : super(key: key);
  @override
  _WorkoutCardState createState() => _WorkoutCardState(workout);
}

class _WorkoutCardState extends State<WorkoutCard> {
  bool _playRest = false;
  int _restSeconds = 0;
  var _formKey = GlobalKey<FormState>();
  int? _numberOfRepsDone;
  int? _weightDone;
  late Workout _workout;
  Timer? _timer;
  double _percent = 1.0;
  String _text = '0';
  bool _restDone = false;
  late int _counter;
  void startTimer() {
    print('counter: ' + _counter.toString());
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_counter == 0) {
          setState(() {
            timer.cancel();
            _restDone = true;
          });
        }
        _counter -= 1;
        print('counter: ' + _counter.toString());
        setState(() {
          _percent = (_counter * 100) / _workout.restTime!;
          _text = _counter.toString();
          print('text: ' + _text);
        });
      },
    );
  }

  DateTime getTimeAfter30Sec() {
    DateTime now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second + 30);
  }

  DateTime getRestTime() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour, now.minute,
        now.second + widget.workout.restTime!);
  }

  onSetDone(BuildContext context, int groupNumber) {
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if (valid) {
      _formKey.currentState!.save();
      setState(() {
        if (groupNumber > _workout.setsDone) {
          _workout.setsDone += 1;
          _workout.sets.add(WorkoutSet(
            number: _numberOfRepsDone,
            weight: _weightDone,
          ));
        } else {
          _workout.sets[groupNumber - 1].weight = _weightDone;
          _workout.sets[groupNumber - 1].number = _numberOfRepsDone;
        }
      });
      Navigator.pop(context);
    }
  }

  showRestBottomSheet() {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      builder: (BuildContext context) {
        const oneSec = const Duration(seconds: 1);
        _timer = new Timer.periodic(
          oneSec,
          (Timer timer) {
            if (_counter == 0) {
              setState(() {
                timer.cancel();
                _restDone = true;
              });
            }
            _counter -= 1;
            print('counter: ' + _counter.toString());
            setState(() {
              _percent = (_counter) / _workout.restTime!;
              _text = _counter.toString();
              print('text: ' + _text);
            });
          },
        );
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'وقت الراحة',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: boldFont,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                  progressColor: Colors.green,
                  backgroundColor: Colors.grey.shade300,
                ),
              ],
            ),
          );
        });
      },
    );
  }

  _showGroupDialog(BuildContext context, int groupNumber) async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'مجموعة ' + groupNumber.toString(),
            style: TextStyle(
              color: primaryColor,
              fontSize: 17,
              fontFamily: boldFont,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'مطلوب منك',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  widget.workout.fromReps.toString() +
                      ' - ' +
                      widget.workout.toReps.toString() +
                      ' عدات',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  'أدخل الوزن x العدات',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          text: 'الوزن',
                          obscureText: false,
                          textInputType: TextInputType.number,
                          setValue: (value) {
                            _weightDone = int.parse(value.trim());
                          },
                          validation: (value) {
                            if (value.isEmpty) return 'أدخل الوزن';
                            return null;
                          },
                          anotherFilledColor: true,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          text: 'العدد',
                          obscureText: false,
                          textInputType: TextInputType.number,
                          setValue: (value) {
                            _numberOfRepsDone = int.parse(value.trim());
                          },
                          validation: (value) {
                            if (value.isEmpty) return 'أدخل العدد';
                            return null;
                          },
                          anotherFilledColor: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onSetDone(context, groupNumber);
              },
              child: const Text(
                'تم',
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'العودة',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _WorkoutCardState(Workout workout) {
    //print(workout.sets[0].weight.toString() + " - " + workout.sets[0].number.toString());
    // _workout = workout;
    // _counter = workout.restTime!;
    // _text = workout.restTime.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _workout = widget.workout;
    _counter = widget.workout.restTime!;
    _text = widget.workout.restTime.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.workout.exercise!.name!,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: boldFont,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: (){
                        print('name: ' + widget.workout.exercise!.name.toString());
                        print('target mu: ' + widget.workout.exercise!.targetMuscles.toString());

                        if(widget.workout.exercise != null)
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SingleWorkoutScreen(exercise: widget.workout.exercise!)),
                          );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        //showRestBottomSheet();
                        setState(() {
                          _playRest = true;
                        });
                        _restSeconds = widget.workout.restTime!;
                        Timer.periodic(
                            Duration(seconds: 1),
                            (Timer t) => setState(() {
                                  _restSeconds =
                                      widget.workout.restTime! - t.tick;
                                  if (_restSeconds == 0) {
                                    t.cancel();
                                  }
                                }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8),
                          child: !_playRest
                              ? Row(
                                  children: [
                                    Text(
                                      'راحة',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Icon(
                                      Icons.restore_sharp,
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              : Text(
                                  _restSeconds >= 10
                                      ? _restSeconds.toString()
                                      : '0' + _restSeconds.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    InkWell(
                      onTap: () {
                        _restSeconds = 30;
                        Timer.periodic(
                            Duration(seconds: 1),
                            (Timer t) => setState(() {
                                  _restSeconds = 31 - t.tick;
                                  if (_restSeconds == 0) {
                                    t.cancel();
                                  }
                                }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                for (int i = 0; i < widget.workout.numberOfSets!; i += 4)
                  Column(
                    children: [
                      Row(
                        children: [

                          for(int j=i; j<i+4; j++)
                            if(j < widget.workout.numberOfSets!)
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    if(_workout.sets.isNotEmpty) {
                                      setState(() {
                                        _playRest = false;
                                      });
                                      _showGroupDialog(context, j + 1);
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: _workout.sets.isNotEmpty ? Colors.green : Colors.grey[300],
                                        size: 20,
                                      ),
                                      SizedBox(height: 5,),
                                      Container(
                                        width: 75,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(
                                            color: _workout.sets.isNotEmpty? Colors.green : primaryColor,
                                          ),
                                          color: _workout.sets.isNotEmpty? Colors.grey[50] : primaryColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              _workout.sets.isNotEmpty? '(${_workout.sets[j].weight}) \nx\n (${_workout.sets[j].number})' :
                                              'مجموعة \n' + '(' +(j+1).toString() + ")",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: _workout.sets.isNotEmpty? Colors.black : Colors.white,
                                                fontSize: 14,
                                                height: _workout.sets.isNotEmpty? 1 : 1.7,

                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
