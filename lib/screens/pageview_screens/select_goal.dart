import 'package:flutter/material.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SelectGoal extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  final Function(bool)? unknownGoal;
  const SelectGoal(
      {Key? key, required this.onClick, required this.onBack, this.unknownGoal})
      : super(key: key);

  @override
  _SelectGoalState createState() => _SelectGoalState();
}

class _SelectGoalState extends State<SelectGoal> {
  // String _goalDescription = '';
  // var _formKey = GlobalKey<FormState>();
  final ScrollController _controller = ScrollController();

  // void _scrollDown() {
  //   _controller.animateTo(
  //     _controller.position.maxScrollExtent,
  //     duration: Duration(milliseconds: 500),
  //     curve: Curves.fastOutSlowIn,
  //   );
  // }

  onNext(BuildContext context, AppUser user) {
    if (user.goal == 4 || user.goal == 5)
      Provider.of<ActiveUserProvider>(context, listen: false).setDietType(1);
    if (user.goal == 6)
      widget.unknownGoal!(true);
    else
      widget.unknownGoal!(false);
    widget.onClick();
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
              controller: _controller,
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
                    height: 10,
                  ),
                  Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(color: primaryColor),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/coach_face.jpg'),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'ما الهدف الذي تريد تحقيقه',
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'أختار هدف',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProgramSelectCard(
                    mainText: 'خسارة وزن كبير',
                    subText: 'عايز أخس اكتر وزن ممكن أنزله في أسرع وقت',
                    number: 1,
                    userChoice: activeUser!.goal,
                    onClick: () {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setGoal(1);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProgramSelectCard(
                    mainText: 'خسارة دهون بمعدل طبيعي',
                    subText:
                        'عايز أخس دهون بالمعدل الطبيعي والصحي واحاول اخلي خسارة العضلات قليلة',
                    number: 2,
                    userChoice: activeUser.goal,
                    onClick: () {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setGoal(2);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProgramSelectCard(
                    mainText: 'ثبات في الوزن وخسارة بسيطة دهون',
                    subText:
                        'عايز وزني يبقا ثابت وأحاول انقص شوية دهون قليلة وأثبت او ازيد عضل بسيط',
                    number: 3,
                    userChoice: activeUser.goal,
                    onClick: () {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setGoal(3);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProgramSelectCard(
                    mainText: 'زيادة عضل مع دهون بسيطة',
                    subText:
                        'عايز ازود وزني شوية ومعظم الزيادة عضل وزيادة الدهون تكون بسيطة',
                    number: 4,
                    userChoice: activeUser.goal,
                    onClick: () {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setGoal(4);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProgramSelectCard(
                    mainText: 'زيادة وزن بشكل كبير',
                    subText:
                        'عايز ازيد عضل ومش فارق معاياالدهون اللي هتزيد في اختيار الهدف (زيادة وزن بشكل كبير)',
                    number: 5,
                    userChoice: activeUser.goal,
                    onClick: () {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setGoal(5);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProgramSelectCard(
                    mainText: 'مش عارف هدفي',
                    subText: 'يتم تحديد الهدف من خلال رؤية الكوتش',
                    number: 6,
                    userChoice: activeUser.goal,
                    onClick: () {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setGoal(6);
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
            onClick: activeUser.goal != 0
                ? () {
                    onNext(context, activeUser);
                  }
                : () {},
            bgColor: activeUser.goal != 0 ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
