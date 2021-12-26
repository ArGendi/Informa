import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'custom_button.dart';

class SelectPlace extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectPlace({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectPlaceState createState() => _SelectPlaceState();
}

class _SelectPlaceState extends State<SelectPlace> {
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
                  SizedBox(height: 20,),
                  Image.asset(
                    'assets/images/ahlan.png',
                    width: 90,
                  ),
                  Text(
                    'دعنا نتعرف عليك',
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
                    'أين مكان تمرينك؟',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'CairoBold'
                    ),
                  ),
                  SizedBox(height: 20,),
                  ProgramSelectCard(
                    mainText: 'في البيت',
                    subText: 'وزن الجسم بأدوات بسيطة او من غير ادوات',
                    number: 1,
                    userChoice: activeUser!.workoutPlace,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setWorkoutPlace(1);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'في الجيم',
                    subText: 'أستخدام الأوزان الحرة والأجهزة المختلفة',
                    number: 2,
                    userChoice: activeUser.workoutPlace,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setWorkoutPlace(2);
                    },
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.workoutPlace != 0 ? widget.onClick : (){},
            bgColor: activeUser.workoutPlace != 0 ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
