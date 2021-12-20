import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/providers/challenges_provider.dart';
import 'package:informa/widgets/challenge_card.dart';
import 'package:informa/widgets/countdown_card.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ChallengesScreen extends StatefulWidget {
  static String id = 'challenges';
  const ChallengesScreen({Key? key}) : super(key: key);

  @override
  _ChallengesScreenState createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  @override
  Widget build(BuildContext context) {
    var challenges = Provider.of<ChallengesProvider>(context).challenges;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('تحديات أنفورما'),
        centerTitle: true,
        leading: IconButton(
          splashRadius: splashRadius,
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: challenges.isNotEmpty ? ListView.builder(
            shrinkWrap: true,
            itemCount: challenges.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ChallengeCard(challenge: challenges[index]),
                  SizedBox(height: 15,),
                ],
              );
            },
          ) : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'لا يوجد تحديات الأن',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'CairoBold'
                  ),
                ),
                Text(
                  'انتظر تحديات أنفورما للفوز بالهدايا 🎁',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
