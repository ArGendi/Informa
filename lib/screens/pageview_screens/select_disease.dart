import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/premium_screens/premium_program_counter_screen.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/custom_button.dart';
import '../main_screen.dart';

class SelectDisease extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  final bool? isLoading;
  const SelectDisease({Key? key, required this.onClick, required this.onBack, this.isLoading = false}) : super(key: key);

  @override
  _SelectDiseaseState createState() => _SelectDiseaseState();
}

class _SelectDiseaseState extends State<SelectDisease> with SingleTickerProviderStateMixin{
  String _diseaseWithDesc = '';
  var _formKey = GlobalKey<FormState>();
  late AnimationController _controller;
  late Animation<Offset> _offset;

  onNext(int disease) async{
    FocusScope.of(context).unfocus();
    if(disease == 1){
      widget.onClick();
      await _controller.forward();
      Navigator.pushNamed(context, PremiumProgramCounterScreen.id);
    }
    else{
      bool valid = _formKey.currentState!.validate();
      if(valid){
        _formKey.currentState!.save();
        Provider.of<ActiveUserProvider>(context, listen: false)
            .setDiseaseDescription(_diseaseWithDesc);
        widget.onClick();
        //await _controller.forward();
        Navigator.pushNamed(context, PremiumProgramCounterScreen.id);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _offset = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0,-3),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_controller.dispose();
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
                  SlideTransition(
                    position: _offset,
                    child: Container(
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
