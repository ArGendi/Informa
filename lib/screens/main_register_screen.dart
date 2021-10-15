import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/home_screen.dart';
import 'package:informa/services/auth_service.dart';
import 'package:provider/provider.dart';

class MainRegisterScreen extends StatefulWidget {
  const MainRegisterScreen({Key? key}) : super(key: key);

  @override
  _MainRegisterScreenState createState() => _MainRegisterScreenState();
}

class _MainRegisterScreenState extends State<MainRegisterScreen> {
  bool isGoogleLoading = false;
  bool isFacebookLoading = false;

  facebookLogin(BuildContext context) async{
    setState(() {isFacebookLoading = true;});
    bool valid = await AuthServices.loginWithFacebook();
    if(valid){
      var profile = await AuthServices.fb.getUserProfile();
      var email = await AuthServices.fb.getUserEmail();
      User user = new User(
        name: profile!.name,
        email: email,
      );
      Provider.of<ActiveUserProvider>(context, listen: false).setUser(user);
      setState(() {isFacebookLoading = false;});
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
    else ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ فالتسجيل'))
    );
  }
  googleLogin(BuildContext context) async{
    setState(() {isGoogleLoading = true;});
    bool valid = await AuthServices.googleLogin();
    if(valid){
      User user = new User(
        name: AuthServices.user!.displayName,
        email: AuthServices.user!.email,
      );
      Provider.of<ActiveUserProvider>(context, listen: false).setUser(user);
      setState(() {isGoogleLoading = false;});
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
    else ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ فالتسجيل'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.07), BlendMode.dstATop),
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bg_man.jpg',),
          )
        ),
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
                      fontSize: 35,
                      height: 0.5
                    ),
                  ),
                  Text(
                    'خطوة بخطوة',
                    style: TextStyle(
                      fontSize: 35,
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
                        onTap: () async{
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
                        color: Colors.grey[600],
                      )),
                      Text(
                        '''   تسجيل الدخول بالبريد الألكتروني   ''',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                      Expanded(child: Divider(
                        color: Colors.grey[600],
                      )),
                    ],
                  ),
                  SizedBox(height: 10,),

                  //Login button
                  InkWell(
                    onTap: (){},
                    borderRadius: BorderRadius.circular(30),
                    child: Ink(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              'أنشاء حساب',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لديك حساب بالفعل؟ ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        child: Text(
                          'سجل الدخول',
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
                  Text(
                    'بالتسجيل في تطبيق أنفورما فأنت توافق علي شروط الأستخدام وقوانين الخصوصية',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
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