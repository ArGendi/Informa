import 'package:flutter/material.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/screens/single_meal_screen.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class FullMealCard extends StatefulWidget {
  final FullMeal fullMeal;
  final int id;
  final int? mealDoneNumber;
  final int? whichMeal;
  const FullMealCard({Key? key, required this.fullMeal, this.mealDoneNumber, required this.id, this.whichMeal}) : super(key: key);

  @override
  _FullMealCardState createState() => _FullMealCardState();
}

class _FullMealCardState extends State<FullMealCard> {
  bool _isFavorite = false;

  List<int> calculateFullMealInfo(){
    double calories = 0, protein = 0, carb = 0, fats = 0;
    widget.fullMeal.components!.forEach((key, value) {
      if(key.serving != 1){
        calories += key.calories! * (value / 100);
        protein += key.protein! * (value / 100);
        carb += key.carb! * (value / 100);
        fats += key.fats! * (value / 100);
      }
      else{
        calories += key.calories! * value;
        protein += key.protein! * value;
        carb += key.carb! * value;
        fats += key.fats! * value;
      }
    });
    return [calories.toInt(), protein.toInt(), carb.toInt(), fats.toInt()];
  }

  List<String> convertComponents(){
    List<String> components = [];
    widget.fullMeal.components!.forEach((key, value) {
      String unit = '';
      if(key.unit!.trim() == 'gm' || key.unit!.trim() == 'tsp') unit = 'جرام ';
      String temp = value.toString() + ' ' + unit + key.name!;
      components.add(temp);
    });
    return components;
  }

  @override
  Widget build(BuildContext context) {
    //var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: (){
        if(widget.mealDoneNumber != null && widget.mealDoneNumber != widget.id) return;
        //List<int> info = calculateFullMealInfo();
        Meal meal = new Meal(
          id: widget.fullMeal.id,
          name: widget.fullMeal.name,
          engName: widget.fullMeal.engName,
          image: widget.fullMeal.image,
          calories: widget.fullMeal.calories!.toDouble(),
          protein: widget.fullMeal.protein!.toDouble(),
          carb: widget.fullMeal.carb!.toDouble(),
          fats: widget.fullMeal.fats!.toDouble(),
          components: convertComponents(),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SingleMealScreen(
            meal: meal,
            mealDoneNumber: widget.mealDoneNumber,
            otherId: widget.id,
            onClick: (){
              Provider.of<PremiumNutritionProvider>(context, listen: false)
                  .setBreakfastDone(widget.id);
            },
          )),
        );
      },
      child: Opacity(
        opacity: widget.mealDoneNumber != null && widget.mealDoneNumber == widget.id?
            1 : 0.4,
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Hero(
                      tag: widget.fullMeal.id!,
                      child: widget.fullMeal.image != null ?
                      Image.network(
                        widget.fullMeal.image!,
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ) : Container(
                        width: 130,
                        height: 130,
                        color: Colors.grey[300],
                      ),
                    ),
                    if(widget.mealDoneNumber != null && widget.mealDoneNumber == widget.id)
                      Opacity(
                        opacity: 0.7,
                        child: Container(
                          width: 130,
                          height: 130,
                          color: Colors.green[400],
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.fullMeal.name!,
                            style: TextStyle(
                                fontSize: 16,
                                height: 1
                            ),
                          ),
                          if(widget.fullMeal.description != null)
                            Text(
                              widget.fullMeal.description!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600]
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: (){
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
                splashRadius: 5,
                icon: Icon(
                  _isFavorite ? Icons.bookmark_outlined : Icons.bookmark_outline,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
