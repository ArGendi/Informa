import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/user.dart';
import 'package:informa/models/water.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/app_language_provider.dart';
import 'package:informa/providers/water_provider.dart';
import 'package:informa/screens/edit_profile_screen.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/widgets/lang_bottom_sheet.dart';
import 'package:informa/widgets/setting_card.dart';
import 'package:informa/widgets/water_settings_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'main_register_screen.dart';

class SettingsScreen extends StatefulWidget {
  static String id = 'settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  showLanguageBottomSheet(String lang){
    showModalBottomSheet(
      context: context,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      builder: (BuildContext context) {
        return LangBottomSheet(
          lang: lang,
        );
      },
    );
  }

  showWaterSettingsBottomSheet(Water water){
    showModalBottomSheet(
      context: context,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      builder: (BuildContext context) {
        return WaterSettingsBottomSheet(
          water: water,
        );
      },
    );
  }

  logout(BuildContext context) async{
    print(FirebaseAuth.instance.currentUser!.email);
    await HelpFunction.saveInitScreen(MainRegisterScreen.id);
    await FirebaseAuth.instance.signOut();
    Provider.of<ActiveUserProvider>(context, listen: false).initializeUser();
    Provider.of<AppLanguageProvider>(context, listen: false).initializeLang();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(MainRegisterScreen.id, (Route<dynamic> route) => false);
  }

  subscriptionPlan(BuildContext context){
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    if(!activeUser!.premium)
      Navigator.pushNamed(context, PlansScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var lang = Provider.of<AppLanguageProvider>(context).lang;
    var water = Provider.of<WaterProvider>(context).water;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('أعدادات'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Text(
                'المعلومات الشخصية',
                style: TextStyle(
                  fontFamily: 'CairoBold',
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SettingCard(
                        icon: Icons.person,
                        text: 'البيانات الشخصية',
                        onClick: (){
                          Navigator.pushNamed(context, EditProfileScreen.id);
                        },
                      ),
                      Divider(
                        height: 20,
                      ),
                      SettingCard(
                        icon: Icons.water,
                        text: 'أعدادات الماء',
                        onClick: (){
                          showWaterSettingsBottomSheet(water);
                        }
                      ),
                      Divider(
                        height: 20,
                      ),
                      SettingCard(
                        icon: Icons.notifications,
                        text: 'الأشعارات والتنبيهات',
                        onClick: (){},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'الأشتراكات',
                style: TextStyle(
                  fontFamily: 'CairoBold',
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SettingCard(
                        icon: Icons.payment,
                        iconColor: primaryColor,
                        text: 'خطة الاشتراك',
                        onClick: (){
                          subscriptionPlan(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'الأعدادات العامة',
                style: TextStyle(
                  fontFamily: 'CairoBold',
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SettingCard(
                        icon: Icons.language,
                        text: 'لغة التطبيق',
                        onClick: (){
                          showLanguageBottomSheet(lang);
                        },
                      ),
                      Divider(
                        height: 20,
                      ),
                      SettingCard(
                        icon: Icons.call,
                        text: 'تواصل مع الدعم',
                        onClick: (){},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SettingCard(
                        icon: Icons.exit_to_app,
                        iconColor: Colors.red,
                        text: 'تسجيل الخروج',
                        onClick: (){
                          logout(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}