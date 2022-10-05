import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/excercise.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/screens/video_player_screen.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class SingleWorkoutScreen extends StatefulWidget {
  static String id = 'single workout';
  final Exercise exercise;
  const SingleWorkoutScreen({Key? key, required this.exercise})
      : super(key: key);

  @override
  _SingleWorkoutScreenState createState() => _SingleWorkoutScreenState();
}

class _SingleWorkoutScreenState extends State<SingleWorkoutScreen> {
  bool _isFavorite = false;

  Future<void> _showDoneDialog(String image) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.asset(
            image,
            width: 300,
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

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png'))),
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
                              widget.exercise.name!,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'CairoBold',
                              ),
                            ),
                            Text(
                              widget.exercise.description!,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: IconButton(
                          onPressed: () {
                            if (!activeUser!.premium) {
                              Navigator.pushNamed(context, PlansScreen.id);
                            } else {
                              setState(() {
                                _isFavorite = !_isFavorite;
                              });
                            }
                          },
                          splashRadius: 5,
                          icon: Icon(
                            _isFavorite
                                ? Icons.bookmark_outlined
                                : Icons.bookmark_outline,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'شاهد التمرين',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Hero(
                    tag: widget.exercise.id!,
                    child: Container(
                      width: screenSize.width,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(borderRadius),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(widget.exercise.image!))),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        onPressed: () {
                          if (widget.exercise.video != null)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoPlayerScreen(
                                        url: widget.exercise.video!,
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
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'العضلات المستهدفة',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                    ),
                  ),
                  //SizedBox(height: 10,),
                  for (int i = 0;
                      i < widget.exercise.targetMuscles!.length;
                      i++)
                    InkWell(
                      onTap: () {
                        _showDoneDialog(
                            widget.exercise.targetMuscles![i].image);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (i + 1).toString() +
                                  '- ' +
                                  widget.exercise.targetMuscles![i].name,
                              textAlign: TextAlign.start,
                              style: TextStyle(),
                            ),
                            Icon(
                              Icons.image,
                              color: primaryColor,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'العضلات المساعدة',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                    ),
                  ),
                  for (int i = 0;
                      i < widget.exercise.helpersMuscles!.length;
                      i++)
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (i + 1).toString() +
                                  '- ' +
                                  widget.exercise.targetMuscles![i].name,
                              textAlign: TextAlign.start,
                              style: TextStyle(),
                            ),
                            Icon(
                              Icons.image,
                              color: primaryColor,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'العضلات المثبتة',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                    ),
                  ),
                  for (int i = 0;
                      i < widget.exercise.settlersMuscles!.length;
                      i++)
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (i + 1).toString() +
                                  '- ' +
                                  widget.exercise.targetMuscles![i].name,
                              textAlign: TextAlign.start,
                              style: TextStyle(),
                            ),
                            Icon(
                              Icons.image,
                              color: primaryColor,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: 'تم',
                    onClick: () {
                      if (!activeUser!.premium)
                        Navigator.pushNamed(context, PlansScreen.id);
                    },
                    iconExist: false,
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
