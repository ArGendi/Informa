import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/select_level_card.dart';
import 'package:provider/provider.dart';

import 'custom_button.dart';

class SelectLevel extends StatefulWidget {
  final VoidCallback onClick;
  const SelectLevel({Key? key, required this.onClick}) : super(key: key);

  @override
  _SelectLevelState createState() => _SelectLevelState();
}

class _SelectLevelState extends State<SelectLevel> {
  Widget cardLevel(int level){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(int i=0; i<4; i++)
          Row(
            children: [
              Container(
                width: 15,
                height: 2,
                color: i < level ? primaryColor : Colors.grey[300],
              ),
              SizedBox(width: 5,),
            ],
          ),
      ],
    );
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
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 40,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'جميل دلوقتي محتاجين نعرف مستواك',
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
                    'اختار مستواك في التمرين',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CairoBold'
                    ),
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Expanded(
                        child: SelectLevelCard(
                          text: 'خبرتي بسيطة \nوبتعب بسرعة',
                          id: 1,
                          level: 1,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: SelectLevelCard(
                          text: 'بتمرن بشكل متقتع \nوعندي لياقة معقولة',
                          id: 2,
                          level: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: SelectLevelCard(
                          text: 'بتمرن بشكل منتظم \nولياقتي عالية',
                          id: 3,
                          level: 3,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: SelectLevelCard(
                          text: 'شخص رياضي وبقدر \nأعمل تمارين متقدمة',
                          id: 4,
                          level: 4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser!.fitnessLevel != 0 ? widget.onClick : (){},
            bgColor: activeUser.fitnessLevel != 0 ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
