import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/muscle.dart';
import 'package:informa/models/muscles_list.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/free_workout_screen.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/widgets/body_model.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class MuscleSelectionScreen extends StatefulWidget {
  static String id = 'muscle selection';

  const MuscleSelectionScreen({Key? key}) : super(key: key);

  @override
  _MuscleSelectionScreenState createState() => _MuscleSelectionScreenState();
}

class _MuscleSelectionScreenState extends State<MuscleSelectionScreen> {
  bool _isFront = true;
  String _image = 'assets/images/unselected_body.png';
  Muscle? _muscle;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('تمارين أنفورما'),
        centerTitle: true,
        leading: IconButton(
          splashRadius: splashRadius,
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
            splashRadius: splashRadius,
            onPressed: (){
              if(!activeUser!.premium){
                Navigator.pushNamed(context, PlansScreen.id);
              }
            },
            icon: Icon(
              Icons.bookmark_outlined,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'حدد العضل المستهدف',
                  style: TextStyle(
                    fontFamily: 'CairoBold',
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          _isFront = true;
                          _image = 'assets/images/unselected_body.png';
                          _muscle = null;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: _isFront ? primaryColor : Colors.white,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Column(
                            children: [
                              Text(
                                'الأمام',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          _isFront = false;
                          _image = 'assets/images/unselected_body_back.png';
                          _muscle = null;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: !_isFront ? primaryColor : Colors.white,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Column(
                            children: [
                              Text(
                                'الخلفي',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                BodyModel(
                  image: _image,
                  isFront: _isFront,
                  onChest: (){
                    print('Chest');
                    setState(() {
                      _image = 'assets/images/selected_body_chest.png';
                      _muscle = MusclesList.allMuscles[0];
                    });
                  },
                  onAbs: (){
                    print('Abs');
                    setState(() {
                      _image = 'assets/images/selected_body_abs.png';
                      _muscle = MusclesList.allMuscles[1];
                    });
                  },
                ),
                // Container(
                //   width: 400,
                //   height: 500,
                //   child: Stack(
                //     children: [
                //       Image.asset(
                //         _image,
                //         width: 400,
                //       ),
                //       if(_isFront)
                //         Positioned(
                //           top: 115,
                //           right: 140,
                //           child: InkWell(
                //             onTap: (){
                //               print('Chest');
                //               setState(() {
                //                 _image = 'assets/images/selected_body_chest.png';
                //                 _muscle = MusclesList.allMuscles[0];
                //               });
                //             },
                //             child: Container(
                //               width: 70,
                //               height: 38,
                //               //color: Colors.black,
                //             ),
                //           ),
                //         ),
                //       if(_isFront)
                //         Positioned(
                //           top: 160,
                //           right: 150,
                //           child: InkWell(
                //             onTap: (){
                //               print('Abs');
                //               setState(() {
                //                 _image = 'assets/images/selected_body_abs.png';
                //                 _muscle = MusclesList.allMuscles[1];
                //               });
                //             },
                //             child: Container(
                //               width: 50,
                //               height: 75,
                //               //color: Colors.red,
                //             ),
                //           ),
                //         ),
                //     ],
                //   ),
                // ),
                Text(
                  _muscle != null ? 'العضلة المستهدفة هي ' + _muscle!.name : 'لا يوجد عضلة مستهدفة',
                  style: TextStyle(
                    fontFamily: 'CairoBold',
                  ),
                ),
                SizedBox(height: 10,),
                CustomButton(
                  text: 'تصفح التمارين',
                  bgColor: _muscle != null ? primaryColor : Colors.grey.shade400,
                  onClick: (){
                    if(_muscle != null)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FreeWorkoutScreen(
                          muscle: _muscle!,
                        )),
                      );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
