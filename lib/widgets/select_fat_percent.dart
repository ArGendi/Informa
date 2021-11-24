import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/body_fat_card.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'custom_button.dart';

class SelectFatPercent extends StatefulWidget {
  final VoidCallback onClick;
  const SelectFatPercent({Key? key, required this.onClick}) : super(key: key);

  @override
  _SelectFatPercentState createState() => _SelectFatPercentState();
}

class _SelectFatPercentState extends State<SelectFatPercent> {
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
                    'نسبة الدهون في جسمك',
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
                    'اختار الجسم الأقرب لجسمك',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CairoBold'
                    ),
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/6.PNG',
                          percent: 6,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/10.PNG',
                          percent: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/15.PNG',
                          percent: 15,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/20.PNG',
                          percent: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/25.PNG',
                          percent: 25,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/30.PNG',
                          percent: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/35.PNG',
                          percent: 35,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/40.PNG',
                          percent: 40,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser!.fatsPercent != 0? widget.onClick : (){},
            bgColor: activeUser.fatsPercent != 0? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
