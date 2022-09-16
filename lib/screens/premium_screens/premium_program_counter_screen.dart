import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:informa/constants.dart';
import 'package:informa/widgets/custom_button.dart';

import '../main_screen.dart';

class PremiumProgramCounterScreen extends StatefulWidget {
  static String id = 'premium program counter';
  const PremiumProgramCounterScreen({Key? key}) : super(key: key);

  @override
  _PremiumProgramCounterScreenState createState() =>
      _PremiumProgramCounterScreenState();
}

class _PremiumProgramCounterScreenState
    extends State<PremiumProgramCounterScreen> {
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _dateTime = DateTime(now.year, now.month, now.day, now.hour + 120);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png'))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'الوقت المتبقي علي تجهيز برنامجك',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: boldFont,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: CountdownTimer(
                              endTime: _dateTime.millisecondsSinceEpoch,
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              endWidget: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'تم أعداد البرنامج',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              onEnd: () {},
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  text: 'الذهاب للصفحة الرئيسية',
                  onClick: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName(MainScreen.id));
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
