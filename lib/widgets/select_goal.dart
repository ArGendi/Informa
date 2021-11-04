import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'custom_button.dart';

class SelectGoal extends StatefulWidget {
  final VoidCallback onClick;
  const SelectGoal({Key? key, required this.onClick}) : super(key: key);

  @override
  _SelectGoalState createState() => _SelectGoalState();
}

class _SelectGoalState extends State<SelectGoal> {
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
                  // Text(
                  //   'أهلا',
                  //   style: TextStyle(
                  //       fontSize: 26,
                  //       color: primaryColor,
                  //       fontFamily: 'CairoBold'
                  //   ),
                  // ),
                  Image.asset(
                    'assets/images/ahlan.png',
                    width: 90,
                  ),
                  Text(
                    'دعنا نتعرف عليك أكثر',
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ),
                  Divider(
                    color: primaryColor,
                    indent: screenSize.width * .3,
                    endIndent: screenSize.width * .3,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'ما الهدف الذي تريد تحقيقه',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'CairoBold'
                    ),
                  ),
                  SizedBox(height: 20,),
                  ProgramSelectCard(
                    mainText: 'خسارة الوزن والدهون',
                    subText: 'مستعد التزم ببرنامج تمارين وتغذية مناسبين لهدفي',
                    number: 1,
                    userChoice: activeUser!.goal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setGoal(1);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'أكتساب كتلة عضلية',
                    subText: 'يهمني اخد برنامج نمارين مفصل علي روتيني واحتياجاتي',
                    number: 2,
                    userChoice: activeUser.goal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setGoal(2);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'زيادة اللياقة البدنية',
                    subText: 'معنديش وقت كتير للتمرين ومحتاج نظام غذائي مناسب',
                    number: 3,
                    userChoice: activeUser.goal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setGoal(3);
                    },
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.goal != 0 ? widget.onClick : (){},
            bgColor: activeUser.goal != 0 ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
