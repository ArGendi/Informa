import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/screens/video_player_screen.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/meal_info_box.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class SingleMealScreen extends StatefulWidget {
  static String id = 'detailed meal';
  final Meal meal;
  final int? otherId;
  final int? mealDoneNumber;
  final VoidCallback? onClick;
  final VoidCallback? onBack;
  final bool? isDone;
  const SingleMealScreen({Key? key, required this.meal, this.otherId, this.mealDoneNumber, this.onClick, this.isDone, this.onBack}) : super(key: key);

  @override
  _SingleMealScreenState createState() => _SingleMealScreenState(otherId, mealDoneNumber, isDone);
}

class _SingleMealScreenState extends State<SingleMealScreen> {
  bool _isFavorite = false;
  bool _isDoneLoading = false;
  bool _isBackLoading = false;
  late bool _isDone;
  FirestoreService _firestoreService = new FirestoreService();

  _SingleMealScreenState(int? id, int? mealDoneNumber, bool? done){
    _isDone = false;
    if(id != null && mealDoneNumber != null){
      if(id == mealDoneNumber) _isDone = true;
    }
    if(done != null){
      if(done) _isDone = true;
    }
  }

  onDone(BuildContext context) async{
    var activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
    if(!activeUser!.premium)
      Navigator.pushNamed(context, PlansScreen.id);
    else{
      int newCalories = activeUser.dailyCalories! - widget.meal.calories!.toInt();
      int newProtein = activeUser.dailyProtein! - widget.meal.protein!.toInt();
      int newCarb = activeUser.dailyCarb! - widget.meal.carb!.toInt();
      int newFats = activeUser.dailyFats! - widget.meal.fats!.toInt();
      if(newCalories <= 17 && newCalories >= 0) newCalories = 0;
      if(newProtein == 1) newProtein = 0;
      if(newCarb == 1) newCarb = 0;
      if(newFats == 1) newFats = 0;

      setState(() {_isDoneLoading = true;});

      String id = FirebaseAuth.instance.currentUser!.uid;
      await _firestoreService.updateUserData(id, {
        'dailyCalories': newCalories,
        'dailyProtein': newProtein,
        'dailyCarb': newCarb,
        'dailyFats': newFats,
      });
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setDailyCalories(newCalories);
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setDailyProtein(newProtein);
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setDailyCarb(newCarb);
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setDailyFats(newFats);

      if(widget.onClick != null) widget.onClick!();

      setState(() {_isDoneLoading = false;});
      setState(() {_isDone = true;});
    }
  }

  onCancel(BuildContext context) async{
    var activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
    int newCalories = activeUser!.dailyCalories! + widget.meal.calories!.toInt();
    int newProtein = activeUser.dailyProtein! + widget.meal.protein!.toInt();
    int newCarb = activeUser.dailyCarb! + widget.meal.carb!.toInt();
    int newFats = activeUser.dailyFats! + widget.meal.fats!.toInt();

    setState(() {_isBackLoading = true;});

    String id = FirebaseAuth.instance.currentUser!.uid;
    await _firestoreService.updateUserData(id, {
      'dailyCalories': newCalories,
      'dailyProtein': newProtein,
      'dailyCarb': newCarb,
      'dailyFats': newFats,
    });
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyCalories(newCalories);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyProtein(newProtein);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyCarb(newCarb);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyFats(newFats);

    if(widget.onBack != null) widget.onBack!();

    setState(() {_isBackLoading = false;});
    setState(() {_isDone = false;});
  }

  Widget getMealSections(){
    return Column(
      children: [
        for(int i=0; i<widget.meal.sections!.length; i++)
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.meal.sections![i].name!,
                  style: TextStyle(
                      fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Card(
                    elevation: 0,
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Text(
              'المكونات',
              style: TextStyle(
                  fontSize: 16,
                  color: primaryColor
              ),
            ),
            // for(int j=0; i<widget.meal.sections![i].meals!.length; j++)
            //   Text(
            //     (j+1).toString() + '- ' + widget.meal.sections![i].components![j],
            //   ),
            Divider(height: 30,),
          ],
        ),
      ],
    );
  }

  Widget getMealComponents(){
    return Column(
      children: [
        Text(
          'المكونات',
          style: TextStyle(
              fontSize: 20,
              color: primaryColor
          ),
        ),
        for(int i=0; i<widget.meal.components!.length; i++)
          Text(
            (i+1).toString() + '- ' + widget.meal.components![i],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Stack(
                children: [
                  Hero(
                    tag: widget.meal.id!,
                    child: widget.meal.image != null ? Image.asset(
                      widget.meal.image!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300,
                    ) : Container(
                      width: double.infinity,
                      height: 300,
                      color: Colors.grey[300],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 300,
                    alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.grey.withOpacity(0.0),
                            Colors.black,
                          ],
                        )
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 15,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoPlayerScreen(
                            url: widget.meal.video!,
                          )),
                        );
                      },
                      child: Card(
                        elevation: 0,
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                    indent: screenSize.width * 0.37,
                    endIndent: screenSize.width * 0.37,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(widget.meal.category != null)
                        Text(
                          widget.meal.category!,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.meal.name!,
                            style: TextStyle(
                              fontSize: 24,
                              height: 1.6
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                              if(!activeUser!.premium){
                                Navigator.pushNamed(context, PlansScreen.id);
                              }
                              else{
                                setState(() {
                                  _isFavorite = !_isFavorite;
                                });
                              }
                            },
                            splashRadius: 5,
                            icon: Icon(
                              _isFavorite ? Icons.bookmark_outlined : Icons.bookmark_outline,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      //SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'نسب الوجبة',
                            style: TextStyle(
                              fontSize: 12
                            ),
                          ),
                          if(!activeUser!.premium)
                            TextButton(
                              onPressed: (){
                                Navigator.pushNamed(context, PlansScreen.id);
                              },
                              child: Text(
                                'الترقية الي أنفورما بلس',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MealInfoBox(
                            text: 'سعرات حرارية',
                            value: widget.meal.calories!.toInt(),
                            percent: 0.0,
                          ),
                          MealInfoBox(
                            text: 'بروتين',
                            value: widget.meal.protein!.toInt(),
                            percent: 0.0,
                          ),
                          MealInfoBox(
                            text: 'كاربوهايدرات',
                            value: widget.meal.carb!.toInt(),
                            percent: 0.0,
                          ),
                          MealInfoBox(
                            text: 'دهون',
                            value: widget.meal.fats!.toInt(),
                            percent: 0.0,
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),

                      widget.meal.sections != null ?
                        getMealSections() : getMealComponents(),
                    ],
                  ),
                  SizedBox(height: 20,),
                  CustomButton(
                    text: _isDone ? 'عاش' : 'أنتهيت من الوجبة',
                    onClick: (){
                      onDone(context);
                    },
                    iconExist: false,
                    isLoading: _isDoneLoading,
                  ),
                  if(_isDone)
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      CustomButton(
                        text: 'لم انتهي من الوجبة',
                        onClick: (){
                          onCancel(context);
                        },
                        bgColor: Colors.grey.shade400,
                        iconExist: false,
                        isLoading: _isBackLoading,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
