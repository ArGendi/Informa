import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SelectWhichTwoMeals extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectWhichTwoMeals({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectWhichTwoMealsState createState() => _SelectWhichTwoMealsState();
}

class _SelectWhichTwoMealsState extends State<SelectWhichTwoMeals> {
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
                    'أنت اخترت وجبتين فاليوم',
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
                    'حدد الوجبتين بتوعك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'فطار وغدا',
                    number: 1,
                    userChoice: activeUser!.whichTwoMeals,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setWhichTwoMeals(1);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'غدا وعشاء',
                    number: 2,
                    userChoice: activeUser.whichTwoMeals,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setWhichTwoMeals(2);
                    },
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.whichTwoMeals != 0? widget.onClick : (){},
            bgColor: activeUser.whichTwoMeals != 0? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
