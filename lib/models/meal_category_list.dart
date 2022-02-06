import 'package:informa/models/meal_category.dart';
import 'package:informa/models/meals_list.dart';

class MealCategoryList{
  static List<MealCategory> breakfast = [
    MealCategory(
      id: '1',
      name: 'أوملت',
      engName: 'Omelette',
      meals: [
        MealsList.breakfast[0],
        MealsList.breakfast[1],
        MealsList.breakfast[52],
        MealsList.breakfast[21],
      ],
      extra: MealsList.breakfast[63],
    ),
    MealCategory(
      id: '2',
      name: 'جبنة و صدور مدخنة',
      engName: 'Cheese and chest BBQ',
      meals: [
        MealsList.breakfast[4],
        MealsList.breakfast[7],
        MealsList.breakfast[23],
      ],
      extra: MealsList.breakfast[63],
    ),
    MealCategory(
      id: '3',
      name: 'بيض وزبادي',
      engName: 'Egg and yogurt',
      meals: [
        MealsList.breakfast[0],
        MealsList.breakfast[1],
        MealsList.breakfast[21],
        MealsList.breakfast[17],
      ],
      extra: MealsList.breakfast[63],
    ),
  ];

  static List<MealCategory> lunch = [
    MealCategory(
      id: '1',
      name: 'فتة الفراخ',
      engName: 'Chicken fata',
      meals: [
        MealsList.lunch[1],
        MealsList.lunch[13],
        MealsList.lunch[34],
      ],
      extra: MealsList.breakfast[63],
    ),
    MealCategory(
      id: '2',
      name: 'كاساديا لحمة',
      engName: 'CD beef',
      meals: [
        MealsList.lunch[0],
        //MealsList.lunch[10],
        MealsList.lunch[16],
      ],
      extra: MealsList.breakfast[63],
    ),
    MealCategory(
      id: '3',
      name: 'فتة شاورما لحمة',
      engName: 'CD beef',
      meals: [
        MealsList.lunch[0],
        MealsList.lunch[13],
        //MealsList.lunch[16],
      ],
      extra: MealsList.breakfast[63],
    ),
  ];

  static List<MealCategory> dinner = [
    MealCategory(
      id: '1',
      name: 'أوملت',
      engName: 'Omelette',
      meals: [
        MealsList.breakfast[0],
        MealsList.breakfast[1],
        MealsList.breakfast[52],
        MealsList.breakfast[21],
      ],
      extra: MealsList.breakfast[63],
    ),
    MealCategory(
      id: '2',
      name: 'كاساديا فراخ',
      engName: 'CD chicken',
      meals: [
        MealsList.dinner[11],
        MealsList.lunch[10],
        MealsList.lunch[16],
      ],
      extra: MealsList.breakfast[63],
    ),
  ];
}