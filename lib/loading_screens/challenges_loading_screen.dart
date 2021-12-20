import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/providers/challenges_provider.dart';
import 'package:informa/screens/challenges_screen.dart';
import 'package:provider/provider.dart';

class ChallengesLoadingScreen extends StatefulWidget {
  static String id = 'challenges loading';
  const ChallengesLoadingScreen({Key? key}) : super(key: key);

  @override
  _ChallengesLoadingScreenState createState() => _ChallengesLoadingScreenState();
}

class _ChallengesLoadingScreenState extends State<ChallengesLoadingScreen> {

  loadData() async{
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('challenges').orderBy('deadline').get();
    var docs = documentSnapshot.docs;
    for(var doc in docs){
      Challenge challenge = new Challenge();
      challenge.fromJson(doc.data());
      Provider.of<ChallengesProvider>(context, listen: false)
          .addChallenge(challenge);
    }
    Provider.of<ChallengesProvider>(context, listen: false).dataLoaded();
    Navigator.pushReplacementNamed(context, ChallengesScreen.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        ),
      ),
    );
  }
}
