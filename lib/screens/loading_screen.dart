import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:informa/constants.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/cardio.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/models/excercise.dart';
import 'package:informa/models/user.dart';
import 'package:informa/models/water.dart';
import 'package:informa/models/workout.dart';
import 'package:informa/models/workout_preset.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/app_language_provider.dart';
import 'package:informa/providers/challenges_provider.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/providers/water_provider.dart';
import 'package:informa/screens/auth_screens/register_screens.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/services/informa_service.dart';
import 'package:informa/services/meals_service.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  FirestoreService _firestoreService = new FirestoreService();
  InformaService _informaService = new InformaService();
  MealsService _mealsService = new MealsService();

  resetMacros(AppUser user) async {
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyCalories(user.myCalories!);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyProtein(user.myProtein!);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyCarb(user.myCarb!);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyFats(user.myFats!);
    if (user.dietType == 2) {
      DateTime now = DateTime.now();
      if (((now.difference(user.carbCycleStartDate!).inHours / 24).floor() %
              7) <
          4) {
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setDailyCarbCycle(user.lowAndHighCarb![0]);
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setCarbCycleIndex(0);
      } else {
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setDailyCarbCycle(user.lowAndHighCarb![1]);
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setCarbCycleIndex(1);
      }
    }
    double? myWater = await HelpFunction.getMyWater();
    if (myWater != null) HelpFunction.saveDailyWater(myWater);
  }

  getAppData() async {
    await FirestoreService().getPlans(context);
    await FirestoreService().getSupplements(context);
    String? lang = await HelpFunction.getUserLanguage();
    String? initScreen = await HelpFunction.getInitScreen();
    await _mealsService.setAllMeals();
    if (lang != null)
      Provider.of<AppLanguageProvider>(context, listen: false).changeLang(lang);
    if (initScreen != null) {
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // AppUser user = new AppUser();
        // await user.getFromSharedPreference();
        AppUser? user = await _firestoreService.getUserById(currentUser.uid);
        if (user != null) {
          Provider.of<ActiveUserProvider>(context, listen: false).setUser(user);
          if (user.premium) {
            AppUser premiumUser = user;

            double? myWater = await HelpFunction.getMyWater();
            double? dailyWater = await HelpFunction.getDailyWater();

            if (myWater != null && dailyWater != null) {
              Provider.of<ActiveUserProvider>(context, listen: false)
                  .setMyWater(myWater);
              Provider.of<ActiveUserProvider>(context, listen: false)
                  .setDailyWater(dailyWater);
            }

            if (premiumUser.premium && premiumUser.fillPremiumForm) {
              if (premiumUser.adminConfirm &&
                  (premiumUser.program == 2 || premiumUser.program == 3)) {
                bool update = await _firestoreService.checkAndUpdateNewDayData(
                    currentUser.uid, premiumUser);
                if (update) resetMacros(premiumUser);
              }
              if (premiumUser.dietType == 2) {
                DateTime now = DateTime.now();
                if (((now.difference(premiumUser.carbCycleStartDate!).inHours /
                                24)
                            .floor() %
                        7) <
                    4) {
                  Provider.of<ActiveUserProvider>(context, listen: false)
                      .setCarbCycleIndex(0);
                  if (premiumUser.dailyCarbCycle ==
                      premiumUser.lowAndHighCarb![1]) {
                    await _firestoreService.updateUserData(currentUser.uid, {
                      'dailyCarbCycle': premiumUser.lowAndHighCarb![0],
                    });
                    Provider.of<ActiveUserProvider>(context, listen: false)
                        .setDailyCarbCycle(premiumUser.lowAndHighCarb![0]);
                  }
                } else {
                  Provider.of<ActiveUserProvider>(context, listen: false)
                      .setCarbCycleIndex(1);
                  if (premiumUser.dailyCarbCycle ==
                      premiumUser.lowAndHighCarb![0]) {
                    await _firestoreService.updateUserData(currentUser.uid, {
                      'dailyCarbCycle': premiumUser.lowAndHighCarb![1],
                    });
                    Provider.of<ActiveUserProvider>(context, listen: false)
                        .setDailyCarbCycle(premiumUser.lowAndHighCarb![1]);
                  }
                }
              }
              List? nutrition = await _firestoreService.getNutritionMeals(
                  currentUser.uid, premiumUser);
              if (nutrition != null) {
                Provider.of<PremiumNutritionProvider>(context, listen: false)
                    .setBreakfast(nutrition[0]);
                Provider.of<PremiumNutritionProvider>(context, listen: false)
                    .setLunch(nutrition[1]);
                Provider.of<PremiumNutritionProvider>(context, listen: false)
                    .setLunch2(nutrition[1]);
                Provider.of<PremiumNutritionProvider>(context, listen: false)
                    .setDinner(nutrition[2]);
                Provider.of<PremiumNutritionProvider>(context, listen: false)
                    .setSnack(nutrition[3]);

                Provider.of<PremiumNutritionProvider>(context, listen: false)
                    .setBreakfastDone(nutrition[4]);
                Provider.of<PremiumNutritionProvider>(context, listen: false)
                    .setLunchDone(nutrition[5]);
                Provider.of<PremiumNutritionProvider>(context, listen: false)
                    .setLunch2Done(nutrition[6]);
                Provider.of<PremiumNutritionProvider>(context, listen: false)
                    .setDinnerDone(nutrition[7]);
                Provider.of<PremiumNutritionProvider>(context, listen: false)
                    .setSnackDone(nutrition[8]);

                List<int>? mainSnacksDone = nutrition[9].cast<int>();
                List<int>? supplementsDone = nutrition[10].cast<int>();
                List<String>? additionalMeals = nutrition[11].cast<String>();
                Provider.of<PremiumNutritionProvider>(context, listen: false)
                    .setMainSnacksDone(mainSnacksDone);
                Provider.of<PremiumNutritionProvider>(context, listen: false)
                    .setSupplementsDone(supplementsDone);
                if (additionalMeals != null)
                  Provider.of<PremiumNutritionProvider>(context, listen: false)
                      .setAdditionalMeals(additionalMeals);
              }
              if (premiumUser.workoutPreset != null) {
                List<Exercise> exercises =
                    await _firestoreService.getExercises();
                exercises.map((e) => print('${e.id} \n'));
                List<Workout> workouts =
                    await _firestoreService.getWorkouts(exercises);
                List<Cardio> cardio =
                    await _firestoreService.getCardio(exercises);
                WorkoutPreset? workoutPreset =
                    await _firestoreService.getWorkoutPresetById(
                        premiumUser.workoutPreset!, workouts, cardio);
                if (workoutPreset != null)
                  Provider.of<ActiveUserProvider>(context, listen: false)
                      .setWorkoutPreset(workoutPreset);
              }
            }
          }
          // else {
          //   AppUser nonPremiumUser = new AppUser();
          //   await nonPremiumUser.getFromSharedPreference();
          //   Provider.of<ActiveUserProvider>(context, listen: false)
          //       .setUser(nonPremiumUser);
          // }
          //get challenges
          if (mounted) {
            List<Challenge> challenges =
                await _firestoreService.getAllChallenges();
            Provider.of<ChallengesProvider>(context, listen: false)
                .setChallenges(challenges);
            //get water settings
            Water water = new Water();
            await water.getFromSharedPreference();
            Provider.of<WaterProvider>(context, listen: false).setWater(water);
          }
        } else
          Navigator.pushReplacementNamed(context, RegisterScreens.id);
      }
      if (initScreen == MainScreen.id && currentUser == null)
        Navigator.pushReplacementNamed(context, RegisterScreens.id);
      else
        Navigator.pushReplacementNamed(context, initScreen);
    } else
      Navigator.pushReplacementNamed(context, RegisterScreens.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (this.mounted) {
      getAppData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png'))),
        child: Center(
          child: SpinKitFoldingCube(
            color: primaryColor,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
