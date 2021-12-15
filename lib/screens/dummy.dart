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

class _DummyState extends State<Dummy> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationService.init(initScheduled: true);
    listenNotification();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: (){
                print('clicked');
                NotificationService.showNotification(
                  title: 'Drink water',
                  body: 'its time to drink water',
                  payload: 'payload'
                );
              },
              child: Text('Simple notification'),
            ),
            MaterialButton(
              onPressed: (){
                print('clicked');
                NotificationService.showScheduledNotification(
                    title: 'Drink water',
                    body: 'its time to drink water',
                    payload: 'payload',
                    scheduledDate: DateTime.now().add(Duration(seconds: 20)),
                );
              },
              child: Text('Scheduled notification'),
            ),
          ],
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
