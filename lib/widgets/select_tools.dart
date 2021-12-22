import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'custom_button.dart';

class SelectTools extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectTools({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectToolsState createState() => _SelectToolsState();
}

class _SelectToolsState extends State<SelectTools> {
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
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 40,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'دلوقتي محتاج اعرف الأدوات المتاحة',
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
                    'اختار الأدوات الي حابب تتمرن بيها',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CairoBold'
                    ),
                  ),
                  Text(
                    '(يمكنك أختيار اكثر من اداة)',
                    style: TextStyle(
                        //fontSize: 16,
                        fontFamily: 'CairoBold'
                    ),
                  ),
                  SizedBox(height: 25,),
                  ProgramSelectCard(
                    onClick: (){
                      if(!activeUser!.trainingTools.contains(1))
                        Provider.of<ActiveUserProvider>(context, listen: false).addTrainingTool(1);
                      else
                        Provider.of<ActiveUserProvider>(context, listen: false).removeTrainingTool(1);
                    },
                    mainText: 'دامبل',
                    number: 1,
                    userChoice: activeUser!.trainingTools.contains(1) ? 1 : 0,
                    imagePath: 'assets/images/dumbbelle.png',
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    onClick: (){
                      if(!activeUser.trainingTools.contains(2))
                        Provider.of<ActiveUserProvider>(context, listen: false).addTrainingTool(2);
                      else
                        Provider.of<ActiveUserProvider>(context, listen: false).removeTrainingTool(2);
                    },
                    mainText: 'بار',
                    number: 2,
                    userChoice: activeUser.trainingTools.contains(2) ? 2 : 0,
                    imagePath: 'assets/images/bar1.png',
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    onClick: (){
                      if(!activeUser.trainingTools.contains(3))
                        Provider.of<ActiveUserProvider>(context, listen: false).addTrainingTool(3);
                      else
                        Provider.of<ActiveUserProvider>(context, listen: false).removeTrainingTool(3);
                    },
                    mainText: 'كاتل بيل',
                    number: 3,
                    userChoice: activeUser.trainingTools.contains(3) ? 3 : 0,
                    imagePath: 'assets/images/kettlebell.png',
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.trainingTools.isNotEmpty ? widget.onClick : (){},
            bgColor: activeUser.trainingTools.isNotEmpty ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
