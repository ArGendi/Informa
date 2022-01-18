import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:informa/models/user.dart';
import 'package:informa/screens/auth_screens/main_register_screen.dart';
import 'package:informa/services/auth_service.dart';
import 'package:informa/services/informa_service.dart';
import 'package:informa/services/notification_service.dart';
import 'package:informa/services/web_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants.dart';

class Dummy extends StatefulWidget {

  const Dummy({Key? key,}) : super(key: key);

  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> with TickerProviderStateMixin{
  List list = [1,2,3];
  late InformaService _informaService;
  late AppUser _user;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = AppUser(
      gender: 1,
      weight: 70,
      fatsPercent: 14,
      age: 22,
      tall: 186,
      fitnessLevel: 1,
      goal: 4
    );
    _user.iTrainingDays = 4;
    _user.inBody = true;
    _informaService = InformaService(_user);
    print("Calories: " + _informaService.calculateNeededCalories().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
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
