import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
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
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
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
                  for(int i=0; i<activeUser!.numberOfMeals; i++)
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      ProgramSelectCard(
                        mainText: 'وجبة ' + (i+1).toString(),
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
            onClick: activeUser.numberOfMeals == activeUser.datesOfMeals.length? widget.onClick : (){},
            bgColor: activeUser.numberOfMeals == activeUser.datesOfMeals.length? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
