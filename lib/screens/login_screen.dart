import 'package:flutter/material.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/app_language_provider.dart';
import 'package:informa/screens/forget_password_screen.dart';
import 'package:informa/services/auth_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  AuthServices _authServices = new AuthServices();
  bool? _isLoading = false;

  onSubmit(BuildContext context) async{
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid) {
      _formKey.currentState!.save();
      User user = new User(
        email: _email,
        name: 'No Name',
        premium: true,
      );
      Provider.of<ActiveUserProvider>(context, listen: false).setUser(user);
      setState(() { _isLoading = true; });
      String? response = await _authServices.signIn(_email!.trim(), _password!);
      if(response == 'Signed in')
        Navigator.pushNamedAndRemoveUntil(context, MainScreen.id, (route) => false);
      else ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('غير صحيح'))
      );
      setState(() { _isLoading = false; });
    }
    print("email: " + _email.toString());
    print("password: " + _password.toString());
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
                      'assets/images/logo1.png',
                    ),
                    Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          fontSize: 22,
                          height: 0.3,
                        fontFamily: 'CairoBold'
                      ),
                    ),
                    SizedBox(height: 40,),
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
                    CustomTextField(
                      text: 'كلمة المرور',
                      obscureText: true,
                      textInputType: TextInputType.text,
                      setValue: (String value){
                        _password = value;
                      },
                      validation: (value){
                        if (value.isEmpty) return 'أدخل كلمة المرور';
                        if (value.length < 6) return 'كلمة المرور قصيرة';
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, ForgetPasswordScreen.id);
                          },
                          child: Text(
                            'نسيت كلمة المرور؟',
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    CustomButton(
                      text: 'تسجيل الدخول',
                      onClick: (){
                        onSubmit(context);
                      },
                      isLoading: _isLoading!,
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'مستخدم جديد؟ ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            'أنشاء حساب الأن',
                            style: TextStyle(
                                //fontSize: 16,
                                color: primaryColor
                            ),
                          ),
                        ),
                      ],
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
