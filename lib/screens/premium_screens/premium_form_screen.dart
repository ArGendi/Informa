import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/screens/pageview_screens/dont_know_goal.dart';
import 'package:informa/screens/pageview_screens/enter_fats_percent.dart';
import 'package:informa/screens/pageview_screens/premium_fat_percent.dart';
import 'package:informa/screens/pageview_screens/select_disease.dart';
import 'package:informa/screens/pageview_screens/select_fat_percent.dart';
import 'package:informa/screens/pageview_screens/select_goal.dart';
import 'package:informa/screens/pageview_screens/select_level.dart';
import 'package:informa/screens/pageview_screens/select_meals_per_day.dart';
import 'package:informa/screens/pageview_screens/select_meals_time.dart';
import 'package:informa/screens/pageview_screens/select_milk_products_problems.dart';
import 'package:informa/screens/pageview_screens/select_supplements.dart';
import 'package:informa/screens/pageview_screens/select_which_two_meals.dart';
import 'package:informa/screens/pageview_screens/upload_body_photos.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/services/informa_service.dart';
import 'package:informa/services/meals_service.dart';
import 'package:informa/services/notification_service.dart';
import 'package:informa/widgets/select_tools.dart';
import 'package:informa/screens/pageview_screens/select_training_days.dart';
import 'package:informa/screens/pageview_screens/select_unwanted_meals.dart';
import 'package:provider/provider.dart';

class PremiumFormScreen extends StatefulWidget {
  static String id = 'premium form';
  const PremiumFormScreen({Key? key}) : super(key: key);

  @override
  _PremiumFormScreenState createState() => _PremiumFormScreenState();
}

class _PremiumFormScreenState extends State<PremiumFormScreen> {
  int _initialPage = 0;
  late final PageController _controller;
  bool _showFatsImagesPage = false;
  bool _isLoading = false;
  bool _selectFromPhotos = false;
  bool _unknownGoal = false;
  InformaService _informaService = new InformaService();
  MealsService _mealsService = new MealsService();

  goToNextPage(){
    _controller.animateToPage(
        _initialPage + 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut
    );
    setState(() {
      _initialPage += 1;
    });
  }

  Future goBack() async{
    await _controller.animateToPage(
        _initialPage - 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut
    );
    setState(() {
      _initialPage -= 1;
    });
  }

  void listenNotification() {
    NotificationService.onNotifications.stream.listen((payload) {
      Navigator.pushNamed(context, MainScreen.id);
    });
  }

  createNotification() async{
    DateTime now = DateTime.now();
    await NotificationService.init(initScheduled: true);
    listenNotification();
    await NotificationService.showScheduledNotification(
      id: 55,
      title: 'برنامجك الخاص جاهز 🎉🎉',
      body: 'يلا يا بطل أدخل دلوقتي شوف برنامجك جاهز 👌',
      payload: 'payload',
      scheduledDate: DateTime(now.year, now.month, now.day, now.hour+72),
    );
  }

  onDone(BuildContext context) async{
    String? id = FirebaseAuth.instance.currentUser!.uid;
    Provider.of<ActiveUserProvider>(context, listen: false).premiumFormFilled();
    Provider.of<ActiveUserProvider>(context, listen: false).removeAllUnwantedMeals();
    var activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
    _informaService.setUser(activeUser!);
    setState(() {_isLoading = true;});
    await NotificationService.cancelNotification(10);
    DateTime now = DateTime.now();
    var after3days = DateTime(now.year, now.month, now.day, now.hour+72);
    DateTime threeAmToday = DateTime(now.year, now.month, now.day, 3);
    activeUser.premiumStartDate = after3days;
    activeUser.lastDataUpdatedDate = threeAmToday;
    FirestoreService firestoreService = new FirestoreService();
    mainMealFunction(activeUser);

    //Water calculation
    Provider.of<ActiveUserProvider>(context, listen: false).setMyWater(activeUser.weight * 0.045);
    Provider.of<ActiveUserProvider>(context, listen: false).setDailyWater(activeUser.weight * 0.045);

    var activeUserAfterUpdate = Provider.of<ActiveUserProvider>(context, listen: false).user;
    var map = activeUserAfterUpdate!.toJson();
    await firestoreService.updateUserData(id, map);
    var premiumNutritionProvider = Provider.of<PremiumNutritionProvider>(context, listen: false);
    await firestoreService.saveNutritionMeals(
        id,
        premiumNutritionProvider.breakfast,
        premiumNutritionProvider.lunch,
        premiumNutritionProvider.dinner,
        premiumNutritionProvider.snacks,
        premiumNutritionProvider.breakfastDone,
        premiumNutritionProvider.lunchDone,
        premiumNutritionProvider.lunch2Done,
        premiumNutritionProvider.dinnerDone,
        premiumNutritionProvider.snackDone,
    );
    setState(() {_isLoading = false;});
  }


  List<int> getCaloriesProteinCarbFats(){
    int calories = _informaService.calculateNeededCalories();
    int protein = _informaService.calculateProteinNeeded();
    int fats = _informaService.calculateFatsNeeded(calories);
    int carb = _informaService.calculateCarbNeeded(calories, protein, fats);

    Provider.of<ActiveUserProvider>(context, listen: false).setMyCalories(calories);
    Provider.of<ActiveUserProvider>(context, listen: false).setDailyCalories(calories);
    Provider.of<ActiveUserProvider>(context, listen: false).setMyProtein(protein);
    Provider.of<ActiveUserProvider>(context, listen: false).setDailyProtein(protein);
    Provider.of<ActiveUserProvider>(context, listen: false).setMyCarb(carb);
    Provider.of<ActiveUserProvider>(context, listen: false).setDailyCarb(carb);
    Provider.of<ActiveUserProvider>(context, listen: false).setMyFats(fats);
    Provider.of<ActiveUserProvider>(context, listen: false).setDailyFats(fats);
    return [protein, carb, fats];
  }

  List<int> getSnacks(AppUser user, int protein, int carb, int fats){
    List<dynamic> snacksWithInfo = _mealsService.calculateSnacks(user, protein, carb);
    Map<Meal, int> snacks = snacksWithInfo[0];
    List<double> info = snacksWithInfo[1];
    Provider.of<PremiumNutritionProvider>(context, listen: false).setSnack(true);
    return [(protein - info[0]).toInt(), (carb - info[1]).toInt(), (fats - info[2]).toInt()];
  }

  mainMealFunction(AppUser user) async{
    List<int> info = getCaloriesProteinCarbFats();
    List<int> infoAfterSnacks = getSnacks(user, info[0], info[1], info[2]);

    if(user.numberOfMeals == 2){
      if(user.whichTwoMeals == 1) {
        //breakfast
        List<FullMeal> breakfast
          = _mealsService.calculateBreakfast(infoAfterSnacks[0], infoAfterSnacks[1], infoAfterSnacks[2], 35, user);
        Provider.of<PremiumNutritionProvider>(context, listen: false).setBreakfast(breakfast);
        //lunch
        List<FullMeal> lunch
          = _mealsService.calculateLunch(infoAfterSnacks[0], infoAfterSnacks[1], infoAfterSnacks[2], 65, user);
        Provider.of<PremiumNutritionProvider>(context, listen: false).setLunch(lunch);
      }
      else if(user.whichTwoMeals == 2){
        //lunch
        List<FullMeal> lunch
          = _mealsService.calculateLunch(infoAfterSnacks[0], infoAfterSnacks[1], infoAfterSnacks[2], 65, user);
        Provider.of<PremiumNutritionProvider>(context, listen: false).setLunch(lunch);
        //dinner
        List<FullMeal> dinner
          = _mealsService.calculateDinner(infoAfterSnacks[0], infoAfterSnacks[1], infoAfterSnacks[2], 35, user);
        Provider.of<PremiumNutritionProvider>(context, listen: false).setDinner(dinner);
      }
    }
    else if(user.numberOfMeals == 3) {
      print('Protein: ' + infoAfterSnacks[0].toString());
      print('Carb: ' + infoAfterSnacks[1].toString());
      print('Fat: ' + infoAfterSnacks[2].toString());
      //breakfast
      List<FullMeal> breakfast
      = _mealsService.calculateBreakfast(infoAfterSnacks[0], infoAfterSnacks[1], infoAfterSnacks[2], 20, user);
      Provider.of<PremiumNutritionProvider>(context, listen: false).setBreakfast(breakfast);
      //lunch
      List<FullMeal> lunch
      = _mealsService.calculateLunch(infoAfterSnacks[0], infoAfterSnacks[1], infoAfterSnacks[2], 55, user);
      Provider.of<PremiumNutritionProvider>(context, listen: false).setLunch(lunch);
      //dinner
      List<FullMeal> dinner
      = _mealsService.calculateDinner(infoAfterSnacks[0], infoAfterSnacks[1], infoAfterSnacks[2], 25, user);
      Provider.of<PremiumNutritionProvider>(context, listen: false).setDinner(dinner);
    }
    else if(user.numberOfMeals == 4) {
      //breakfast
      List<FullMeal> breakfast
        = _mealsService.calculateBreakfast(infoAfterSnacks[0], infoAfterSnacks[1], infoAfterSnacks[2], 20, user);
      Provider.of<PremiumNutritionProvider>(context, listen: false).setBreakfast(breakfast);
      //lunch 1
      List<FullMeal> lunch
        = _mealsService.calculateLunch(infoAfterSnacks[0], infoAfterSnacks[1], infoAfterSnacks[2], 30, user);
      Provider.of<PremiumNutritionProvider>(context, listen: false).setLunch(lunch);
      //lunch 2
      Provider.of<PremiumNutritionProvider>(context, listen: false).setLunch2(lunch);
      //dinner
      List<FullMeal> dinner
        = _mealsService.calculateDinner(infoAfterSnacks[0], infoAfterSnacks[1], infoAfterSnacks[2], 20, user);
      Provider.of<PremiumNutritionProvider>(context, listen: false).setDinner(dinner);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: SafeArea(
          child: PageView(
            physics:new NeverScrollableScrollPhysics(),
            controller: _controller,
            children: [
              PremiumFatPercent(
                onBack: (){
                  Navigator.pop(context);
                },
                goToFatsImages: (){
                  setState(() {
                    _showFatsImagesPage = true;
                  });
                  goToNextPage();
                },
                onNext: (){
                  setState(() {
                    _showFatsImagesPage = false;
                  });
                  goToNextPage();
                },
                selectFromPhotos: _selectFromPhotos,
              ),
              if(_showFatsImagesPage)
                SelectFatPercent(
                  onBack: goBack,
                  onNext: () async{
                    await goBack();
                    setState(() {
                      _showFatsImagesPage = false;
                      _selectFromPhotos = true;
                    });
                  },
                ),
              // if(activeUser!.gender == 1)
              //   UploadBodyPhotos(
              //     onBack: goBack,
              //     onClick: goToNextPage,
              //   ),
              SelectGoal(
                onBack: goBack,
                onClick: goToNextPage,
                unknownGoal: (value){
                  _unknownGoal = value;
                },
              ),
              if(_unknownGoal)
                DoNotKnowGoal(
                  onBack: goBack,
                  onClick: goToNextPage,
                ),
              SelectLevel(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectTrainingDays(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectSupplements(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectMealsPerDay(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              if(activeUser!.numberOfMeals == 2)
                SelectWhichTwoMeals(
                  onBack: goBack,
                  onClick: goToNextPage,
                ),
              SelectMealsTime(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectMilkProductsProblems(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectUnWantedMeals(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectDisease(
                onBack: goBack,
                onClick: (){
                  onDone(context);
                },
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
