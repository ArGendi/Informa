import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:informa/app_localization.dart';
import 'package:informa/constants.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/analytics_screen.dart';
import 'package:informa/screens/free_kitchen_screen.dart';
import 'package:informa/screens/home_screen.dart';
import 'package:informa/screens/nutrition_screen.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/screens/premium_screens/ready_fill_premium_form_screen.dart';
import 'package:informa/screens/premium_screens/workout_screens/main_workout_screen.dart';
import 'package:informa/screens/profile_screen.dart';
import 'package:informa/screens/workout_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static String id = 'main';
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;
  final _pageStorageBucket = PageStorageBucket();
  Widget _currentPage = HomeScreen();

  _showEndDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'متأكد من اغلاق التطبيق؟',
            style: TextStyle(
              color: primaryColor,
              fontSize: 16,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'أرجعلنا تاني مستنيينك يا بطل',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: const Text(
                'أغلاق',
                style: TextStyle(
                  color: Colors.red,
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
    var size = MediaQuery.of(context).size;
    var localization = AppLocalization.of(context);
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return WillPopScope(
      onWillPop: (){
        return _showEndDialog(context);
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/appBg.png')
              )
          ),
          child: Stack(
            children: [
              PageStorage(
                bucket: _pageStorageBucket,
                child: _currentPage,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: size.width,
                  height: 70,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.28),
                        spreadRadius: 5,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(size.width, 70),
                        painter: BNBCustomPainter(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Profile
                            MaterialButton(
                              shape: CircleBorder(),
                              minWidth: 40,
                              onPressed: (){
                                setState(() {
                                  _selectedIndex = 0;
                                  _currentPage = ProfileScreen();
                                });
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/user.svg',
                                    semanticsLabel: 'user',
                                    color: _selectedIndex == 0 ? primaryColor : Colors.grey[400],
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text(
                                    localization!.translate('حسابي').toString(),
                                    style: TextStyle(
                                        color: _selectedIndex == 0 ? primaryColor : Colors.grey[400],
                                        fontSize: 10
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Analytics
                            MaterialButton(
                              shape: CircleBorder(),
                              minWidth: 40,
                              onPressed: (){
                                if(activeUser!.premium && activeUser.fillPremiumForm)
                                  setState(() {
                                    _selectedIndex = 1;
                                    _currentPage = AnalyticsScreen();
                                  });
                                else if(activeUser.premium && !activeUser.fillPremiumForm)
                                  Navigator.pushNamed(context, ReadyFillPremiumForm.id);
                                else Navigator.pushNamed(context, PlansScreen.id);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/chart-histogram.svg',
                                    semanticsLabel: 'chart',
                                    color: _selectedIndex == 1 ? primaryColor : Colors.grey[400],
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text(
                                    localization.translate('التقدم').toString(),
                                    style: TextStyle(
                                        color: _selectedIndex == 1 ? primaryColor : Colors.grey[400],
                                        fontSize: 10
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 70,
                              height: 50,
                            ),
                            //Workout
                            MaterialButton(
                              shape: CircleBorder(),
                              minWidth: 40,
                              onPressed: (){
                                // setState(() {
                                //   _selectedIndex = 3;
                                //   _currentPage = MainWorkoutScreen();
                                // });
                                if(activeUser!.premium && activeUser.fillPremiumForm && (activeUser.program == 1 || activeUser.program == 2))
                                  setState(() {
                                    _selectedIndex = 3;
                                    _currentPage = MainWorkoutScreen();
                                  });
                                else if(activeUser.premium && !activeUser.fillPremiumForm)
                                  Navigator.pushNamed(context, ReadyFillPremiumForm.id);
                                else Navigator.pushNamed(context, PlansScreen.id);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/gym.svg',
                                    semanticsLabel: 'gym',
                                    color: _selectedIndex == 3 ? primaryColor : Colors.grey[400],
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text(
                                    localization.translate('تمارينك').toString(),
                                    style: TextStyle(
                                        color: _selectedIndex == 3 ? primaryColor : Colors.grey[400],
                                        fontSize: 10
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Nutrition
                            MaterialButton(
                              shape: CircleBorder(),
                              minWidth: 40,
                              onPressed: (){
                                // setState(() {
                                //   _selectedIndex = 4;
                                //   _currentPage = NutritionScreen();
                                // });
                                if(activeUser!.premium && activeUser.fillPremiumForm)
                                  setState(() {
                                    _selectedIndex = 4;
                                    _currentPage = NutritionScreen();
                                  });
                                else if(activeUser.premium && !activeUser.fillPremiumForm)
                                  Navigator.pushNamed(context, ReadyFillPremiumForm.id);
                                else Navigator.pushNamed(context, PlansScreen.id);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/fish.svg',
                                    semanticsLabel: 'user',
                                    color: _selectedIndex == 4 ? primaryColor : Colors.grey[400],
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text(
                                    localization.translate('الدايت').toString(),
                                    style: TextStyle(
                                        color: _selectedIndex == 4 ? primaryColor : Colors.grey[400],
                                        fontSize: 10
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 35),
          child: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
                _currentPage = HomeScreen();
              });
            },
            child: SvgPicture.asset(
              'assets/icons/home.svg',
              semanticsLabel: 'home',
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color =  Colors.white..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 10);
    path.arcToPoint(
      Offset(size.width * 0.60, 10),
      radius: Radius.circular(20),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    throw UnimplementedError();
  }

}