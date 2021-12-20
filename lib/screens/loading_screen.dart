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
import 'package:informa/screens/register_screens.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  FirestoreService _firestoreService = new FirestoreService();

  getUserDataFromFirebase(User currentUser) async{
    FirestoreService firestoreService = new FirestoreService();
    AppUser? user = await firestoreService.getUserById(currentUser.uid).catchError((e){
      print('error getting data from fireStore');
    });
    Provider.of<ActiveUserProvider>(context, listen: false).setUser(user!);
  }

  getAppData() async{
    String? lang = await HelpFunction.getUserLanguage();
    String? initScreen = await HelpFunction.getInitScreen();
    if(lang != null)
      Provider.of<AppLanguageProvider>(context, listen: false).changeLang(lang);
    Water water = new Water();
    await water.getFromSharedPreference();
    Provider.of<WaterProvider>(context, listen: false).setWater(water);
    if(initScreen != null) {
      var currentUser = FirebaseAuth.instance.currentUser;
      if(currentUser != null){
        AppUser user = new AppUser();
        await user.getFromSharedPreference();
        Provider.of<ActiveUserProvider>(context, listen: false).setUser(user);
        //get challenges
        List<Challenge> challenges = await _firestoreService.getAllChallenges();
        Provider.of<ChallengesProvider>(context, listen: false)
            .setChallenges(challenges);
      }
      Navigator.pushReplacementNamed(context, initScreen);
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
