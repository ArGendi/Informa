import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SelectWorkoutGoal extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectWorkoutGoal({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectWorkoutGoalState createState() => _SelectWorkoutGoalState();
}

class _SelectWorkoutGoalState extends State<SelectWorkoutGoal> {
  var _formKey = GlobalKey<FormState>();
  String? _goalDescription;

  onDone(BuildContext context){
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setWorkoutGoalDescription(_goalDescription);
    widget.onClick();
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
                        onPressed: (){
                          Navigator.pop(context);
                        },
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
                    'الهدف الرئيسي من التمارين',
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
                    'أختار هدفك الرئيسي',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'بناء حجم عضلي',
                    number: 1,
                    userChoice: activeUser!.workoutGoal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setWorkoutGoal(1);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'قوة عضلية',
                    number: 2,
                    userChoice: activeUser.workoutGoal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setWorkoutGoal(2);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'زيادة تحمل العضلات والنفس',
                    number: 3,
                    userChoice: activeUser.workoutGoal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setWorkoutGoal(3);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'تنشيف',
                    number: 4,
                    userChoice: activeUser.workoutGoal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setWorkoutGoal(4);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'مش عارف هدفي (يتم تحديد عن طريق الكوتش)',
                    number: 5,
                    userChoice: activeUser.workoutGoal,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setWorkoutGoal(5);
                    },
                  ),
                  SizedBox(height: 20,),
                  Form(
                    key: _formKey,
                    child: CustomTextField(
                      text: 'اشرح هدفك بالتفصيل',
                      obscureText: false,
                      textInputType: TextInputType.text,
                      anotherFilledColor: true,
                      setValue: (value){
                        _goalDescription = value;
                      },
                      validation: (value){
                        //if(value.isEmpty) return 'اشرح هدفك بالتفصيل';
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
            onClick: activeUser.workoutGoal != 0? (){
              onDone(context);
            } : (){},
            bgColor: activeUser.workoutGoal != 0? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
