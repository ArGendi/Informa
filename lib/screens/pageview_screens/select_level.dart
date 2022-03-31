import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/select_level_card.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_button.dart';

class SelectLevel extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectLevel({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectLevelState createState() => _SelectLevelState();
}

class _SelectLevelState extends State<SelectLevel> {
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
                  SizedBox(height: 10,),
                  Text(
                    'اختار مستواك نشاطك',
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
                          text: 'حركة قليلة\n جدا جدا',
                          id: 1,
                          level: 1,
                          selected: activeUser!.fitnessLevel,
                          onClick: (){
                            Provider.of<ActiveUserProvider>(context, listen: false)
                                .setFitnessLevel(1);
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: SelectLevelCard(
                          text: 'حركة و نشاط\n خفبف نوعا ما',
                          id: 2,
                          level: 2,
                          selected: activeUser.fitnessLevel,
                          onClick: (){
                            Provider.of<ActiveUserProvider>(context, listen: false)
                                .setFitnessLevel(2);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: SelectLevelCard(
                          text: 'نشاط\n متوسط',
                          id: 3,
                          level: 3,
                          selected: activeUser.fitnessLevel,
                          onClick: (){
                            Provider.of<ActiveUserProvider>(context, listen: false)
                                .setFitnessLevel(3);
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: SelectLevelCard(
                          text: 'حركة و نشاط\n فى اليوم كبير',
                          id: 4,
                          level: 4,
                          selected: activeUser.fitnessLevel,
                          onClick: (){
                            Provider.of<ActiveUserProvider>(context, listen: false)
                                .setFitnessLevel(4);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  SelectLevelCard(
                    text: 'طول اليوم حركة و جهد\n و ومجهود كبير جدا',
                    id: 5,
                    level: 5,
                    selected: activeUser.fitnessLevel,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setFitnessLevel(5);
                    },
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.fitnessLevel != 0 ? widget.onClick : (){},
            bgColor: activeUser.fitnessLevel != 0 ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
