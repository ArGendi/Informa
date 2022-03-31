import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/select_day_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/custom_button.dart';

class SelectTrainingDays extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectTrainingDays({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectTrainingDaysState createState() => _SelectTrainingDaysState();
}

class _SelectTrainingDaysState extends State<SelectTrainingDays> {
  late DateTime _dateTime;

  showPickTimeSheet(BuildContext context){
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
                    'اختار وقت التمرين',
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
                initialDateTime: _dateTime,
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
                text: 'التالي',
                onClick: (){
                  Provider.of<ActiveUserProvider>(context, listen: false)
                      .setTrainingTime(_dateTime);
                  Navigator.pop(context);
                  widget.onClick();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  goNext(BuildContext context, int trainingDays){
    if(trainingDays != 0)
      showPickTimeSheet(context);
    else widget.onClick();
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
                    'دلوقتي محتاجين نعرف ايام التمرين',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    color: Colors.grey[600],
                    indent: screenSize.width * .3,
                    endIndent: screenSize.width * .3,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'اختار عدد الايام وحدد الايام',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CairoBold'
                    ),
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setNumberOfTrainingDays(0);
                        },
                        child: CircleAvatar(
                          backgroundColor: activeUser!.iTrainingDays == 0 ? primaryColor : Colors.grey[300],
                          radius: 25,
                          child: Text(
                            '0',
                            style: TextStyle(
                                color: activeUser.iTrainingDays == 0 ? Colors.white : Colors.grey[700]
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setNumberOfTrainingDays(1);
                        },
                        child: CircleAvatar(
                          backgroundColor: activeUser.iTrainingDays == 1 ? primaryColor : Colors.grey[300],
                          radius: 25,
                          child: Text(
                            '1',
                            style: TextStyle(
                                color: activeUser.iTrainingDays == 1 ? Colors.white : Colors.grey[700]
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setNumberOfTrainingDays(2);
                        },
                        child: CircleAvatar(
                          backgroundColor: activeUser.iTrainingDays == 2 ? primaryColor : Colors.grey[300],
                          radius: 25,
                          child: Text(
                            '2',
                            style: TextStyle(
                                color: activeUser.iTrainingDays == 2 ? Colors.white : Colors.grey[700]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setNumberOfTrainingDays(3);
                        },
                        child: CircleAvatar(
                          backgroundColor: activeUser.iTrainingDays == 3 ? primaryColor : Colors.grey[300],
                          radius: 25,
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: activeUser.iTrainingDays == 3 ? Colors.white : Colors.grey[700]
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setNumberOfTrainingDays(4);
                        },
                        child: CircleAvatar(
                          backgroundColor: activeUser.iTrainingDays == 4 ? primaryColor : Colors.grey[300],
                          radius: 25,
                          child: Text(
                            '4',
                            style: TextStyle(
                                color: activeUser.iTrainingDays == 4 ? Colors.white : Colors.grey[700]
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setNumberOfTrainingDays(5);
                        },
                        child: CircleAvatar(
                          backgroundColor: activeUser.iTrainingDays == 5 ? primaryColor : Colors.grey[300],
                          radius: 25,
                          child: Text(
                            '5',
                            style: TextStyle(
                                color: activeUser.iTrainingDays == 5 ? Colors.white : Colors.grey[700]
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setNumberOfTrainingDays(6);
                        },
                        child: CircleAvatar(
                          backgroundColor: activeUser.iTrainingDays == 6 ? primaryColor : Colors.grey[300],
                          radius: 25,
                          child: Text(
                            '6',
                            style: TextStyle(
                                color: activeUser.iTrainingDays == 6 ? Colors.white : Colors.grey[700]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SelectDayCard(
                  //       text: 'السبت',
                  //       id: 1,
                  //     ),
                  //     SizedBox(width: 10,),
                  //     SelectDayCard(
                  //       text: 'الأحد',
                  //       id: 2,
                  //     ),
                  //     SizedBox(width: 10,),
                  //     SelectDayCard(
                  //       text: 'الأثنين',
                  //       id: 3,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SelectDayCard(
                  //       text: 'الثلاثاء',
                  //       id: 4,
                  //     ),
                  //     SizedBox(width: 10,),
                  //     SelectDayCard(
                  //       text: 'الأربع',
                  //       id: 5,
                  //     ),
                  //     SizedBox(width: 10,),
                  //     SelectDayCard(
                  //       text: 'الخميس',
                  //       id: 6,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10,),
                  // SelectDayCard(
                  //   text: 'الجمعة',
                  //   id: 7,
                  // ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.iTrainingDays != -1 ? (){
              goNext(context, activeUser.iTrainingDays);
            } : (){},
            bgColor: activeUser.iTrainingDays != -1? primaryColor : Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
