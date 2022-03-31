import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/select_level_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SelectTrainingLevel extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectTrainingLevel({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectTrainingLevelState createState() => _SelectTrainingLevelState();
}

class _SelectTrainingLevelState extends State<SelectTrainingLevel> {
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
                    'جميل دلوقتي محتاجين نعرف مستواك في التمرين',
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
                          text: 'عمري ما اتمرنت\n قبل كدا',
                          id: 1,
                          level: 1,
                          maxLevel: 4,
                          selected: activeUser!.trainingLevel,
                          onClick: (){
                            Provider.of<ActiveUserProvider>(context, listen: false)
                                .setTrainingLevel(1);
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: SelectLevelCard(
                          text: 'مبتدئ (بتمرن بقالي\n كام شهر فقط)',
                          id: 2,
                          level: 2,
                          maxLevel: 4,
                          selected: activeUser.trainingLevel,
                          onClick: (){
                            Provider.of<ActiveUserProvider>(context, listen: false)
                                .setTrainingLevel(2);
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
                          text: 'متوسط\n المستوي',
                          id: 3,
                          level: 3,
                          maxLevel: 4,
                          selected: activeUser.trainingLevel,
                          onClick: (){
                            Provider.of<ActiveUserProvider>(context, listen: false)
                                .setTrainingLevel(3);
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: SelectLevelCard(
                          text: 'متمرس (بتمرن\n بقالي فترة كبيرة)',
                          id: 4,
                          level: 4,
                          maxLevel: 4,
                          selected: activeUser.trainingLevel,
                          onClick: (){
                            Provider.of<ActiveUserProvider>(context, listen: false)
                                .setTrainingLevel(4);
                          },
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
            onClick: activeUser.trainingLevel != 0 ? widget.onClick : (){},
            bgColor: activeUser.trainingLevel != 0 ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
