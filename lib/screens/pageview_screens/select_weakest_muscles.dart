import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SelectWeakestMuscles extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectWeakestMuscles({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectWeakestMusclesState createState() => _SelectWeakestMusclesState();
}

class _SelectWeakestMusclesState extends State<SelectWeakestMuscles> {
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
                    'عضلاتك الضعيفة',
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
                    'أختار اضعف عضلات عندك \n(ممكن تختار اكتر من أختيار)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'الصدر',
                    number: 1,
                    userChoice: activeUser!.weakestMuscles.contains(1)? 1 : 0,
                    onClick: (){
                      if(!activeUser.weakestMuscles.contains(1))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToWeakestMuscles(1);
                      else Provider.of<ActiveUserProvider>(context, listen: false)
                          .removeFromWeakestMuscles(1);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'الظهر',
                    number: 2,
                    userChoice: activeUser.weakestMuscles.contains(2)? 2 : 0,
                    onClick: (){
                      if(!activeUser.weakestMuscles.contains(2))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToWeakestMuscles(2);
                      else Provider.of<ActiveUserProvider>(context, listen: false)
                          .removeFromWeakestMuscles(2);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'الرجل',
                    number: 3,
                    userChoice: activeUser.weakestMuscles.contains(3)? 3 : 0,
                    onClick: (){
                      if(!activeUser.weakestMuscles.contains(3))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToWeakestMuscles(3);
                      else Provider.of<ActiveUserProvider>(context, listen: false)
                          .removeFromWeakestMuscles(3);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'البطن',
                    number: 4,
                    userChoice: activeUser.weakestMuscles.contains(4)? 4 : 0,
                    onClick: (){
                      if(!activeUser.weakestMuscles.contains(4))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToWeakestMuscles(4);
                      else Provider.of<ActiveUserProvider>(context, listen: false)
                          .removeFromWeakestMuscles(4);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'الباي',
                    number: 5,
                    userChoice: activeUser.weakestMuscles.contains(5)? 5 : 0,
                    onClick: (){
                      if(!activeUser.weakestMuscles.contains(5))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToWeakestMuscles(5);
                      else Provider.of<ActiveUserProvider>(context, listen: false)
                          .removeFromWeakestMuscles(5);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'التراي',
                    number: 6,
                    userChoice: activeUser.weakestMuscles.contains(6)? 6 : 0,
                    onClick: (){
                      if(!activeUser.weakestMuscles.contains(6))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToWeakestMuscles(6);
                      else Provider.of<ActiveUserProvider>(context, listen: false)
                          .removeFromWeakestMuscles(6);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'الكتف',
                    number: 7,
                    userChoice: activeUser.weakestMuscles.contains(7)? 7 : 0,
                    onClick: (){
                      if(!activeUser.weakestMuscles.contains(7))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToWeakestMuscles(7);
                      else Provider.of<ActiveUserProvider>(context, listen: false)
                          .removeFromWeakestMuscles(7);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'السمانة',
                    number: 8,
                    userChoice: activeUser.weakestMuscles.contains(8)? 8 : 0,
                    onClick: (){
                      if(!activeUser.weakestMuscles.contains(8))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToWeakestMuscles(8);
                      else Provider.of<ActiveUserProvider>(context, listen: false)
                          .removeFromWeakestMuscles(8);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'عندي مشكلة في كلة',
                    number: 9,
                    userChoice: activeUser.weakestMuscles.contains(9)? 9 : 0,
                    onClick: (){
                      if(!activeUser.weakestMuscles.contains(9))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToWeakestMuscles(9);
                      else Provider.of<ActiveUserProvider>(context, listen: false)
                          .removeFromWeakestMuscles(9);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'مفيش عضلة معينة ضعيفة',
                    number: 10,
                    userChoice: activeUser.weakestMuscles.contains(10)? 10 : 0,
                    onClick: (){
                      if(!activeUser.weakestMuscles.contains(10))
                        Provider.of<ActiveUserProvider>(context, listen: false)
                            .addToWeakestMuscles(10);
                      else Provider.of<ActiveUserProvider>(context, listen: false)
                          .removeFromWeakestMuscles(10);
                    },
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.weakestMuscles.isNotEmpty? widget.onClick : (){},
            bgColor: activeUser.weakestMuscles.isNotEmpty? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
