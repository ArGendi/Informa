import 'dart:async';

import 'package:flutter/material.dart';
import 'package:informa/screens/loading_screen.dart';
import 'package:informa/screens/auth_screens/register_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late AnimationController _controller;
  late AnimationController _controller2;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _animation;

  startAnimation() async{
    await _controller.forward();
    await _controller2.forward();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => LoadingScreen(),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2800),
      vsync: this,
    );
    _controller2 = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0,-3),
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeInQuint,
    ));
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    Timer(Duration(milliseconds: 800), (){
      startAnimation();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
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
          child: SlideTransition(
            position: _offsetAnimation,
            child: SizeTransition(
              sizeFactor: _animation,
              axis: Axis.vertical,
              axisAlignment: 0,
              child: Image.asset(
                'assets/images/logo1.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
