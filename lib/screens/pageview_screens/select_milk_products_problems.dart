import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/custom_button.dart';

class SelectMilkProductsProblems extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectMilkProductsProblems({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectMilkProductsProblemsState createState() => _SelectMilkProductsProblemsState();
}

class _SelectMilkProductsProblemsState extends State<SelectMilkProductsProblems> {
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
                    'دلوقتي نشوف منتجات الألبان',
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
                    'هل تعانى من هضم منتاجات الالبان؟',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'نعم عندى حساسية من كل منتجات الالبان',
                    number: 1,
                    userChoice: activeUser!.milkProblem,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setMilkProblem(1);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'لا باكل و بشرب منتجات الالبان عادى',
                    number: 2,
                    userChoice: activeUser.milkProblem,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setMilkProblem(2);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'مشكلتى مع اللبن فقط لكن الجبن و الزبادى تمام',
                    number: 3,
                    userChoice: activeUser.milkProblem,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setMilkProblem(3);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'مشكلتى مع الجبن فقط لكنى أشرب لبن و اكل زبادى عادى',
                    number: 4,
                    userChoice: activeUser.milkProblem,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setMilkProblem(4);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'مشكلتى مع الزبادى فقط و لكن الجبن تمام و اللبن تمام',
                    number: 5,
                    userChoice: activeUser.milkProblem,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setMilkProblem(5);
                    },
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.milkProblem != 0 ? widget.onClick : (){},
            bgColor: activeUser.milkProblem != 0 ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
