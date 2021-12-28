import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:informa/app_localization.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/models/workout.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/app_language_provider.dart';
import 'package:informa/providers/challenges_provider.dart';
import 'package:informa/providers/google_auth_provider.dart';
import 'package:informa/providers/kitchen_provider.dart';
import 'package:informa/providers/recently_viewed_meals_provider.dart';
import 'package:informa/providers/water_provider.dart';
import 'package:informa/screens/challenges_screen.dart';
import 'package:informa/screens/single_meal_screen.dart';
import 'package:informa/screens/dummy.dart';
import 'package:informa/screens/edit_profile_screen.dart';
import 'package:informa/screens/email_confirmation_screen.dart';
import 'package:informa/screens/forget_password_screen.dart';
import 'package:informa/screens/free_kitchen_screen.dart';
import 'package:informa/screens/free_workout_screen.dart';
import 'package:informa/screens/home_screen.dart';
import 'package:informa/screens/loading_screen.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/screens/login_screen.dart';
import 'package:informa/screens/main_register_screen.dart';
import 'package:informa/screens/meal_category_screen.dart';
import 'package:informa/screens/more_user_info_screen.dart';
import 'package:informa/screens/muscle_selection_screen.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/screens/prepare_program_screen.dart';
import 'package:informa/screens/profile_screen.dart';
import 'package:informa/screens/register_screens.dart';
import 'package:informa/screens/reset_password_screen.dart';
import 'package:informa/screens/settings_screen.dart';
import 'package:informa/screens/single_workout_screen.dart';
import 'package:informa/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'helpers/shared_preference.dart';
import 'loading_screens/challenges_loading_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GoogleSignInProvider>(
          create: (context) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider<AppLanguageProvider>(
          create: (context) => AppLanguageProvider(),
        ),
        ChangeNotifierProvider<ActiveUserProvider>(
          create: (context) => ActiveUserProvider(),
        ),
        ChangeNotifierProvider<RecentlyViewedMealsProvider>(
          create: (context) => RecentlyViewedMealsProvider(),
        ),
        ChangeNotifierProvider<KitchenProvider>(
          create: (context) => KitchenProvider(),
        ),
        ChangeNotifierProvider<WaterProvider>(
          create: (context) => WaterProvider(),
        ),
        ChangeNotifierProvider<ChallengesProvider>(
          create: (context) => ChallengesProvider(),
        ),
      ],
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Informa',
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        fontFamily: 'Cairo',
        appBarTheme: AppBarTheme(
          color: primaryColor,
        ),
      ),
      home: RegisterScreens(),
      routes: {
        MainRegisterScreen.id: (context) => MainRegisterScreen(),
        ResetPasswordScreen.id: (context) => ResetPasswordScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        MainScreen.id: (context) => MainScreen(),
        FreeKitchenScreen.id: (context) => FreeKitchenScreen(),
        ForgetPasswordScreen.id: (context) => ForgetPasswordScreen(),
        //DetailedMealScreen.id: (context) => DetailedMealScreen(),
        //FreeWorkoutScreen.id: (context) => FreeWorkoutScreen(),
        MuscleSelectionScreen.id: (context) => MuscleSelectionScreen(),
        PlansScreen.id: (context) => PlansScreen(),
        PrepareProgramScreen.id: (context) => PrepareProgramScreen(),
        MoreUserInfoScreen.id: (context) => MoreUserInfoScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        RegisterScreens.id: (context) => RegisterScreens(),
        EditProfileScreen.id: (context) => EditProfileScreen(),
        ChallengesScreen.id: (context) => ChallengesScreen(),
        ChallengesLoadingScreen.id: (context) => ChallengesLoadingScreen(),
        MealCategoryScreen.id: (context) => MealCategoryScreen(),
        //EmailConfirmationScreen.id: (context) => EmailConfirmationScreen(),
      },
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales){
        for(var supportedLocale in supportedLocales){
          if(supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode)
            return supportedLocale;
        }
        return supportedLocales.first;
      },
      locale: Locale(appLanguageProvider.lang, ''),
    );
  }
}