import 'package:flutter/material.dart';
import 'package:informa/models/supplements_list.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SelectWhichSupplements extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectWhichSupplements({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectWhichSupplementsState createState() => _SelectWhichSupplementsState();
}

class _SelectWhichSupplementsState extends State<SelectWhichSupplements> {
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
                    'محتاجين نعرف ايه المكملات الي عندك',
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
                    'اختار المكملات الي عندك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(height: 10,),
                  for(int i=0; i<SupplementsList.supplements.length; i++)
                  Column(
                    children: [
                      ProgramSelectCard(
                        mainText: SupplementsList.supplements[i].name!,
                        number: i+1,
                        userChoice: activeUser!.supplements.contains((i+1).toString()) ? i+1 : 0,
                        onClick: (){
                          Provider.of<ActiveUserProvider>(context, listen: false).addOrRemoveSupplement((i+1).toString());
                        },
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser!.supplements.isNotEmpty? widget.onClick : (){},
            bgColor: activeUser.supplements.isNotEmpty ? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
