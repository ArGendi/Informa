import 'package:flutter/material.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';

import 'email_confirmation_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var _formKey = GlobalKey<FormState>();
  String? _email;

  onSubmit(){
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmailConfirmationScreen(code: '12345',)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/lock.png',
                    width: 140,
                  ),
                  SizedBox(height: 15,),
                  Text(
                    'نسيت كلمة المرور',
                    style: TextStyle(
                        fontSize: 24,
                        //height: 0.3
                    ),
                  ),
                  Text(
                    'أدخل البريد الألكتروني المسجل وسنرسل لك رمز تأكيد لأعادة تعيين كلمة السر',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 20,),
                  CustomTextField(
                    text: 'البريد الألكتروني',
                    obscureText: false,
                    textInputType: TextInputType.emailAddress,
                    setValue: (String value){
                      _email = value;
                    },
                    validation: (value){
                      if (value.isEmpty) return 'أدخل البريد الألكتروني';
                      if (!value.contains('@') || !value.contains('.'))
                        return 'بريد الكتروني خاطىء';
                      return null;
                    },
                  ),
                  SizedBox(height: 15,),
                  CustomButton(
                    text: 'أرسل رمز التأكيد',
                    onClick: (){
                      onSubmit();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
