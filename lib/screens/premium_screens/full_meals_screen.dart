import 'package:flutter/material.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/widgets/full_meal_card.dart';

class FullMealsScreen extends StatefulWidget {
  static String id = 'full meals screen';
  final String screenName;
  final List<FullMeal> fullMeals;
  final int? mealDone;
  final int? whichMeal;
  const FullMealsScreen({Key? key, required this.screenName, required this.fullMeals, this.mealDone, this.whichMeal}) : super(key: key);

  @override
  _FullMealsScreenState createState() => _FullMealsScreenState();
}

class _FullMealsScreenState extends State<FullMealsScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
            itemCount: widget.fullMeals.length,
            itemBuilder: (context, index){
              return Column(
                children: [
                  FullMealCard(
                    fullMeal: widget.fullMeals[index],
                    mealDoneNumber: widget.mealDone != null? widget.mealDone : null,
                    id: index,
                    whichMeal: widget.whichMeal,
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
