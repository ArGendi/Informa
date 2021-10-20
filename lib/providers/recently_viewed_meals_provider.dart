import 'package:flutter/cupertino.dart';
import 'package:informa/models/meal.dart';

class RecentlyViewedMealsProvider extends ChangeNotifier{
  List<Meal>? _items;

  RecentlyViewedMealsProvider(){
    _items = [
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
    ];
  }

  List<Meal>? get items => _items;

  addItem(Meal meal){
    _items!.add(meal);
    notifyListeners();
  }

  removeItem(Meal meal){
    _items!.remove(meal);
    notifyListeners();
  }

}