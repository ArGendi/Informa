import 'package:flutter/material.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/screens/login_screen.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String id = 'reset password';
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var _formKey = GlobalKey<FormState>();
  String? _password;

  onSubmit(){
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    bool valid = _formKey.currentState!.validate();
    if(valid) {
      Provider.of<ActiveUserProvider>(context, listen: false).setUser(new AppUser(
        email: 'No email yet',
        name: 'No name yet',
        premium: true,
      ));
      //Navigator.popUntil(context, ModalRoute.withName(LoginScreen.id));
      Navigator.pushNamed(context, MainScreen.id);
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/shield.png',
                        width: 140,
                      ),
                      SizedBox(height: 25,),
                      Text(
                        'أدخل كلمة مرور جديدة',
                        style: TextStyle(
                          fontSize: 24,
                          //height: 0.3
                        ),
                      ),
                      Text(
                        'قم بأدخال كلمة مرور قوية من رموز واحرف كبيرة وصغيرة تتذكرها بسهولة في المستقبل',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 20,),
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
                      SizedBox(height: 15,),
                      CustomTextField(
                        text: 'تأكيد كلمة المرور',
                        obscureText: true,
                        textInputType: TextInputType.text,
                        setValue: (String value){},
                        validation: (value){
                          if (value.isEmpty) return 'أدخل كلمة المرور';
                          if (value.length < 6) return 'كلمة المرور قصيرة';
                          if(value != _password) return 'كلمة المرور غير متطابقه';
                          return null;
                        },
                      ),
                      SizedBox(height: 15,),
                      CustomButton(
                        text: 'تحديث كلمة المرور',
                        onClick: onSubmit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
