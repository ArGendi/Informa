import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:informa/constants.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/models/user.dart';
import 'package:informa/models/water.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/app_language_provider.dart';
import 'package:informa/providers/challenges_provider.dart';
import 'package:informa/providers/water_provider.dart';
import 'package:informa/screens/auth_screens/register_screens.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  FirestoreService _firestoreService = new FirestoreService();

  getAppData() async{
    String? lang = await HelpFunction.getUserLanguage();
    String? initScreen = await HelpFunction.getInitScreen();
    if(lang != null)
      Provider.of<AppLanguageProvider>(context, listen: false).changeLang(lang);
    if(initScreen != null) {
      var currentUser = FirebaseAuth.instance.currentUser;
      if(currentUser != null){
        AppUser user = new AppUser();
        await user.getFromSharedPreference();
        if(user.premium){
          AppUser? premiumUser = await _firestoreService.getUserById(currentUser.uid);
          if(premiumUser != null)
            Provider.of<ActiveUserProvider>(context, listen: false).setUser(premiumUser);
          else Navigator.pushReplacementNamed(context, RegisterScreens.id);
        }
        else Provider.of<ActiveUserProvider>(context, listen: false).setUser(user);
        //get challenges
        if(mounted) {
          List<Challenge> challenges = await _firestoreService
              .getAllChallenges();
          Provider.of<ChallengesProvider>(context, listen: false)
              .setChallenges(challenges);
          //get water settings
          Water water = new Water();
          await water.getFromSharedPreference();
          Provider.of<WaterProvider>(context, listen: false).setWater(water);
        }
      }
      if(initScreen == MainScreen.id && currentUser == null)
        Navigator.pushReplacementNamed(context, RegisterScreens.id);
      else Navigator.pushReplacementNamed(context, initScreen);
    }
    else
      Navigator.pushReplacementNamed(context, RegisterScreens.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(this.mounted){
      getAppData();
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
        child: Center(
          child: SpinKitFoldingCube(
            color: primaryColor,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
