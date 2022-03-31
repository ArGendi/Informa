import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/workout.dart';
import 'package:informa/widgets/countdown_card.dart';
import 'package:informa/widgets/custom_textfield.dart';

class WorkoutCard extends StatefulWidget {
  final Workout workout;
  const WorkoutCard({Key? key, required this.workout}) : super(key: key);

  @override
  _WorkoutCardState createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  bool _playRest = false;
  int _restSeconds = 0;
  var _formKey = GlobalKey<FormState>();
  int? _numberOfRepsDone;
  int? _weightDone;

  DateTime getTimeAfter30Sec(){
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour, now.minute,
        now.second + 30);
  }

  DateTime getRestTime(){
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour, now.minute,
        now.second + widget.workout.restTime!);
  }

  onSetDone(BuildContext context){
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid){

    }
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
                  widget.workout.fromReps.toString() + ' - ' + widget.workout.toReps.toString() + ' عدات',
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
                SizedBox(height: 10,),
                Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          text: 'الوزن',
                          obscureText: false,
                          textInputType: TextInputType.number,
                          setValue: (value){
                            _weightDone = int.parse(value.trim());
                          },
                          validation: (value){
                            if(value.isEmpty) return 'أدخل الوزن';
                            return null;
                          },
                          anotherFilledColor: true,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: CustomTextField(
                          text: 'العدد',
                          obscureText: false,
                          textInputType: TextInputType.number,
                          setValue: (value){
                            _numberOfRepsDone = int.parse(value.trim());
                          },
                          validation: (value){
                            if(value.isEmpty) return 'أدخل العدد';
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
              onPressed: (){
                onSetDone(context);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white
      ),
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
                    Container(
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
                    SizedBox(width: 5,),
                    InkWell(
                      onTap: (){
                        _restSeconds = widget.workout.restTime!;
                        Timer.periodic(Duration(seconds: 1), (Timer t) => setState((){
                          _restSeconds = widget.workout.restTime! - t.tick;
                          if(_restSeconds == 0){
                            t.cancel();
                          }
                        }));
                        setState(() {
                          _playRest = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                          child: !_playRest? Row(
                            children: [
                              Text(
                                'راحة',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 3,),
                              Icon(
                                Icons.restore_sharp,
                                color: Colors.white,
                              ),
                            ],
                          ) :  Text(
                            _restSeconds >= 10 ? _restSeconds.toString() : '0' + _restSeconds.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    InkWell(
                      onTap: (){
                        _restSeconds = 30;
                        Timer.periodic(Duration(seconds: 1), (Timer t) => setState((){
                          _restSeconds = 30 - t.tick;
                          if(_restSeconds == 0){
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
            SizedBox(height: 20,),
            Row(
              children: [
                for(int i=0; i<widget.workout.numberOfSets!; i++)
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 1,
                      color: Colors.grey[200],
                    ),
                    Icon(
                      Icons.check_circle,
                      color: widget.workout.setsDone >= i+1 ? Colors.green : Colors.grey[400],
                      size: 20,
                    ),
                    Container(
                      width: 28,
                      height: 1,
                      color: Colors.grey[200],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                for(int i=0; i<widget.workout.numberOfSets!; i++)
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          if(i <= widget.workout.setsDone)
                            _showGroupDialog(context, i+1);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'مجموعة \n' + '(' +(i+1).toString() + ")",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                height: 1.7,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
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
