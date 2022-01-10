import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/custom_button.dart';

class SelectDisease extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  final bool? isLoading;
  const SelectDisease({Key? key, required this.onClick, required this.onBack, this.isLoading = false}) : super(key: key);

  @override
  _SelectDiseaseState createState() => _SelectDiseaseState();
}

class _SelectDiseaseState extends State<SelectDisease> {
  String _diseaseWithDesc = '';
  var _formKey = GlobalKey<FormState>();

  onNext(int disease){
    FocusScope.of(context).unfocus();
    if(disease == 1){
      widget.onClick();
    }
    else{
      bool valid = _formKey.currentState!.validate();
      if(valid){
        _formKey.currentState!.save();
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setDiseaseDescription(_diseaseWithDesc);
        widget.onClick();
      }
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
                    'محتاجين نعرف لو عندك اي امراض',
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
                    'هل في اى مرض؟',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'لا يوجد',
                    number: 1,
                    userChoice: activeUser!.disease,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setDisease(1);
                    },
                  ),
                  SizedBox(height: 10,),
                  ProgramSelectCard(
                    mainText: 'نعم يوجد',
                    number: 2,
                    userChoice: activeUser.disease,
                    onClick: (){
                      Provider.of<ActiveUserProvider>(context, listen: false).setDisease(2);
                    },
                  ),
                  SizedBox(height: 20,),
                  AnimatedOpacity(
                    opacity: activeUser.disease == 2? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        Text(
                          'ألف سلامة عليك ♥',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: boldFont,
                          ),
                        ),
                        Text(
                          'اكتب اسم المرض بالشرح',
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
                            text: 'المرض بالشرح',
                            obscureText: false,
                            textInputType: TextInputType.text,
                            anotherFilledColor: true,
                            setValue: (value){
                              _diseaseWithDesc = value;
                            },
                            validation: (value){
                              if(value.isEmpty) return 'أكتب المرض بالشرح';
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'تم',
            onClick: activeUser.disease != 0? (){
              onNext(activeUser.disease);
            } : (){},
            bgColor: activeUser.disease != 0? primaryColor : Colors.grey.shade400,
            isLoading: widget.isLoading!,
          )
        ],
      ),
    );
  }
}
