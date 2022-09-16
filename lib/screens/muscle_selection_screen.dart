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
  int _shoulderMuscle = 0;

  _showShouldersDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: const Text('أختر عضلة الكتف'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(borderRadius),
                      onTap: () {
                        setState(() {
                          _shoulderMuscle = 1;
                          _muscle = MusclesList.allMuscles[2];
                        });
                        print(_shoulderMuscle);
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(borderRadius),
                          border: Border.all(
                            color: _shoulderMuscle == 1
                                ? primaryColor
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'كتف امامي',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                radius: 10,
                                child: _shoulderMuscle == 1
                                    ? CircleAvatar(
                                        backgroundColor: primaryColor,
                                        radius: 5,
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(borderRadius),
                      onTap: () {
                        setState(() {
                          _shoulderMuscle = 2;
                          _muscle = MusclesList.allMuscles[3];
                        });
                        print(_shoulderMuscle);
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(borderRadius),
                          border: Border.all(
                            color: _shoulderMuscle == 2
                                ? primaryColor
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'كتف جانبي',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                radius: 10,
                                child: _shoulderMuscle == 2
                                    ? CircleAvatar(
                                        backgroundColor: primaryColor,
                                        radius: 5,
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(borderRadius),
                      onTap: () {
                        setState(() {
                          _shoulderMuscle = 3;
                          _muscle = MusclesList.allMuscles[4];
                        });
                        print(_shoulderMuscle);
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(borderRadius),
                          border: Border.all(
                            color: _shoulderMuscle == 3
                                ? primaryColor
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'كتف خلفي',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                radius: 10,
                                child: _shoulderMuscle == 3
                                    ? CircleAvatar(
                                        backgroundColor: primaryColor,
                                        radius: 5,
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'تم',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                  onPressed: () {
                    print('Muscle:' + _shoulderMuscle.toString());
                    print('Muscle:' + _muscle!.name.toString());
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
    setState(() {
      _muscle = _muscle;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('تمارين أنفورما'),
        centerTitle: true,
        leading: IconButton(
          splashRadius: splashRadius,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
            splashRadius: splashRadius,
            onPressed: () {
              if (!activeUser!.premium) {
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
                image: AssetImage('assets/images/appBg.png'))),
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
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
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
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
                  onChest: () {
                    print('Chest');
                    setState(() {
                      _image = 'assets/images/selected_body_chest.png';
                      _muscle = MusclesList.allMuscles[0];
                    });
                  },
                  onAbs: () {
                    print('Abs');
                    setState(() {
                      _image = 'assets/images/selected_body_abs.png';
                      _muscle = MusclesList.allMuscles[1];
                    });
                  },
                  onShoulder: () {
                    print('Shoulder');
                    _showShouldersDialog();
                    // setState(() {
                    //   _image = 'assets/images/selected_body_abs.png';
                    //   _muscle = MusclesList.allMuscles[1];
                    // });
                  },
                ),
                // Text(
                //   _muscle != null ? 'العضلة المستهدفة هي ' + _muscle!.name : 'لا يوجد عضلة مستهدفة',
                //   style: TextStyle(
                //     fontFamily: 'CairoBold',
                //   ),
                // ),
                // SizedBox(height: 10,),
                CustomButton(
                  text: _muscle == null ? 'أختار عضلة' : _muscle!.name,
                  bgColor:
                      _muscle != null ? primaryColor : Colors.grey.shade400,
                  onClick: () {
                    if (_muscle != null)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FreeWorkoutScreen(
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
