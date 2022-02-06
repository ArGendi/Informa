import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/services/notification_service.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/custom_button.dart';

class SelectMealsTime extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectMealsTime({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectMealsTimeState createState() => _SelectMealsTimeState();
}

class _SelectMealsTimeState extends State<SelectMealsTime> {
  late DateTime _dateTime;
  int _selected = 0;

  void listenNotification() async{
    var initScreen = await HelpFunction.getInitScreen();
    NotificationService.onNotifications.stream.listen((payload) {
      Navigator.pushNamed(context, initScreen!);
    });
  }

  setNotifications(AppUser user) async{
    await NotificationService.init(initScheduled: true);
    listenNotification();

    for(int i=0; i<user.datesOfMeals.length; i++)
      NotificationService.showRepeatScheduledNotification(
        id: 300 + i,
        title: 'وجبة' + (i+1).toString() + ' 🍔',
        body: 'متبقي ساعة علي الوجبة قم بتحضرها الأن',
        payload: 'payload',
        date: user.datesOfMeals[i].hour,
      );
  }

  showPickTimeSheet(BuildContext context, int index){
    var datesOfMeals = Provider.of<ActiveUserProvider>(context, listen: false).user!.datesOfMeals;
    showModalBottomSheet(
      context: context,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'اختار وقت وجبة ' + (index+1).toString(),
                    style: TextStyle(
                      fontFamily: boldFont,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 180,
              child: CupertinoDatePicker(
                initialDateTime: datesOfMeals.length > index? datesOfMeals[index] : _dateTime,
                onDateTimeChanged: (datetime){
                  setState(() {
                    _dateTime = datetime;
                  });
                },
                mode: CupertinoDatePickerMode.time,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                text: 'تم',
                onClick: (){
                  Provider.of<ActiveUserProvider>(context, listen: false)
                      .addMealDateInIndex(_dateTime, index);
                  setState(() {_selected = 0;});
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  String convertDateTimeToString(date){
    String time = '';
    bool am = true;
    if(date.hour > 12){
      time += (date.hour - 12).toString() + ':';
      am = false;
    }
    else time += date.hour.toString() + ':';
    if(date.minute < 10)
      time += '0' + date.minute.toString();
    else time += date.minute.toString();
    if(am) time += ' ص';
    else time += ' م';
    return time;
  }

  onNext(AppUser user){
    if(user.numberOfMeals == user.datesOfMeals.length)
      setNotifications(user);
    widget.onClick();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: widget.onBack,
                        icon: Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(color: primaryColor),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/coach_face.jpg'),
                        )
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'مواعيد الوجبات',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      //fontFamily: boldFont,
                    ),
                  ),
                  Divider(
                    color: primaryColor,
                    indent: screenSize.width * .3,
                    endIndent: screenSize.width * .3,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'أضغط علي كل وجبة لتحديد معادها',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'لا يوجد اوقات محددة',
                    number: 10,
                    userChoice: _selected,
                    onClick: (){
                      setState(() {
                        _selected = 10;
                      });
                    },
                  ),
                  SizedBox(height: 5,),
                  Divider(
                    height: 10,
                  ),
                  for(int i=0; i<activeUser!.numberOfMeals; i++)
                  Column(
                    children: [
                      SizedBox(height: 5,),
                      ProgramSelectCard(
                        mainText: 'وجبة ' + (i+1).toString(),
                        subText: activeUser.datesOfMeals.length > i ?
                        convertDateTimeToString(activeUser.datesOfMeals[i]) : null,
                        number: i+1,
                        userChoice: 0,
                        onClick: (){
                          showPickTimeSheet(context, i);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.numberOfMeals == activeUser.datesOfMeals.length || _selected == 10? (){
              onNext(activeUser);
            } : (){},
            bgColor: activeUser.numberOfMeals == activeUser.datesOfMeals.length || _selected == 10? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
