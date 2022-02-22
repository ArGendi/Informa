import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SelectDietType extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectDietType({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectDietTypeState createState() => _SelectDietTypeState();
}

class _SelectDietTypeState extends State<SelectDietType> {
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
                    'نظام الدايت',
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
                    'أختار نظام الدايت المفضل لك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'دايت متوازن',
                    number: 1,
                    userChoice: activeUser!.dietType,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setDietType(1);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'كارب سايكل',
                    number: 2,
                    userChoice: activeUser.dietType,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setDietType(2);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'لا أعرف',
                    number: 3,
                    userChoice: activeUser.dietType,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setDietType(3);
                    },
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.dietType != 0? widget.onClick : (){},
            bgColor: activeUser.dietType != 0? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
