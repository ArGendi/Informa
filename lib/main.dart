import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:informa/app_localization.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/app_language_provider.dart';
import 'package:informa/providers/google_auth_provider.dart';
import 'package:informa/screens/main_register_screen.dart';
import 'package:informa/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'helpers/shared_preference.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String? lang = await HelpFunction.getUserLanguage();
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
        scaffoldBackgroundColor: Color(0xffededed),
        fontFamily: 'Cairo',
        appBarTheme: AppBarTheme(
          color: primaryColor,
        ),
      ),
      home: MainRegisterScreen(),
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