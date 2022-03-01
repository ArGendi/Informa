import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/app_language_provider.dart';
import 'package:informa/providers/challenges_provider.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/screens/auth_screens/forget_password_screen.dart';
import 'package:informa/services/auth_service.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../main_screen.dart';

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
  FirestoreService _firestoreService = new FirestoreService();

  resetMacros(AppUser user) async{
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyCalories(user.myCalories!);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyProtein(user.myProtein!);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyCarb(user.myCarb!);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyFats(user.myFats!);
    if(user.dietType == 2){
      DateTime now = DateTime.now();
      if(((now.difference(user.carbCycleStartDate!).inHours/24).floor() % 7) < 4){
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setDailyCarbCycle(user.lowAndHighCarb![0]);
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setCarbCycleIndex(0);
      }
      else{
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setDailyCarbCycle(user.lowAndHighCarb![1]);
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setCarbCycleIndex(1);
      }
    }
    double? myWater = await HelpFunction.getMyWater();
    if(myWater != null) HelpFunction.saveDailyWater(myWater);
  }

  onSubmit(BuildContext context) async{
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid) {
      _formKey.currentState!.save();
      setState(() { _isLoading = true; });
      var cred = await _authServices.signInWithEmailAndPassword(_email!.trim(), _password!);
      if(cred != null) {
        AppUser? user = await _firestoreService.getUserById(cred.user!.uid).catchError((e){
          print('error getting data from fireStore');
          setState(() {_isLoading = false;});
        });
        await user!.saveInSharedPreference();
        await HelpFunction.saveInitScreen(MainScreen.id);
        Provider.of<ActiveUserProvider>(context, listen: false).setUser(user);

        List<Challenge> challenges = await _firestoreService.getAllChallenges();
        Provider.of<ChallengesProvider>(context, listen: false).setChallenges(challenges);

        if(user.premium){
          await HelpFunction.saveMyWater(user.weight * 0.045);
          await HelpFunction.saveDailyWater(user.weight * 0.045);

          Provider.of<ActiveUserProvider>(context, listen: false)
              .setMyWater(user.weight * 0.045);
          Provider.of<ActiveUserProvider>(context, listen: false)
              .setDailyWater(user.weight * 0.045);

          if(user.fillPremiumForm){
            bool update = await _firestoreService.checkAndUpdateNewDayData(cred.user!.uid, user);
            if(update) resetMacros(user);
            if(user.dietType == 2){
              DateTime now = DateTime.now();
              if(((now.difference(user.carbCycleStartDate!).inHours/24).floor() % 7) < 4){
                Provider.of<ActiveUserProvider>(context, listen: false)
                    .setCarbCycleIndex(0);
                if(user.dailyCarbCycle == user.lowAndHighCarb![1]){
                  await _firestoreService.updateUserData(cred.user!.uid, {
                    'dailyCarbCycle': user.lowAndHighCarb![0],
                  });
                  Provider.of<ActiveUserProvider>(context, listen: false)
                      .setDailyCarbCycle(user.lowAndHighCarb![0]);
                }
              }
              else{
                Provider.of<ActiveUserProvider>(context, listen: false)
                    .setCarbCycleIndex(1);
                if(user.dailyCarbCycle == user.lowAndHighCarb![0]){
                  await _firestoreService.updateUserData(cred.user!.uid, {
                    'dailyCarbCycle': user.lowAndHighCarb![1],
                  });
                  Provider.of<ActiveUserProvider>(context, listen: false)
                      .setDailyCarbCycle(user.lowAndHighCarb![1]);
                }
              }
            }
            List? nutrition = await _firestoreService.getNutritionMeals(cred.user!.uid, user);
            if(nutrition != null){
              Provider.of<PremiumNutritionProvider>(context, listen: false)
                  .setBreakfast(nutrition[0]);
              Provider.of<PremiumNutritionProvider>(context, listen: false)
                  .setLunch(nutrition[1]);
              Provider.of<PremiumNutritionProvider>(context, listen: false)
                  .setLunch2(nutrition[1]);
              Provider.of<PremiumNutritionProvider>(context, listen: false)
                  .setDinner(nutrition[2]);
              Provider.of<PremiumNutritionProvider>(context, listen: false)
                  .setSnack(nutrition[3]);

              Provider.of<PremiumNutritionProvider>(context, listen: false)
                  .setBreakfastDone(nutrition[4]);
              Provider.of<PremiumNutritionProvider>(context, listen: false)
                  .setLunchDone(nutrition[5]);
              Provider.of<PremiumNutritionProvider>(context, listen: false)
                  .setLunch2Done(nutrition[6]);
              Provider.of<PremiumNutritionProvider>(context, listen: false)
                  .setDinnerDone(nutrition[7]);
              Provider.of<PremiumNutritionProvider>(context, listen: false)
                  .setSnackDone(nutrition[8]);

              List<int>? mainSnacksDone = nutrition[9].cast<int>();
              List<int>? supplementsDone = nutrition[10].cast<int>();
              List<String>? additionalMeals = nutrition[11].cast<String>();
              Provider.of<PremiumNutritionProvider>(context, listen: false)
                  .setMainSnacksDone(mainSnacksDone);
              Provider.of<PremiumNutritionProvider>(context, listen: false)
                  .setSupplementsDone(supplementsDone);
              if(additionalMeals != null)
                Provider.of<PremiumNutritionProvider>(context, listen: false)
                    .setAdditionalMeals(additionalMeals);
            }
          }
        }

        Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.id, (route) => false);
      }
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
      ),
    );
  }
}
