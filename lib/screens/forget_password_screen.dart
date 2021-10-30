import 'dart:math';

import 'package:flutter/material.dart';
import 'package:informa/providers/app_language_provider.dart';
import 'package:informa/screens/email_confirmation_msg_screen.dart';
import 'package:informa/services/auth_service.dart';
import 'package:informa/services/email_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import 'email_confirmation_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String id = 'forget password';
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var _formKey = GlobalKey<FormState>();
  String? _email;
  AuthServices _authServices = new AuthServices();
  bool _isLoading = false;

  onSubmit() async{
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid) {
      _formKey.currentState!.save();
      String code = '';
      var rng = new Random();
      for (var i = 0; i < 5; i++)
        code += rng.nextInt(10).toString();
      print("Pin code: " + code);
      setState(() { _isLoading = true; });
      bool valid = await _authServices.resetPassword(_email!.trim());
      if(valid) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EmailConfirmationMsgScreen(email: _email!.trim(),)),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('حدث خطأ, أعد المحاولة'))
        );
      }
      setState(() { _isLoading = false; });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                      isLoading: _isLoading,
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
      ),
    );
  }
}
