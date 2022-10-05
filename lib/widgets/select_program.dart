import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'custom_button.dart';

class SelectProgram extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectProgram({Key? key, required this.onClick, required this.onBack})
      : super(key: key);

  @override
  _SelectProgramState createState() => _SelectProgramState();
}

class _SelectProgramState extends State<SelectProgram> {
  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
                  SizedBox(
                    height: 20,
                  ),
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
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ما الشيء الذي تريد التركيز عليه اكتر',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontFamily: 'CairoBold'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ProgramSelectCard(
                    mainText: 'تمارين + تغذية',
                    subText: 'مستعد التزم ببرنامج تمارين وتغذية مناسبين لهدفي',
                    number: 1,
                    userChoice: activeUser!.program,
                    onClick: () {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setProgram(1);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProgramSelectCard(
                    mainText: 'تمارين',
                    subText:
                        'يهمني اخد برنامج نمارين مفصل علي روتيني واحتياجاتي',
                    number: 2,
                    userChoice: activeUser.program,
                    onClick: () {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setProgram(2);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProgramSelectCard(
                    mainText: 'نظام غذائي',
                    subText: 'معنديش وقت كتير للتمرين ومحتاج نظام غذائي مناسب',
                    number: 3,
                    userChoice: activeUser.program,
                    onClick: () {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setProgram(3);
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.program != 0 ? widget.onClick : () {},
            bgColor:
                activeUser.program != 0 ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
