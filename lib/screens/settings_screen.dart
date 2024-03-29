import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/app_localization.dart';
import 'package:informa/constants.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/water.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/app_language_provider.dart';
import 'package:informa/providers/water_provider.dart';
import 'package:informa/screens/auth_screens/register_screens.dart';
import 'package:informa/screens/edit_profile_screen.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/widgets/lang_bottom_sheet.dart';
import 'package:informa/widgets/setting_card.dart';
import 'package:informa/widgets/water_settings_bottom_sheet.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  static String id = 'settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  showLanguageBottomSheet(String lang) {
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

  showWaterSettingsBottomSheet(Water water) {
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

  logout(BuildContext context) async {
    print(FirebaseAuth.instance.currentUser!.email);
    await HelpFunction.saveInitScreen(RegisterScreens.id);
    FirebaseAuth.instance.signOut();
    Provider.of<ActiveUserProvider>(context, listen: false).initializeUser();
    Provider.of<AppLanguageProvider>(context, listen: false).initializeLang();
    Navigator.of(context).pushNamedAndRemoveUntil(
        RegisterScreens.id, (Route<dynamic> route) => false);
  }

  subscriptionPlan(BuildContext context) {
    var activeUser =
        Provider.of<ActiveUserProvider>(context, listen: false).user;
    if (!activeUser!.premium) Navigator.pushNamed(context, PlansScreen.id);
    // if (activeUser.premium) {
    //   // show bottom dialog that contains the end date of subscription and the type of the subscription
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text(
    //           'subscription_end_date',
    //           style: TextStyle(
    //             fontSize: 14,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         content: Text(
    //           'subscription_end_date_content',
    //           style: TextStyle(
    //             fontSize: 14,
    //           ),
    //         ),
    //         actions: <Widget>[
    //           FlatButton(
    //             child: Text(
    //               'ok',
    //               style: TextStyle(
    //                 fontSize: 14,
    //               ),
    //             ),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    var lang = Provider.of<AppLanguageProvider>(context).lang;
    var water = Provider.of<WaterProvider>(context).water;
    var localization = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(localization!.translate('أعدادات').toString()),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png'))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Text(
                localization.translate('المعلومات الشخصية').toString(),
                style: TextStyle(
                  fontFamily: 'CairoBold',
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                        text: localization
                            .translate('البيانات الشخصية')
                            .toString(),
                        onClick: () {
                          Navigator.pushNamed(context, EditProfileScreen.id);
                        },
                      ),
                      Divider(
                        height: 20,
                      ),
                      SettingCard(
                          icon: Icons.water,
                          text: localization
                              .translate('أعدادات الماء')
                              .toString(),
                          onClick: () {
                            showWaterSettingsBottomSheet(water);
                          }),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                localization.translate('الأشتراكات').toString(),
                style: TextStyle(
                  fontFamily: 'CairoBold',
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                        text: localization.translate('خطة الاشتراك').toString(),
                        onClick: () {
                          subscriptionPlan(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                localization.translate('الأعدادات العامة').toString(),
                style: TextStyle(
                  fontFamily: 'CairoBold',
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                        text: localization.translate('لغة التطبيق').toString(),
                        onClick: () {
                          showLanguageBottomSheet(lang);
                        },
                      ),
                      Divider(
                        height: 20,
                      ),
                      activeUser!.package == 2 && activeUser.premium ||
                              activeUser.package == 3 && activeUser.premium
                          ? SettingCard(
                              icon: Icons.whatsapp,
                              text: localization
                                  .translate('تواصل مع  كابتن المتابعة ')
                                  .toString(),
                              onClick: () {},
                            )
                          : Container(),
                      SettingCard(
                        icon: Icons.whatsapp,
                        text: localization
                            .translate(activeUser.premium
                                ? 'تواصل مع خدمة العملاء'
                                : 'تواصل مع فريق المبيعات')
                            .toString(),
                        onClick: () {},
                      ),
                      activeUser.package == 3 && activeUser.premium
                          ? SettingCard(
                              icon: Icons.whatsapp,
                              text: localization
                                  .translate('تواصل مع كابتن حسين ')
                                  .toString(),
                              onClick: () {},
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
                        text: localization.translate('تسجيل الخروج').toString(),
                        onClick: () {
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
