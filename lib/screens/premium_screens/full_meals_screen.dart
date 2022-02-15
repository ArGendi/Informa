import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/services/notification_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/full_meal_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class FullMealsScreen extends StatefulWidget {
  static String id = 'full meals screen';
  final String screenName;
  final List<Meal> fullMeals;
  final int? mealDone;
  final int? whichMeal;
  final DateTime? time;
  const FullMealsScreen({Key? key, required this.screenName, required this.fullMeals, this.mealDone, this.whichMeal, this.time}) : super(key: key);

  @override
  _FullMealsScreenState createState() => _FullMealsScreenState(fullMeals, time);
}

class _FullMealsScreenState extends State<FullMealsScreen> {
  List<Meal> _fullMeals = [];
  FirestoreService _firestoreService = new FirestoreService();
  DateTime? _dateTime;
  bool _isLoading = false;

  _FullMealsScreenState(List<Meal> fullMeals, DateTime? time){
    _fullMeals = fullMeals;
    _dateTime = time;
  }

  onClick(BuildContext context, int index) async{
    String id = FirebaseAuth.instance.currentUser!.uid;
    if(widget.whichMeal == 1) {
      await _firestoreService.updateDoneMeals(id, {
        'breakfastDone': index,
      });
      Provider.of<PremiumNutritionProvider>(context, listen: false)
          .setBreakfastDone(index);
    }
    else if(widget.whichMeal == 2) {
      await _firestoreService.updateDoneMeals(id, {
        'lunchDone': index,
      });
      Provider.of<PremiumNutritionProvider>(context, listen: false)
          .setLunchDone(index);
    }
    else if(widget.whichMeal == 3) {
      await _firestoreService.updateDoneMeals(id, {
        'lunch2Done': index,
      });
      Provider.of<PremiumNutritionProvider>(context, listen: false)
          .setLunch2Done(index);
    }
    else if(widget.whichMeal == 4) {
      await _firestoreService.updateDoneMeals(id, {
        'dinnerDone': index,
      });
      Provider.of<PremiumNutritionProvider>(context, listen: false)
          .setDinnerDone(index);
    }
  }

  onBack(BuildContext context) async{
    String id = FirebaseAuth.instance.currentUser!.uid;
    if(widget.whichMeal == 1) {
      await _firestoreService.updateDoneMeals(id, {
        'breakfastDone': null,
      });
      Provider.of<PremiumNutritionProvider>(context, listen: false)
          .setBreakfastDone(null);
    }
    else if(widget.whichMeal == 2) {
      await _firestoreService.updateDoneMeals(id, {
        'lunchDone': null,
      });
      Provider.of<PremiumNutritionProvider>(context, listen: false)
          .setLunchDone(null);
    }
    else if(widget.whichMeal == 3) {
      await _firestoreService.updateDoneMeals(id, {
        'lunch2Done': null,
      });
      Provider.of<PremiumNutritionProvider>(context, listen: false)
          .setLunch2Done(null);
    }
    else if(widget.whichMeal == 4) {
      await _firestoreService.updateDoneMeals(id, {
        'dinnerDone': null,
      });
      Provider.of<PremiumNutritionProvider>(context, listen: false)
          .setDinnerDone(null);
    }
  }

  void listenNotification() async{
    var initScreen = await HelpFunction.getInitScreen();
    NotificationService.onNotifications.stream.listen((payload) {
      Navigator.pushNamed(context, initScreen!);
    });
  }

  setNotifications(AppUser user) async{
    await NotificationService.init(initScheduled: true);
    listenNotification();

    for(int i=0; i<user.datesOfMeals.length; i++) {
      NotificationService.cancelNotification(300 + i);
      NotificationService.showRepeatScheduledNotification(
        id: 300 + i,
        title: 'وجبة' + (i + 1).toString() + ' 🍔',
        body: 'متبقي ساعة علي الوجبة قم بتحضرها الأن',
        payload: 'payload',
        date: user.datesOfMeals[i].hour - 1,
      );
    }
  }

  onChangeMealDate(BuildContext context) async{
    bool timeChanged = Provider.of<ActiveUserProvider>(context, listen: false)
        .changeMealTime(widget.time!, _dateTime!);
    if(timeChanged){
      var datesOfMeals = Provider.of<ActiveUserProvider>(context, listen: false).user!.datesOfMeals;
      String id = FirebaseAuth.instance.currentUser!.uid;
      setState(() {_isLoading = true;});
      await _firestoreService.updateUserData(id, {
        'datesOfMeals': datesOfMeals,
      });
      var activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
      setNotifications(activeUser!);
      setState(() {_isLoading = false;});
    }
    Navigator.pop(context);
  }

  showPickTimeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'اختار وقت الوجبة',
                    style: TextStyle(
                      fontFamily: boldFont,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 180,
              child: CupertinoDatePicker(
                initialDateTime: _dateTime,
                onDateTimeChanged: (datetime){
                  setState(() {
                    _dateTime = datetime;
                  });
                },
                mode: CupertinoDatePickerMode.time,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                text: 'تعديل',
                onClick: () {
                  onChangeMealDate(context);
                },
                isLoading: _isLoading,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var premiumNutritionProvider = Provider.of<PremiumNutritionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenName),
        centerTitle: true,
        elevation: 0,
        actions: [
          if(widget.time != null)
          IconButton(
            onPressed: (){
              showPickTimeSheet(context);
            },
            icon: Icon(
              Icons.watch_later,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _fullMeals.length,
            itemBuilder: (context, index){
              return Column(
                children: [
                  FullMealCard(
                    fullMeal: _fullMeals[index],
                    mealDoneNumber: premiumNutritionProvider.getDoneNumberByMeal(widget.whichMeal),
                    id: index,
                    whichMeal: widget.whichMeal,
                    onClick: (){
                      onClick(context, index);
                    },
                    onBack: (){
                      onBack(context);
                    },
                  ),
                  SizedBox(height: 10,),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
