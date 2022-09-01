import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class DoNotKnowGoal extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const DoNotKnowGoal({Key? key, required this.onClick, required this.onBack})
      : super(key: key);

  @override
  _DoNotKnowGoalState createState() => _DoNotKnowGoalState();
}

class _DoNotKnowGoalState extends State<DoNotKnowGoal> {
  List _goals = [];

  List<int> calculateGoal() {
    var user = Provider.of<ActiveUserProvider>(context, listen: false).user;
    int x = user!.tall - 100;
    int result = user.weight - x;
    if (result >= 0) {
      return [2, 3];
    } else
      return [3, 4];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      _goals = calculateGoal();
    }
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
                    'علي حسب بياناتك وتحليلنا لها فا انت قدامك الهدفين دول تختار منهم',
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
                  if (_goals.contains(2))
                    ProgramSelectCard(
                      mainText: 'خسارة دهون بمعدل طبيعي',
                      subText:
                          'عايز أخس دهون بالمعدل الطبيعي والصحي واحاول اخلي خسارة العضلات قليلة',
                      number: 2,
                      userChoice: activeUser!.goal,
                      onClick: () {
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .setGoal(2);
                      },
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  if (_goals.contains(3))
                    ProgramSelectCard(
                      mainText: 'ثبات في الوزن وخسارة بسيطة دهون',
                      subText:
                          'عايز وزني يبقا ثابت وأحاول انقص شوية دهون قليلة وأثبت او ازيد عضل بسيط',
                      number: 3,
                      userChoice: activeUser!.goal,
                      onClick: () {
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .setGoal(3);
                      },
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  if (_goals.contains(4))
                    ProgramSelectCard(
                      mainText: 'زيادة عضل مع دهون بسيطة',
                      subText:
                          'عايز ازود وزني شوية ومعظم الزيادة عضل وزيادة الدهون تكون بسيطة',
                      number: 4,
                      userChoice: activeUser!.goal,
                      onClick: () {
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .setGoal(4);
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
            onClick: activeUser!.goal != 6 ? widget.onClick : () {},
            bgColor: activeUser.goal != 6 ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
