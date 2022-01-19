import 'package:flutter/cupertino.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/meal_category.dart';

class KitchenProvider extends ChangeNotifier{
  List<MealCategory>? _items;

  KitchenProvider(){
    _items = [
      MealCategory(
        name: 'الفراخ',
        image: 'assets/images/burger.png',
        index: 0,
        meals: [
          new Meal(
            id: '1',
            name: 'تشكن برجر',
            category: 'فراخ',
            image: 'assets/images/burger.png',
            //period: '10',
            description: 'فراخ لزيزة مع شرائح الخضار المتبلة',
            fats: 20,
            protein: 25,
            calories: 200,
            carb: 30,
            components: [
              'صدر فرخة',
              'شرائح بصل'
            ],
            video: 'https://www.youtube.com/watch?v=GgB3okbbZr0',
          ),
          new Meal(
            id: '2',
            name: 'تشكن برجر',
            category: 'فراخ',
            image: 'assets/images/burger.png',
            //period: '10',
            description: 'فراخ لزيزة مع شرائح الخضار المتبلة',
            fats: 20,
            protein: 25,
            calories: 200,
            carb: 30,
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
            //period: '10',
            description: 'فراخ لزيزة مع شرائح الخضار المتبلة',
            fats: 20,
            protein: 25,
            calories: 200,
            carb: 30,
            components: [
              'صدر فرخة',
              'شرائح بصل'
            ],
            video: 'https://www.youtube.com/watch?v=GgB3okbbZr0',
          ),
        ],
      ),
      MealCategory(
        name: 'اللحوم',
        image: 'assets/images/burger.png',
        index: 1,
        meals: [
          new Meal(
            id: '4',
            name: 'تشكن برجر',
            category: 'فراخ',
            image: 'assets/images/burger.png',
            //period: '10',
            description: 'فراخ لزيزة مع شرائح الخضار المتبلة',
            fats: 20,
            protein: 25,
            calories: 200,
            carb: 30,
            components: [
              'صدر فرخة',
              'شرائح بصل'
            ],
            video: 'https://www.youtube.com/watch?v=GgB3okbbZr0',
          ),
          new Meal(
            id: '5',
            name: 'تشكن برجر',
            category: 'فراخ',
            image: 'assets/images/burger.png',
            //period: '10',
            description: 'فراخ لزيزة مع شرائح الخضار المتبلة',
            fats: 20,
            protein: 25,
            calories: 200,
            carb: 30,
            components: [
              'صدر فرخة',
              'شرائح بصل'
            ],
            video: 'https://www.youtube.com/watch?v=GgB3okbbZr0',
          ),
        ],
      ),
    ];
  }

  List<MealCategory>? get items => _items;

}