import 'package:flutter/material.dart';
import 'package:informa/services/auth_service.dart';
import 'package:informa/services/web_services.dart';

class Dummy extends StatefulWidget {
  const Dummy({Key? key}) : super(key: key);

  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: firebaseSendEmail,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
