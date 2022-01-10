import 'package:flutter/material.dart';
import 'package:informa/screens/auth_screens/login_screen.dart';
import 'package:informa/services/auth_service.dart';
import 'package:informa/widgets/custom_button.dart';

import '../../constants.dart';

class EmailConfirmationMsgScreen extends StatefulWidget {
  final String email;
  const EmailConfirmationMsgScreen({Key? key, required this.email}) : super(key: key);

  @override
  _EmailConfirmationMsgScreenState createState() => _EmailConfirmationMsgScreenState();
}

class _EmailConfirmationMsgScreenState extends State<EmailConfirmationMsgScreen> {
  AuthServices _authServices = new AuthServices();

  resendEmailConfirmation() async{
    bool valid = await _authServices.resetPassword(widget.email.trim());
    if(!valid){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ, أعد المحاولة'))
      );
    }
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
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/mailed.png',
                      width: 140,
                    ),
                    SizedBox(height: 15,),
                    Text(
                      'تأكيد البريد الألكتروني',
                      style: TextStyle(
                        fontSize: 24,
                        //height: 0.3
                      ),
                    ),
                    Text(
                      'تم أرسال رمز التأكيد لك, من فضلك تحقق من البريد الوارد وأعد كتابة الرمز لتعيين كلمة المرور',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 30,),
                    CustomButton(
                      text: 'العودة لتسجيل الدخول',
                      onClick: (){
                        Navigator.popUntil(context, ModalRoute.withName(LoginScreen.id));
                      },
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'لم يصل رمز التأكيد؟',
                      style: TextStyle(
                      ),
                    ),
                    TextButton(
                      onPressed: resendEmailConfirmation,
                      child: Text(
                        'أعد ارسال رمز التأكيد مرة أخرى',
                        style: TextStyle(
                            color: primaryColor,
                            height: 0.2
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
