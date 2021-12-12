import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:informa/constants.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/app_language_provider.dart';
import 'package:informa/screens/register_screens.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

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
    if(initScreen != null) {
      var currentUser = FirebaseAuth.instance.currentUser;
      if(currentUser != null){
        AppUser user = new AppUser();
        user.getFromSharedPreference();
        Provider.of<ActiveUserProvider>(context, listen: false).setUser(user);
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
      body: Center(
        child: SpinKitFoldingCube(
          color: primaryColor,
          size: 70.0,
        ),
      ),
    );
  }
}
