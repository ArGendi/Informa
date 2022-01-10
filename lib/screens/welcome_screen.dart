import 'dart:async';

import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/screens/auth_screens/register_screens.dart';
import 'package:informa/widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin{
  late AnimationController _controller;
  late AnimationController _btnController;
  late Animation<Offset> _textOffset;
  late Animation<Offset> _imageOffset;
  late Animation<Offset> _btnOffset;

  startAnimation() async{
    await _controller.forward();
    await _btnController.forward();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2600),
      vsync: this,
    );
    _btnController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _btnOffset = Tween<Offset>(
      begin: Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _btnController,
      curve: Curves.easeOutBack,
    ));
    _imageOffset = Tween<Offset>(
      begin: Offset(0, 2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    ));
    _textOffset = Tween<Offset>(
      begin: Offset(0, -2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuart,
    ));
    Timer(Duration(milliseconds: 200), (){
      startAnimation();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SlideTransition(
                    position: _textOffset,
                    child: Column(
                      children: [
                        Text(
                          'مرحباً بك في انفورما',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: boldFont
                          ),
                        ),
                        Text(
                          'أبدأ معانا وأعرف تمارين مخصصة ليك ونضام غذائي بأكلات لذيذة ومفيدة',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    SlideTransition(
                      position: _imageOffset,
                      child: Image.asset(
                        'assets/images/coach_body.png',
                      ),
                    ),
                    SizedBox(height: 5,),
                    SlideTransition(
                      position: _btnOffset,
                      child: CustomButton(
                        text: 'أبدأ الأن',
                        onClick: (){
                          Navigator.pushNamed(context, RegisterScreens.id);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
