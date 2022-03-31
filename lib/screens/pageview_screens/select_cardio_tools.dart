import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SelectCardioTools extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectCardioTools({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectCardioToolsState createState() => _SelectCardioToolsState();
}

class _SelectCardioToolsState extends State<SelectCardioTools> {
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
                    'أدوات الكارديو',
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
                    'أختار الادوات المتوفرة عندك للكارديو',
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
                      if(!activeUser!.cardioTools.contains(1))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToCardioTools(1);
                      else
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .removeFromCardioTools(1);
                    },
                    mainText: 'Treadmill',
                    number: 1,
                    userChoice: activeUser!.cardioTools.contains(1) ? 1 : 0,
                    imagePath: 'assets/images/treadmill.png',
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    onClick: (){
                      if(!activeUser.cardioTools.contains(2))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToCardioTools(2);
                      else
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .removeFromCardioTools(2);
                    },
                    mainText: 'Elliptical',
                    number: 2,
                    userChoice: activeUser.cardioTools.contains(2) ? 2 : 0,
                    imagePath: 'assets/images/elliptical.png',
                  ),
                  ProgramSelectCard(
                    onClick: (){
                      if(!activeUser.cardioTools.contains(3))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToCardioTools(3);
                      else
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .removeFromCardioTools(3);
                    },
                    mainText: 'Stair Master',
                    number: 3,
                    userChoice: activeUser.cardioTools.contains(3) ? 3 : 0,
                    imagePath: 'assets/images/stair_master.png',
                  ),
                  ProgramSelectCard(
                    onClick: (){
                      if(!activeUser.cardioTools.contains(4))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToCardioTools(4);
                      else
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .removeFromCardioTools(4);
                    },
                    mainText: 'Rowing machine',
                    number: 4,
                    userChoice: activeUser.cardioTools.contains(4) ? 4 : 0,
                    imagePath: 'assets/images/rowing_machine.png',
                  ),
                  ProgramSelectCard(
                    onClick: (){
                      if(!activeUser.cardioTools.contains(5))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToCardioTools(5);
                      else
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .removeFromCardioTools(5);
                    },
                    mainText: 'لا يوجد',
                    number: 5,
                    userChoice: activeUser.cardioTools.contains(5) ? 5 : 0,
                    //imagePath: 'assets/images/bar1.png',
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
