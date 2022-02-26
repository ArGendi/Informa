import 'package:informa/models/meal.dart';

class MealsList{
  static List<Meal> allMealsList = [];
  static List<Meal> breakfast = [];
  static List<Meal> lunch = [];
  static List<Meal> dinner = [];
  static List<Meal> salads = [
    new Meal(
      id: '1',
      name: 'سلطة 1',
      engName: 'salad 1',
      protein: 0,
      carb: 0,
      fats: 0,
      components: [
        '80 جرام خيار',
        'شوية طماطم',
      ],
    ),
    new Meal(
      id: '2',
      name: 'سلطة 2',
      engName: 'salad 2',
      protein: 0,
      carb: 0,
      fats: 0,
      components: [
        '80 جرام خيار',
        'شوية طماطم',
      ],
    ),
  ];

  List<String> getMealsIds(List meals){
    List<String> temp = [];
    for(var meal in meals)
      temp.add(meal.id!);
    return temp;
  }

  List<Meal> getMealsByIds(List mealsIds){
    List<Meal> meals = [];
    for(int i=0; i<mealsIds.length; i++){
      int index = int.parse(mealsIds[i]);
      meals.add(allMealsList[index-1]);
    }
    return meals;
  }


}