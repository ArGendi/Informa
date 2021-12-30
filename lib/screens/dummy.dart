import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:informa/screens/main_register_screen.dart';
import 'package:informa/services/auth_service.dart';
import 'package:informa/services/notification_service.dart';
import 'package:informa/services/web_services.dart';

import '../constants.dart';

class Dummy extends StatefulWidget {
  const Dummy({Key? key}) : super(key: key);

  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> with TickerProviderStateMixin{
  List list = [1,2,3];

  sendEmail() async{
    WebServices webServices = new WebServices();
    var response = await webServices.postWithOrigin('https://api.emailjs.com/api/v1.0/email/send', {
      "user_id": "user_sL5eCDqsL5h8Jaoq71PH0",
      "service_id": "service_emgj8vt",
      "template_id": "template_9oefxlr",
      "template_params": {
        'user_message': '92723',
        'to_email': 'abdelrahman1abdallah@gmail.com',
      }
    });
    print('response: ' + response.statusCode.toString());
  }

  firebaseSendEmail(){
    AuthServices authServices = new AuthServices();

  }

  late AnimationController _controller;
  late AnimationController _controller2;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );
    _controller2 = AnimationController(
      duration: Duration(milliseconds: 2000),
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
      curve: Curves.linearToEaseOut,
    );
    Timer(Duration(milliseconds: 500), (){
      _controller.forward();
    });
    Timer(Duration(milliseconds: 4000), (){
      _controller2.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SlideTransition(
          position: _offsetAnimation,
          child: SizeTransition(
            sizeFactor: _animation,
            axis: Axis.vertical,
            axisAlignment: -1,
            child: FlutterLogo(size: 150.0),
          ),
        ),
      ),
    );
  }

  void listenNotification() {
    NotificationService.onNotifications.stream.listen((payload) {
      Navigator.pushNamed(context, MainRegisterScreen.id);
    });
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
