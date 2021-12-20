import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/workout.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:provider/provider.dart';

class SingleWorkoutScreen extends StatefulWidget {
  static String id = 'single workout';
  final Workout workout;
  const SingleWorkoutScreen({Key? key, required this.workout}) : super(key: key);

  @override
  _SingleWorkoutScreenState createState() => _SingleWorkoutScreenState();
}

class _SingleWorkoutScreenState extends State<SingleWorkoutScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //widget.workout.targetMuscles.add();
  }

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
                  Column(
                    children: [
                      Text(
                        widget.workout.name!,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'CairoBold',
                        ),
                      ),
                      Text(
                        'مختصر عن التمرين',
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey
                        ),
                      ),
                      Divider(
                        height: 30,
                      ),
                    ],
                  ),
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
                    ),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      onPressed: (){},
                      child: Center(
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'العضلات المستهدفة والمساعدة',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                    ),
                  ),
                  SizedBox(height: 20,),

                  // Target muscles
                  Column(
                    children: [
                      for(int i=0; i<widget.workout.targetMuscles.length; i+=2)
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(color: Colors.grey.shade300)
                                      ),
                                      child: Image.asset(
                                        widget.workout.targetMuscles[i].imageUrl,
                                        fit: BoxFit.cover,
                                        width: 300,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      widget.workout.targetMuscles[i].name,
                                      style: TextStyle(
                                        color: Colors.grey[600]
                                      ),
                                    ),
                                  ],
                                ),
                                i+1 != widget.workout.targetMuscles.length ?
                                Row(
                                  children: [
                                    SizedBox(width: 40,),
                                    Column(
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              border: Border.all(color: Colors.grey.shade300)
                                          ),
                                          child: Image.asset(
                                            widget.workout.targetMuscles[i+1].imageUrl,
                                            fit: BoxFit.cover,
                                            width: 300,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          widget.workout.targetMuscles[i+1].name,
                                          style: TextStyle(
                                              color: Colors.grey[600]
                                          ),
                                        ),
                                      ],
                                    ),
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
