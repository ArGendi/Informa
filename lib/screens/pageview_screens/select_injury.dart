import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SelectInjury extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectInjury({Key? key, required this.onClick, required this.onBack})
      : super(key: key);

  @override
  _SelectInjuryState createState() => _SelectInjuryState();
}

class _SelectInjuryState extends State<SelectInjury> {
  String? _injuryDetails;
  void onDone() {
    print(_injuryDetails);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setInjuryDetails(_injuryDetails);
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
                        onPressed: widget.onBack,
                        icon: Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(color: primaryColor),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/coach_face.jpg'),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'هل يوجد أصابة؟',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProgramSelectCard(
                    mainText: 'لا يوجد',
                    number: 1,
                    userChoice: activeUser!.injuryExist,
                    onClick: () {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setInjuryExist(1);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProgramSelectCard(
                    mainText: 'نعم يوجد',
                    number: 2,
                    userChoice: activeUser.injuryExist,
                    onClick: () {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setInjuryExist(2);
                    },
                  ),
                  if (activeUser.injuryExist == 2)
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
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
                        SizedBox(
                          height: 10,
                        ),
                        ProgramSelectCard(
                          mainText: 'أصابة كتف',
                          number: 1,
                          userChoice: activeUser.injuryType,
                          onClick: () {
                            Provider.of<ActiveUserProvider>(context,
                                    listen: false)
                                .setInjuryType(1);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ProgramSelectCard(
                          mainText: 'أصابة في الركبة',
                          number: 2,
                          userChoice: activeUser.injuryType,
                          onClick: () {
                            Provider.of<ActiveUserProvider>(context,
                                    listen: false)
                                .setInjuryType(2);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ProgramSelectCard(
                          mainText: 'أصابة في الضهر',
                          number: 3,
                          userChoice: activeUser.injuryType,
                          onClick: () {
                            Provider.of<ActiveUserProvider>(context,
                                    listen: false)
                                .setInjuryType(3);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  if (activeUser.injuryExist == 2)
                    TextField(
                      onChanged: (value) {
                        _injuryDetails = value;
                      },
                      maxLines: 6,
                      minLines: 4,
                      decoration: InputDecoration(
                        labelText: 'ممكن تشرحلنا اكتر عن الاصابة',
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            //width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            //width: 2.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide(
                            color: Colors.red,
                            //width: 2.0,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide(
                            color: Colors.red,
                            //width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser.injuryExist == 1
                ? widget.onClick
                : (activeUser.injuryExist == 2 && activeUser.injuryType != 0)
                    ? onDone
                    : () {},
            bgColor: activeUser.injuryExist == 1 ||
                    (activeUser.injuryExist == 2 && activeUser.injuryType != 0)
                ? primaryColor
                : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
