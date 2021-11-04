import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/services/auth_service.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'أنفورما',
                      style: TextStyle(
                        fontFamily: 'CairoBold',
                      ),
                    ),
                    Card(
                      elevation: 0,
                      color: primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'بريميم',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'أنفورما',
                  style: TextStyle(
                    //fontFamily: 'CairoBold',
                  ),
                ),
                Text(
                  'أنفورما',
                  style: TextStyle(
                      color: bgColor
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.green[200],
                        child: Icon(
                          Icons.check,
                          color: Colors.green[600],
                          size: 22,
                        ),
                      ),
                      SizedBox(width: 20,),
                      CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.red[200],
                        child: Icon(
                          Icons.clear,
                          color: Colors.red[600],
                          size: 22,
                        ),
                      ),
                      Text(
                        'تسجيل ومتابعة اوزانك وتغييرات جسمك',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
