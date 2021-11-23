import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'custom_button.dart';

class SelectTrainingPeriod extends StatefulWidget {
  final VoidCallback onClick;
  const SelectTrainingPeriod({Key? key, required this.onClick}) : super(key: key);

  @override
  _SelectTrainingPeriodState createState() => _SelectTrainingPeriodState();
}

class _SelectTrainingPeriodState extends State<SelectTrainingPeriod> {
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
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 40,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'محتاج اعرف وقت التمرين',
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
                    'اختار مدة التمرين الأنسب ليك',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CairoBold'
                    ),
                  ),
                  SizedBox(height: 25,),
                  ProgramSelectCard(
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setTrainingPeriodLevel(1);
                    },
                    mainText: 'طويلة',
                    subText: 'أكتر من ساعة',
                    number: 1,
                    userChoice: activeUser!.trainingPeriodLevel,
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setTrainingPeriodLevel(2);
                    },
                    mainText: 'متوسط',
                    subText: 'أقل من ساعة',
                    number: 2,
                    userChoice: activeUser.trainingPeriodLevel,
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setTrainingPeriodLevel(3);
                    },
                    mainText: 'قصيرة',
                    subText: 'حوالي نص ساعة',
                    number: 3,
                    userChoice: activeUser.trainingPeriodLevel,
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.trainingPeriodLevel != 0 ? widget.onClick : (){},
            bgColor: activeUser.trainingPeriodLevel != 0 ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
