import 'dart:async';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/screens/premium_screens/premium_form_screen.dart';
import 'package:informa/services/notification_service.dart';
import 'package:informa/widgets/custom_button.dart';

class ReadyFillPremiumForm extends StatefulWidget {
  static String id = 'ready fill premium form';
  const ReadyFillPremiumForm({Key? key}) : super(key: key);

  @override
  _ReadyFillPremiumFormState createState() => _ReadyFillPremiumFormState();
}

class _ReadyFillPremiumFormState extends State<ReadyFillPremiumForm> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _offset;

  void listenNotification() {
    NotificationService.onNotifications.stream.listen((payload) {
      Navigator.pushNamed(context, PremiumFormScreen.id);
    });
  }

  onLater(BuildContext context) async{
    await NotificationService.init(initScheduled: true);
    listenNotification();
    await NotificationService.showRepeatScheduledNotification(
      id: 10,
      title: 'أدخل جاوب علي الأسئلة',
      body: 'جاوب عالأسئلة عشان تساعدنا نعملك برنامج مخصص ليك وتوصل لهدفك 💪🏻',
      payload: 'payload',
      date: 16,
    );
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('يمكنك الدخول علي الأسئلة من حسابك فالصفحة الرئيسية'),
          duration: Duration(milliseconds: 3800),
        )
    );
    Timer(Duration(seconds: 4), (){
      Navigator.popUntil(context, ModalRoute.withName(MainScreen.id));
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _offset = Tween<Offset>(
      begin: Offset(0,-3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));
    Timer(Duration(milliseconds: 200), (){
      _controller.forward();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _offset,
                  child: Image.asset(
                    'assets/images/contact-form.png',
                    width: 180,
                  ),
                  // child: Icon(
                  //   Icons.format_list_bulleted,
                  //   color: primaryColor,
                  //   size: 80,
                  // ),
                ),
                SizedBox(height: 20,),
                Text(
                  'جاهز تجاوب علي الأسئلة؟',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: boldFont,
                  ),
                ),
                Text(
                  'مجموعة اسئلة تخصك عشان نكون البرنامج الخاص بيك',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10,),
                CustomButton(
                  text: 'يلا بينا',
                  onClick: (){
                    Navigator.pushNamed(context, PremiumFormScreen.id);
                  },
                ),
                SizedBox(height: 10,),
                CustomButton(
                  bgColor: Colors.grey.shade400,
                  text: 'بعدين',
                  onClick: (){
                    onLater(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
