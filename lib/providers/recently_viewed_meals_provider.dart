import 'package:flutter/cupertino.dart';
import 'package:informa/models/meal.dart';

class RecentlyViewedMealsProvider extends ChangeNotifier{
  List<Meal>? _items;

  RecentlyViewedMealsProvider(){
    _items = [
      new Meal(
        id: '5',
        name: 'تشكن برجر',
        category: 'فراخ',
        image: 'assets/images/burger.png',
        period: '10',
        description: 'فراخ لزيزة مع شرائح الخضار المتبلة',
        fats: 20,
        protein: 25,
        calories: 200,
        carbohydrates: 30,
        components: [
          'صدر فرخة',
          'شرائح بصل'
        ],
        video: 'https://www.youtube.com/watch?v=GgB3okbbZr0',
      ),
      new Meal(
        id: '1',
        name: 'تشكن برجر',
        category: 'فراخ',
        image: 'assets/images/burger.png',
        period: '10',
        description: 'فراخ لزيزة مع شرائح الخضار المتبلة',
        fats: 20,
        protein: 25,
        calories: 200,
        carbohydrates: 30,
        components: [
          'صدر فرخة',
          'شرائح بصل'
        ],
        video: 'https://www.youtube.com/watch?v=GgB3okbbZr0',
      ),
      new Meal(
        id: '3',
        name: 'تشكن برجر',
        category: 'فراخ',
        image: 'assets/images/burger.png',
        period: '10',
        description: 'فراخ لزيزة مع شرائح الخضار المتبلة',
        fats: 20,
        protein: 25,
        calories: 200,
        carbohydrates: 30,
        components: [
          'صدر فرخة',
          'شرائح بصل'
        ],
        video: 'https://www.youtube.com/watch?v=GgB3okbbZr0',
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