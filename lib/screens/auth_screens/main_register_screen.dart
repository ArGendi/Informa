import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:informa/constants.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/challenges_provider.dart';
import 'package:informa/screens/auth_screens/login_screen.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/services/auth_service.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import 'more_user_info_screen.dart';

class MainRegisterScreen extends StatefulWidget {
  static String id = 'main register';
  const MainRegisterScreen({Key? key}) : super(key: key);

  @override
  _MainRegisterScreenState createState() => _MainRegisterScreenState();
}

class _MainRegisterScreenState extends State<MainRegisterScreen>
    with SingleTickerProviderStateMixin {
  bool isGoogleLoading = false;
  bool isFacebookLoading = false;
  AuthServices? _authServices = new AuthServices();
  FirestoreService _firestoreService = new FirestoreService();
  late AnimationController _controller;
  late Animation<Offset> _logoOffset;
  late Animation<Offset> _btnOffset;

  facebookLogin(BuildContext context) async {
    setState(() {
      isFacebookLoading = true;
    });
    var credential = await _authServices!.loginWithFacebook().catchError((e) {
      setState(() {
        isFacebookLoading = false;
      });
    });
    if (credential == null) {
      setState(() {
        isFacebookLoading = false;
      });
      return;
    }
    var fbUser = credential.user;
    if (fbUser != null) {
      if (!credential.additionalUserInfo!.isNewUser) {
        print('Not a new user');
        AppUser? user =
            await _firestoreService.getUserById(fbUser.uid).catchError((e) {
          print('error getting data from fireStore');
          setState(() {
            isFacebookLoading = false;
          });
        });
        await user!.saveInSharedPreference();
        await HelpFunction.saveInitScreen(MainScreen.id);
        setState(() {
          isFacebookLoading = false;
        });
        print(user);
        Provider.of<ActiveUserProvider>(context, listen: false).setUser(user);

        List<Challenge> challenges = await _firestoreService.getAllChallenges();
        Provider.of<ChallengesProvider>(context, listen: false)
            .setChallenges(challenges);

        Navigator.of(context).pushNamedAndRemoveUntil(
            MainScreen.id, (Route<dynamic> route) => false);
      } else {
        var profile = await _authServices!.fb.getUserProfile();
        var email = await _authServices!.fb.getUserEmail();
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setId(fbUser.uid);
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setName(profile!.name!);
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setEmail(email!);
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setFromSocialMedia(true);
        //AppUser? activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
        //await _firestoreService.saveNewAccount(activeUser!);
        setState(() {
          isFacebookLoading = false;
        });
        Navigator.pushNamed(context, MoreUserInfoScreen.id);
      }
    } else {
      setState(() {
        isFacebookLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('حدث خطأ فالتسجيل')));
    }
  }

  googleLogin(BuildContext context) async {
    setState(() {
      isGoogleLoading = true;
    });
    var credential = await _authServices!.loginWithGoogle().catchError((e) {
      setState(() {
        isGoogleLoading = false;
      });
    });
    if (credential == null) {
      setState(() {
        isGoogleLoading = false;
      });
      return;
    }
    var googleUser = credential.user;
    if (googleUser != null) {
      if (!credential.additionalUserInfo!.isNewUser) {
        print('Not a new user');
        AppUser? user =
            await _firestoreService.getUserById(googleUser.uid).catchError((e) {
          print('error getting data from fireStore');
        });
        print(user);
        await user!.saveInSharedPreference();
        await HelpFunction.saveInitScreen(MainScreen.id);
        setState(() {
          isGoogleLoading = false;
        });
        Provider.of<ActiveUserProvider>(context, listen: false).setUser(user);

        List<Challenge> challenges = await _firestoreService.getAllChallenges();
        Provider.of<ChallengesProvider>(context, listen: false)
            .setChallenges(challenges);

        Navigator.of(context).pushNamedAndRemoveUntil(
            MainScreen.id, (Route<dynamic> route) => false);
      } else {
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setId(googleUser.uid);
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setName(_authServices!.user.displayName!);
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setEmail(_authServices!.user.email);
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setFromSocialMedia(true);
        //AppUser? activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
        //await _firestoreService.saveNewAccount(activeUser!);
        setState(() {
          isGoogleLoading = false;
        });
        Navigator.pushNamed(context, MoreUserInfoScreen.id);
      }
    } else {
      setState(() {
        isGoogleLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('حدث خطأ فالتسجيل')));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _logoOffset = Tween<Offset>(
      begin: Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));
    _btnOffset = Tween<Offset>(
      begin: Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));
    Timer(Duration(milliseconds: 300), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png'))),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SlideTransition(
                      position: _logoOffset,
                      child: Image.asset(
                        'assets/images/logo1.png',
                      ),
                    ),
                    //SizedBox(height: 20,),
                    Text(
                      'أبدأ التغيير',
                      style: TextStyle(fontSize: 30, height: 0.5),
                    ),
                    Text(
                      'خطوة بخطوة',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'يجب عليك انشاء حساب او تسجيل الدخول للحصول علي برامج التغذية والتمارين',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //Social media login buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(300),
                          onTap: () {
                            facebookLogin(context);
                          },
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor: Colors.blue,
                            child: !isFacebookLoading
                                ? FaIcon(
                                    FontAwesomeIcons.facebookF,
                                    color: Colors.white,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(300),
                          onTap: () {
                            googleLogin(context);
                          },
                          child: Ink(
                            child: CircleAvatar(
                              radius: 23,
                              backgroundColor: Colors.white,
                              child: !isGoogleLoading
                                  ? FaIcon(
                                      FontAwesomeIcons.google,
                                      color: Colors.red,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.red),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
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
                        Expanded(
                            child: Divider(
                          indent: 10,
                          color: Colors.grey[600],
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //Login button
                    Semantics(
                      label: 'أنشاء حساب',
                      button: true,
                      child: SlideTransition(
                        position: _btnOffset,
                        child: CustomButton(
                          text: 'أنشاء حساب',
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoreUserInfoScreen()),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: Text(
                            'سجل الدخول',
                            style: TextStyle(
                                //fontSize: 16,
                                color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'بالتسجيل في تطبيق أنفورما فأنت توافق علي',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 8, color: Colors.grey[600], height: 1),
                    ),
                    TextButton(
                      onPressed: () {},
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
      ),
    );
  }
}
