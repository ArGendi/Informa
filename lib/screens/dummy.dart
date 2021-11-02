import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/services/auth_service.dart';
import 'package:informa/services/web_services.dart';

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
      body: ListView(
        shrinkWrap: true,
        children: [
          for(int i=0; i<list.length; i+=2)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset(
                              'assets/images/burger.png',
                              fit: BoxFit.cover,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Ahmed',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'actor',
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Text(
                                            '23 years',
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.mail),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    i+1 == list.length ? Expanded(child: Container()) : Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset(
                              'assets/images/burger.png',
                              fit: BoxFit.cover,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Ahmed',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'actor',
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Text(
                                            '23 years',
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.mail),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
              ],
            ),
        ],
      )
    );
  }
}
