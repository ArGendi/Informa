import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/full_meal_card.dart';
import 'package:provider/provider.dart';

class FullMealsScreen extends StatefulWidget {
  static String id = 'full meals screen';
  final String screenName;
  final List<FullMeal> fullMeals;
  final int? mealDone;
  final int? whichMeal;
  const FullMealsScreen({Key? key, required this.screenName, required this.fullMeals, this.mealDone, this.whichMeal}) : super(key: key);

  @override
  _FullMealsScreenState createState() => _FullMealsScreenState(fullMeals);
}

class _FullMealsScreenState extends State<FullMealsScreen> {
  List<FullMeal> _fullMeals = [];
  FirestoreService _firestoreService = new FirestoreService();

  _FullMealsScreenState(List<FullMeal> fullMeals){
    _fullMeals = fullMeals;
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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var premiumNutritionProvider = Provider.of<PremiumNutritionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenName),
        centerTitle: true,
        elevation: 0,
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
