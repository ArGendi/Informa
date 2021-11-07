import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/app_language_provider.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/screens/login_screen.dart';
import 'package:informa/services/auth_service.dart';
import 'package:informa/services/web_services.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class MainRegisterScreen extends StatefulWidget {
  static String id = 'main register';
  const MainRegisterScreen({Key? key}) : super(key: key);

  @override
  _MainRegisterScreenState createState() => _MainRegisterScreenState();
}

class _MainRegisterScreenState extends State<MainRegisterScreen> {
  bool isGoogleLoading = false;
  bool isFacebookLoading = false;
  AuthServices? _authServices = new AuthServices();

  facebookLogin(BuildContext context) async{
    setState(() {isFacebookLoading = true;});
    bool valid = await _authServices!.loginWithFacebook();
    if(valid){
      var profile = await _authServices!.fb.getUserProfile();
      var email = await _authServices!.fb.getUserEmail();
      User user = new User(
        name: profile!.name,
        email: email,
        premium: true,
      );
      Provider.of<ActiveUserProvider>(context, listen: false).setUser(user);
      setState(() {isFacebookLoading = false;});
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainScreen.id, (Route<dynamic> route) => false);
    }
    else {
      setState(() {isFacebookLoading = false;});
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ فالتسجيل'))
      );
    }
  }

  googleLogin(BuildContext context) async{
    setState(() {isGoogleLoading = true;});
    bool valid = await _authServices!.loginWithGoogle();
    if(valid){
      User user = new User(
        name: _authServices!.user.displayName,
        email: _authServices!.user.email,
        premium: true,
      );
      Provider.of<ActiveUserProvider>(context, listen: false).setUser(user);
      setState(() {isGoogleLoading = false;});
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainScreen.id, (Route<dynamic> route) => false);
    }
    else {
      setState(() {isGoogleLoading = false;});
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ فالتسجيل'))
      );
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
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo1.png',
                  ),
                  //SizedBox(height: 20,),
                  Text(
                    'أبدأ التغيير',
                    style: TextStyle(
                      fontSize: 30,
                      height: 0.5
                    ),
                  ),
                  Text(
                    'خطوة بخطوة',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'يجب عليك انشاء حساب او تسجيل الدخول للحصول علي برامج التغذية والتمارين',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600]
                    ),
                  ),
                  SizedBox(height: 20,),

                  //Social media login buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(300),
                        onTap: (){
                          facebookLogin(context);
                        },
                        child: CircleAvatar(
                          radius: 23,
                          backgroundColor: Colors.blue,
                          child: !isFacebookLoading ? FaIcon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.white,
                          ) : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      InkWell(
                        borderRadius: BorderRadius.circular(300),
                        onTap: (){
                          googleLogin(context);
                        },
                        child: Ink(
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor: Colors.white,
                            child: !isGoogleLoading ? FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.red,
                            ) : Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(child: Divider(
                        endIndent: 10,
                        color: Colors.grey[600],
                      )),
                      Text(
                        'تسجيل الدخول بالبريد الألكتروني',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                      Expanded(child: Divider(
                        indent: 10,
                        color: Colors.grey[600],
                      )),
                    ],
                  ),
                  SizedBox(height: 20,),

                  //Login button
                  CustomButton(
                    text: 'أنشاء حساب',
                    onClick: (){},
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لديك حساب بالفعل؟ ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text(
                          'سجل الدخول',
                          style: TextStyle(
                              //fontSize: 16,
                              color: primaryColor
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
                  Text(
                    'بالتسجيل في تطبيق أنفورما فأنت توافق علي',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey[600],
                      height: 1
                    ),
                  ),
                  TextButton(
                    onPressed: (){},
                    child: Text(
                      'شروط الأستخدام وقوانين الخصوصية',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 8,
                        color: primaryColor,
                      ),
                    ),
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
