import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/workout.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/screens/target_muscle.dart';
import 'package:informa/screens/video_player_screen.dart';
import 'package:provider/provider.dart';

class SingleWorkoutScreen extends StatefulWidget {
  static String id = 'single workout';
  final Workout workout;
  const SingleWorkoutScreen({Key? key, required this.workout}) : super(key: key);

  @override
  _SingleWorkoutScreenState createState() => _SingleWorkoutScreenState();
}

class _SingleWorkoutScreenState extends State<SingleWorkoutScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              widget.workout.name!,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'CairoBold',
                              ),
                            ),
                            Text(
                              widget.workout.description!,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: IconButton(
                          onPressed: (){
                            if(!activeUser!.premium){
                              Navigator.pushNamed(context, PlansScreen.id);
                            }
                            else{
                              setState(() {
                                _isFavorite = !_isFavorite;
                              });
                            }
                          },
                          splashRadius: 5,
                          icon: Icon(
                            _isFavorite ? Icons.bookmark_outlined : Icons.bookmark_outline,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'شاهد التمرين',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: screenSize.width,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(borderRadius),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(widget.workout.image!)
                      )
                    ),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoPlayerScreen(
                            url: widget.workout.video!,
                          )),
                        );
                      },
                      child: Center(
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text(
                    'العضلات المستهدفة',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                    ),
                  ),
                  SizedBox(height: 20,),

                  // Main target muscles
                  Column(
                    children: [
                      for(int i=0; i<widget.workout.mainTargetMuscles.length; i+=2)
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TargetMuscle(muscle:widget.workout.mainTargetMuscles[i],),
                                i+1 != widget.workout.mainTargetMuscles.length ?
                                Row(
                                  children: [
                                    SizedBox(width: 40,),
                                    TargetMuscle(muscle:widget.workout.mainTargetMuscles[i+1],),
                                  ],
                                ) : Container(),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),

                  SizedBox(height: 15,),
                  Text(
                    'العضلات المساعدة',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                    ),
                  ),
                  SizedBox(height: 20,),
                  // Other target muscles
                  Column(
                    children: [
                      for(int i=0; i<widget.workout.otherTargetMuscles.length; i+=2)
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TargetMuscle(muscle:widget.workout.otherTargetMuscles[i],),
                                i+1 != widget.workout.otherTargetMuscles.length ?
                                Row(
                                  children: [
                                    SizedBox(width: 40,),
                                    TargetMuscle(muscle:widget.workout.otherTargetMuscles[i+1],),
                                  ],
                                ) : Container(),
                              ],
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                    ],
                  ),
                  //Button
                  InkWell(
                    onTap: (){
                      if(!activeUser!.premium){
                        Navigator.pushNamed(context, PlansScreen.id);
                      }
                    },
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Ink(
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              'أضافة التمرين ضمن برنامجي التدريبي',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'CairoBold',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
