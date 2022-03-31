import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SelectInjury extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectInjury({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectInjuryState createState() => _SelectInjuryState();
}

class _SelectInjuryState extends State<SelectInjury> {
  // var _formKey = GlobalKey<FormState>();
  // String? _goalDescription;
  //
  // onDone(BuildContext context){
  //   FocusScope.of(context).unfocus();
  //   _formKey.currentState!.save();
  //   Provider.of<ActiveUserProvider>(context, listen: false)
  //       .setWorkoutGoalDescription(_goalDescription);
  //   widget.onClick();
  // }

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
                    'محتاجين نعرف لو عندك اصابة',
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
                    'هل يوجد أصابة؟',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  // SizedBox(height: 10,),
                  // Form(
                  //   key: _formKey,
                  //   child: CustomTextField(
                  //     text: 'اشرح هدفك بالتفصيل',
                  //     obscureText: false,
                  //     textInputType: TextInputType.text,
                  //     anotherFilledColor: true,
                  //     setValue: (value){
                  //       _goalDescription = value;
                  //     },
                  //     validation: (value){
                  //       //if(value.isEmpty) return 'اشرح هدفك بالتفصيل';
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'لا يوجد',
                    number: 1,
                    userChoice: activeUser!.injuryExist,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setInjuryExist(1);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'نعم يوجد',
                    number: 2,
                    userChoice: activeUser.injuryExist,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setInjuryExist(2);
                    },
                  ),
                  if(activeUser.injuryExist == 2)
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        'ألف سلامة عليك ♥',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          //fontFamily: boldFont,
                        ),
                      ),
                      Text(
                        'أختار نوع الأصابة',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          //fontFamily: boldFont,
                        ),
                      ),
                      SizedBox(height: 10,),
                      ProgramSelectCard(
                        mainText: 'أصابة كتف',
                        number: 1,
                        userChoice: activeUser.injuryType,
                        onClick: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setInjuryType(1);
                        },
                      ),
                      SizedBox(height: 10,),
                      ProgramSelectCard(
                        mainText: 'أصابة في الركبة',
                        number: 2,
                        userChoice: activeUser.injuryType,
                        onClick: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setInjuryType(2);
                        },
                      ),
                      SizedBox(height: 10,),
                      ProgramSelectCard(
                        mainText: 'أصابة في الضهر',
                        number: 3,
                        userChoice: activeUser.injuryType,
                        onClick: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).setInjuryType(3);
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.injuryExist == 1 ||
                (activeUser.injuryExist == 2 && activeUser.injuryType != 0) ? widget.onClick : (){},
            bgColor: activeUser.injuryExist == 1 ||
                (activeUser.injuryExist == 2 && activeUser.injuryType != 0)?
            primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
