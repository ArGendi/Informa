import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'custom_button.dart';

class SelectGoal extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectGoal({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectGoalState createState() => _SelectGoalState();
}

class _SelectGoalState extends State<SelectGoal> {
  String _goalDescription = '';
  var _formKey = GlobalKey<FormState>();

  onNext(BuildContext context){
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid){
      _formKey.currentState!.save();
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setGoalDescription(_goalDescription);
      widget.onClick();
    }
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
                    'ما الهدف الذي تريد تحقيقه',
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
                    'أختار هدف',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'خسارة وزن كبير',
                    subText: 'عايز أخس اكتر وزن ممكن أنزله في أسرع وقت',
                    number: 1,
                    userChoice: activeUser!.goal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setGoal(1);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'خسارة دهون بمعدل طبيعي',
                    subText: 'عايز أخس دهون بالمعدل الطبيعي والصحي واحاول اخلي خسارة العضلات قليلة',
                    number: 2,
                    userChoice: activeUser.goal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setGoal(2);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'ثبات في الوزن وخسارة بسيطة دهون',
                    subText: 'عايز وزني يبقا ثابت وأحاول انقص شوية دهون قليلة وأثبت او ازيد عضل بسيط',
                    number: 3,
                    userChoice: activeUser.goal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setGoal(3);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'زيادة عضل مع دهون بسيطة',
                    subText: 'عايز ازود وزني شوية ومعظم الزيادة عضل وزيادة الدهون تكون بسيطة',
                    number: 4,
                    userChoice: activeUser.goal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setGoal(4);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'زيادة وزن بشكل كبير',
                    subText: 'عايز أزود وزني بشكل كبير وعايز ازود عضا ومش فارق معايا اوي الدهون الي هتحصل',
                    number: 5,
                    userChoice: activeUser.goal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setGoal(5);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'مش عارف هدفي',
                    subText: 'يتم تحديد الهدف من خلال رؤية الكوتش',
                    number: 6,
                    userChoice: activeUser.goal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setGoal(6);
                    },
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'أشرح هدفك بالتفصيل',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Form(
                    key: _formKey,
                    child: CustomTextField(
                      text: 'أشرح هدفك',
                      obscureText: false,
                      textInputType: TextInputType.text,
                      anotherFilledColor: true,
                      setValue: (value){
                        _goalDescription = value;
                      },
                      validation: (value){
                        if(value.isEmpty) return 'أكتب هدفك بالتفصيل';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.goal != 0 ? (){
              onNext(context);
            } : (){},
            bgColor: activeUser.goal != 0 ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
