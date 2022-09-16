import 'dart:async';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:informa/models/excercise.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/meal_category.dart';
import 'package:informa/models/meals_list.dart';
import 'package:informa/models/user.dart';
import 'package:informa/models/workout.dart';
import 'package:informa/screens/auth_screens/main_register_screen.dart';
import 'package:informa/screens/auth_screens/register_screens.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/services/informa_service.dart';
import 'package:informa/services/notification_service.dart';
import 'package:informa/services/web_services.dart';
import 'package:informa/widgets/workout_card.dart';

class Dummy extends StatefulWidget {
  const Dummy({
    Key? key,
  }) : super(key: key);

  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> with TickerProviderStateMixin {
  List list = [1, 2, 3];
  late InformaService _informaService;
  late AppUser _user;

  sendEmail() async {
    WebServices webServices = new WebServices();
    var response = await webServices
        .postWithOrigin('https://api.emailjs.com/api/v1.0/email/send', {
      "user_id": "user_sL5eCDqsL5h8Jaoq71PH0",
      "service_id": "service_emgj8vt",
      "template_id": "template_9oefxlr",
      "template_params": {
        'user_message': '92723',
        'to_email': 'abdelrahman1abdallah@gmail.com',
      }
    });
    print('response: ' + response.statusCode.toString());
  }

  Future<List<List<dynamic>>> loadAsset(String fileName) async {
    var data = await rootBundle.loadString(fileName);
    return CsvToListConverter().convert(data);
  }

  Future setAllMeals() async {
    List<List<dynamic>> breakfast =
        await loadAsset('assets/files/breakfast.csv');
    List<List<dynamic>> lunch = await loadAsset('assets/files/lunch.csv');
    List<List<dynamic>> dinner = await loadAsset('assets/files/dinner.csv');
    for (int i = 1; i < breakfast.length; i++) {
      MealsList.breakfast.add(
        Meal(
          id: i.toString(),
          name: breakfast[i][1].toString().trim(),
          engName: breakfast[i][1].toString().trim(),
          serving: breakfast[i][2],
          protein: breakfast[i][4],
          carb: breakfast[i][5],
          fats: breakfast[i][6],
          calories: breakfast[i][7],
        ),
      );
    }
    for (int i = 1; i < lunch.length; i++) {
      MealsList.lunch.add(
        Meal(
          id: (i + breakfast.length).toString(),
          name: lunch[i][1].toString().trim(),
          engName: lunch[i][1].toString().trim(),
          serving: lunch[i][2].toDouble(),
          protein: lunch[i][4].toDouble(),
          carb: lunch[i][5].toDouble(),
          fats: lunch[i][6].toDouble(),
          calories: lunch[i][7].toDouble(),
        ),
      );
    }
    for (int i = 1; i < dinner.length; i++) {
      MealsList.dinner.add(
        Meal(
          id: (i + breakfast.length + dinner.length).toString(),
          name: dinner[i][1].toString().trim(),
          engName: dinner[i][1].toString().trim(),
          serving: dinner[i][2],
          protein: dinner[i][4],
          carb: dinner[i][5],
          fats: dinner[i][6],
          calories: dinner[i][7],
        ),
      );
    }
  }

  fullMeal() {
    MealCategory mealCategory = new MealCategory();
    mealCategory.meals = [];
    mealCategory.meals!.add(MealsList.breakfast[0]);
    mealCategory.meals!.add(MealsList.breakfast[1]);
    mealCategory.meals!.add(MealsList.breakfast[25]);
    mealCategory.meals!.add(MealsList.breakfast[34]);
    mealCategory.meals!.add(MealsList.breakfast[13]);
    mealCategory.extra = MealsList.breakfast[60];
    //mealCategory.meals!.add(MealsList.breakfast[21]);
    // MealsService mealsService = new MealsService();
    //var map = mealsService.calculateFullMealNumbers(MealCategoryList.breakfast[0], 31, 33, 11);
    // map.forEach((key, value) {
    //   print(key.name! + ": " + value.toString());
    // });
  }

  // Future<String> _read() async {
  //   String text = 'lol';
  //   try {
  //     final Directory directory = await getApplicationDocumentsDirectory();
  //     final File file = File('${directory.path}/my_file.txt');
  //     text = await file.readAsString();
  //   } catch (e) {
  //     print("Couldn't read file");
  //   }
  //   return text;
  // }

  makeNotification() async {
    await NotificationService.init(initScheduled: true);
    listenNotification1();
    NotificationService.showRepeatScheduledNotification(
      id: 200,
      title: 'notification id 200',
      body: 'makeNotification',
      payload: 'payload',
      date: DateTime.now().hour,
      minute: DateTime.now().minute + 10,
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Notification after 10 min'),
    ));
  }

  makeNotification2() async {
    await NotificationService.init(initScheduled: true);
    listenNotification2();
    NotificationService.showRepeatScheduledNotification(
      id: 201,
      title: 'notification id 201',
      body: 'makeNotification 2',
      payload: 'payload',
      date: DateTime.now().hour,
      minute: DateTime.now().minute + 10,
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Notification after 10 min'),
    ));
  }

  makeNotification3() async {
    await NotificationService.init(initScheduled: true);
    listenNotification3();
    NotificationService.showRepeatScheduledNotification(
      id: 202,
      title: 'notification id 202',
      body: 'makeNotification 3',
      payload: 'payload',
      date: DateTime.now().hour,
      minute: DateTime.now().minute + 10,
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Notification after 10 min'),
    ));
  }

  @override
  void initState() {
    super.initState();
    _user = AppUser(
        gender: 1,
        weight: 86,
        fatsPercent: 20,
        age: 40,
        tall: 178,
        fitnessLevel: 2,
        goal: 3);
    _user.iTrainingDays = 4;
    _user.inBody = true;
    _informaService = InformaService();
    _informaService.setUser(_user);
    print("Calories: " + _informaService.calculateNeededCalories().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: WorkoutCard(
              workout: Workout(
                exercise: Exercise(name: 'بنش بريش'),
                numberOfSets: 3,
                restTime: 20,
              ),
            ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     IconButton(
            //       onPressed: () async{
            //         DateTime now = DateTime.now();
            //         DateTime after = DateTime(now.year, now.month, now.day + 9);
            //         print('Days: ' + ((after.difference(now).inHours/24).floor() % 7).toString());
            //         // MealsService mealService = new MealsService();
            //         // await mealService.setAllMeals();
            //         // var list = mealService.calculateMeal(165, 95, 45, 20, _user, 1);
            //         // //print(MealCategoryList.lunch[1].meals![1].fats);
            //         // print('--------------------');
            //         // for(var meal in list){
            //         //   print(meal.name!);
            //         //   print('Sections');
            //         //   for(var section in meal.sections!){
            //         //     print('name: ' + section.name!);
            //         //     for(var tempMeal in section.meals!){
            //         //       print('meal name: ' + tempMeal.name! + ', amount: ' + tempMeal.amount!.toString());
            //         //     }
            //         //   }
            //         //   print('--------------------');
            //         // }
            //         // var list = mealService.otherCalculateFullMealNumbers2(MealCategoryList.breakfast[0], 33, 19, 9,);
            //         // print('--------------------');
            //         // for(var meal in list!){
            //         //   print(meal.name! + ': ' + meal.amount!.toString());
            //         // }
            //       },
            //       icon: Icon(Icons.add),
            //       color: Colors.red,
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }

  void listenNotification1() {
    NotificationService.onNotifications.stream.listen((payload) {
      Navigator.pushNamed(context, MainRegisterScreen.id);
    });
  }

  void listenNotification2() {
    NotificationService.onNotifications.stream.listen((payload) {
      Navigator.pushNamed(context, RegisterScreens.id);
    });
  }

  void listenNotification3() {
    NotificationService.onNotifications.stream.listen((payload) {
      Navigator.pushNamed(context, PlansScreen.id);
    });
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 10);
    path.arcToPoint(
      Offset(size.width * 0.60, 10),
      radius: Radius.circular(20),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    // throw UnimplementedError();
  }
}
