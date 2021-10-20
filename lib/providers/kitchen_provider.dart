import 'package:flutter/cupertino.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/meal_category.dart';

class KitchenProvider extends ChangeNotifier{
  List<MealCategory>? _items;

  KitchenProvider(){
    _items = [
      MealCategory(
        name: 'وصفات فراخ',
        meals: [
          new Meal(
            name: 'تشكن برجر',
            category: 'فراخ',
            image: 'assets/images/burger.png',
          ),
          new Meal(
            name: 'تشكن برجر',
            category: 'فراخ',
            image: 'assets/images/burger.png',
          ),
          new Meal(
            name: 'تشكن برجر',
            category: 'فراخ',
            image: 'assets/images/burger.png',
          ),
          new Meal(
            name: 'تشكن برجر',
            category: 'فراخ',
            image: 'assets/images/burger.png',
          ),
        ],
      ),
    ];
  }

  List<MealCategory>? get items => _items;

}