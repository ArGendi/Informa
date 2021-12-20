import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/loading_screens/challenges_loading_screen.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/challenges_provider.dart';
import 'package:informa/screens/challenges_screen.dart';
import 'package:informa/screens/free_kitchen_screen.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/widgets/home_banner.dart';
import 'package:informa/widgets/submit_challenge.dart';
import 'package:provider/provider.dart';

import 'muscle_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    var challengesProvider = Provider.of<ChallengesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('الرئيسية',),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/appBg.png')
          )
        ),
        child: ListView(
          children: [
            if(!activeUser!.premium)
              Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                  image: AssetImage('assets/images/home1.png',),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'أنضم الي عائلة أنفورما',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'CairoBold',
                          color: Colors.white,
                        ),
                      ),
                      //SizedBox(height: 10,),
                      Text(
                        'للحصول علي برنامج تغذية وتمارين مخصصة لجسمك بالأضافة الي مميزات غير محدودة',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 10,),
                      MaterialButton(
                        onPressed: (){
                          Navigator.pushNamed(context, PlansScreen.id);
                        },
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'أنضم الأن',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'CairoBold',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  HomeBanner(
                    mainText: 'تمارين انفورما',
                    subText: 'للحصول علي برنامج تغذية وتمارين ',
                    btnText: 'تصفح التمارين',
                    imagePath: 'assets/images/home3.jpg',
                    onClick: (){
                      Navigator.pushNamed(context, MuscleSelectionScreen.id);
                    },
                  ),
                  SizedBox(height: 10,),
                  HomeBanner(
                    mainText: 'مطبخ انفورما',
                    subText: 'للحصول علي برنامج تغذية وتمارين ',
                    btnText: 'تصفح الوجبات',
                    imagePath: 'assets/images/home4.png',
                    onClick: (){
                      Navigator.pushNamed(context, FreeKitchenScreen.id);
                    },
                  ),
                  SizedBox(height: 10,),
                  HomeBanner(
                    mainText: 'تحديات انفورما',
                    subText: 'للحصول علي برنامج تغذية وتمارين ',
                    btnText: 'تصفح التحديات',
                    imagePath: 'assets/images/home2.png',
                    challenge: challengesProvider.challenges.isNotEmpty?
                      challengesProvider.challenges[0] : null,
                    onClick: (){
                      Navigator.pushNamed(context, ChallengesScreen.id);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 75,),
          ],
        ),
      )
    );
  }
}
