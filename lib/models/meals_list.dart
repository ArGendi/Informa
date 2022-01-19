import 'package:informa/models/meal.dart';

class MealsList{
  static List<Meal> allMeals = [
    Meal(
      id: '1',
      name: 'صدور فراخ',
    ),
    Meal(
      id: '2',
      name: 'وراك فراخ',
    ),
    Meal(
      id: '3',
      name: 'لحمة',
    ),
    Meal(
      id: '4',
      name: 'كبدة بقري',
    ),
    Meal(
      id: '5',
      name: 'كبدة فراخ',
    ),
    Meal(
      id: '6',
      name: 'سمك بوري',
    ),
    Meal(
      id: '7',
      name: 'سمك بلطي',
    ),
    Meal(
      id: '8',
      name: 'سمك فيلية',
    ),
    Meal(
      id: '9',
      name: 'سمك سلمون',
    ),
    Meal(
      id: '10',
      name: 'تونة',
    ),
    Meal(
      id: '11',
      name: 'جمبري',
    ),
    Meal(
      id: '12',
      name: 'سبيط',
    ),
    Meal(
      id: '13',
      name: 'مكرونة',
    ),
    Meal(
      id: '14',
      name: 'رز',
    ),
    Meal(
      id: '15',
      name: 'بطاطس',
    ),
    Meal(
      id: '16',
      name: 'بطاطا حلوة',
    ),
    Meal(
      id: '17',
      name: 'عيش تورتلا',
    ),
    Meal(
      id: '18',
      name: 'عيش توست',
    ),
    Meal(
      id: '19',
      name: 'بيض',
    ),
    Meal(
      id: '20',
      name: 'جبنة قريش',
    ),
    Meal(
      id: '21',
      name: 'صدور رومي مدخن',
    ),
    Meal(
      id: '22',
      name: 'جبنة تشيدر لايت',
    ),
    Meal(
      id: '23',
      name: 'جبنة تشيدر',
    ),
    Meal(
      id: '24',
      name: 'جبنة فيتا لايت',
    ),
    Meal(
      id: '25',
      name: 'فول',
    ),
    Meal(
      id: '26',
      name: 'شوفان',
    ),
    Meal(
      id: '27',
      name: 'حليب خالي الدسم',
    ),
    Meal(
      id: '28',
      name: 'عسل',
    ),
    Meal(
      id: '29',
      name: 'زبادي',
    ),
    Meal(
      id: '30',
      name: 'زبادي يوناني',
    ),
    Meal(
      id: '31',
      name: 'فول سوداني',
    ),
    Meal(
      id: '32',
      name: 'لوز',
    ),
    Meal(
      id: '33',
      name: 'كاجو',
    ),
    Meal(
      id: '34',
      name: 'زبدة فول سوداني',
    ),
    Meal(
      id: '35',
      name: 'مربى',
    ),
    Meal(
      id: '36',
      name: 'شوكولاتة غامقة',
    ),
    Meal(
      id: '37',
      name: 'كاكاو',
    ),
    Meal(
      id: '38',
      name: 'موز',
    ),
    Meal(
      id: '39',
      name: 'تفاح',
    ),
    Meal(
      id: '40',
      name: 'بطيخ',
    ),
    Meal(
      id: '41',
      name: 'برتقال',
    ),
    Meal(
      id: '42',
      name: 'فراولة',
    ),
    Meal(
      id: '43',
      name: 'رمان',
    ),
    Meal(
      id: '44',
      name: 'خوخ',
    ),
    Meal(
      id: '45',
      name: 'عنب',
    ),
    Meal(
      id: '46',
      name: 'تين',
    ),
    Meal(
      id: '47',
      name: 'جوافة',
    ),
    Meal(
      id: '48',
      name: 'تمر',
    ),
    Meal(
      id: '49',
      name: 'بلح',
    ),
    Meal(
      id: '50',
      name: 'بروكلي',
    ),
    Meal(
      id: '51',
      name: 'كوسة',
    ),
    Meal(
      id: '52',
      name: 'فاصوليا',
    ),
    Meal(
      id: '53',
      name: 'مشروم',
    ),
    Meal(
      id: '54',
      name: 'جزر',
    ),
    Meal(
      id: '55',
      name: 'ذزة حلو',
    ),
    Meal(
      id: '56',
      name: 'طماطم',
    ),
    Meal(
      id: '57',
      name: 'خيار',
    ),
    Meal(
      id: '58',
      name: 'خس',
    ),
    Meal(
      id: '59',
      name: 'بصل',
    ),
    Meal(
      id: '60',
      name: 'فلفل',
    ),
  ];

  static List<Meal> breakfast = [];
  static List<Meal> lunch = [];
  static List<Meal> dinner = [];

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
      meals.add(allMeals[index-1]);
    }
    return meals;
  }


}