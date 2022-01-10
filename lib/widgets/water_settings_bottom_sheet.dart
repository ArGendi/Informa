import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/water.dart';
import 'package:informa/providers/water_provider.dart';
import 'package:informa/screens/auth_screens/main_register_screen.dart';
import 'package:informa/services/notification_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';
import '../constants.dart';

class WaterSettingsBottomSheet extends StatefulWidget {
  final Water water;
  const WaterSettingsBottomSheet({Key? key, required this.water}) : super(key: key);

  @override
  _WaterSettingsBottomSheetState createState() => _WaterSettingsBottomSheetState(water);
}

class _WaterSettingsBottomSheetState extends State<WaterSettingsBottomSheet> {
  late bool _isActivated;
  late int _numberOfRemind;

  _WaterSettingsBottomSheetState(Water water){
    _isActivated = water.isActivated;
    _numberOfRemind = water.numberOfTimes;
  }

  onSubmit(BuildContext context) async{
    Provider.of<WaterProvider>(context, listen: false).setStatus(_isActivated);
    Provider.of<WaterProvider>(context, listen: false).setNumberOfTimes(_numberOfRemind);
    await NotificationService.init(initScheduled: true);
    listenNotification();

    int? prev = await HelpFunction.getUserWaterNumberOfTimes();
    //close all notifications
    if(!_isActivated && prev != null){
      for(int i=prev-1; i>=0; i--){
        await NotificationService.cancelNotification(i);
      }
    }

    //deleting un-needed notifications if exist
    if(_isActivated && prev != null && prev > _numberOfRemind){
      for(int i=prev-1; i>=_numberOfRemind; i--){
        await NotificationService.cancelNotification(i);
      }
    }

    //create notifications
    if(_isActivated)
      for(int i=0; i<_numberOfRemind; i++){
        if(i == 0)
          NotificationService.showRepeatScheduledNotification(
            id: i,
            title: 'أشرب الماء 🥤',
            body: 'صباح الخير 😇, ابدأ يومك بكوب ماء',
            payload: 'payload',
            date: 10 + (i * 4),
          );
        else if(i == 1)
          NotificationService.showRepeatScheduledNotification(
            id: i,
            title: 'أشرب الماء 🥤',
            body: 'حبينا نفكرك بشرب المياة 💪🏻',
            payload: 'payload',
            date: 10 + (i * 4),
          );
        else if(i == 2)
          NotificationService.showRepeatScheduledNotification(
            id: i,
            title: 'أشرب الماء 🥤',
            body: 'أشرب مياة اكتر عشان تحسن جسمك 💪🏻',
            payload: 'payload',
            date: 10 + (i * 4),
          );
        else if(i == 3)
          NotificationService.showRepeatScheduledNotification(
            id: i,
            title: 'أشرب الماء 🥤',
            body: 'المياة قبل النوم مفيدة. تصبح علي خير 😇',
            payload: 'payload',
            date: 10 + (i * 4),
          );
      }
    await HelpFunction.saveUserWaterIsActivated(_isActivated);
    await HelpFunction.saveUserWaterNumberOfTimes(_numberOfRemind);
    Navigator.pop(context);
  }

  void listenNotification() async{
    var initScreen = await HelpFunction.getInitScreen();
    NotificationService.onNotifications.stream.listen((payload) {
      Navigator.pushNamed(context, initScreen!);
    });
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(borderRadius),
              topLeft: Radius.circular(borderRadius),
            ),
          ),
          child: Center(
            child: Text(
              localization!.translate('أعدادات الماء').toString(),
              style: TextStyle(
                fontFamily: 'CairoBold',
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.translate('التذكير بشرب الماء').toString(),
                    style: TextStyle(),
                  ),
                  CupertinoSwitch(
                    activeColor: primaryColor,
                    value: _isActivated,
                    onChanged: (bool value) { setState(() { _isActivated = value; }); },
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization.translate('عدد مرات التذكير بالماء').toString(),
                    style: TextStyle(),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap:(){
                            if(_isActivated)
                              setState(() {
                                _numberOfRemind = 1;
                              });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _isActivated && _numberOfRemind == 1 ?
                                        primaryColor : Colors.grey[200],
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Center(
                                child: Text(
                                  localization.translate('مرة واحدة').toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: _isActivated && _numberOfRemind == 1 ?
                                              Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        child: InkWell(
                          onTap:(){
                            if(_isActivated)
                              setState(() {
                                _numberOfRemind = 2;
                              });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _isActivated && _numberOfRemind == 2 ?
                              primaryColor : Colors.grey[200],
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Center(
                                child: Text(
                                  localization.translate('مرتين').toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                    color: _isActivated && _numberOfRemind == 2 ?
                                          Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap:(){
                            if(_isActivated)
                              setState(() {
                                _numberOfRemind = 3;
                              });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _isActivated && _numberOfRemind == 3 ?
                              primaryColor : Colors.grey[200],
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Center(
                                child: Text(
                                  localization.translate('ثلاث مرات').toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                    color: _isActivated && _numberOfRemind == 3 ?
                                        Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        child: InkWell(
                          onTap:(){
                            if(_isActivated)
                              setState(() {
                                _numberOfRemind = 4;
                              });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _isActivated && _numberOfRemind == 4 ?
                              primaryColor : Colors.grey[200],
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Center(
                                child: Text(
                                  localization.translate('أربع مرات').toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                    color: _isActivated && _numberOfRemind == 4 ?
                                    Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomButton(
            text: localization.translate('حفظ الأعدادات').toString(),
            onClick: () async{
              onSubmit(context);
            },
          ),
        )
      ],
    );
  }
}
