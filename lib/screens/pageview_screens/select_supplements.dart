import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/program_select_card.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/custom_button.dart';

class SelectSupplements extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectSupplements(
      {Key? key, required this.onClick, required this.onBack})
      : super(key: key);

  @override
  _SelectSupplementsState createState() => _SelectSupplementsState();
}

class _SelectSupplementsState extends State<SelectSupplements> {
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
                    'دلوقتي اسئلة عن المكملات',
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
                    'هل نقدر نستخدم الواى بروتين؟',
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
                    mainText: 'ممكن نستخدمة عادي',
                    number: 1,
                    userChoice: activeUser!.wheyProtein,
                    onClick: () {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setWheyProtein(1);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProgramSelectCard(
                    mainText: 'مش عايز أستخدم أى نوع من المكملات',
                    number: 2,
                    userChoice: activeUser.wheyProtein,
                    onClick: () {
                      Provider.of<ActiveUserProvider>(context, listen: false)
                          .setWheyProtein(2);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (activeUser.wheyProtein == 1)
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: activeUser.wheyProtein == 1 ? 1 : 0,
                      child: Column(
                        children: [
                          Text(
                            ' هل تمتلك حاليا اى نوع من المكملات ؟',
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
                            mainText: 'معايا مكملات',
                            number: 1,
                            userChoice: activeUser.haveSupplements,
                            onClick: () {
                              Provider.of<ActiveUserProvider>(context,
                                      listen: false)
                                  .setHaveSupplements(1);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ProgramSelectCard(
                            mainText: 'معنديش',
                            number: 2,
                            userChoice: activeUser.haveSupplements,
                            onClick: () {
                              Provider.of<ActiveUserProvider>(context,
                                      listen: false)
                                  .setHaveSupplements(2);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ProgramSelectCard(
                            mainText: 'معنديش بس ممكن اشتري',
                            number: 3,
                            userChoice: activeUser.haveSupplements,
                            onClick: () {
                              Provider.of<ActiveUserProvider>(context,
                                      listen: false)
                                  .setHaveSupplements(3);
                            },
                          ),
                        ],
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
            onClick: activeUser.wheyProtein == 2 ||
                    (activeUser.wheyProtein == 1 &&
                        activeUser.haveSupplements != 0)
                ? () {
                    widget.onClick();
                  }
                : () {},
            bgColor: activeUser.wheyProtein == 2 ||
                    (activeUser.wheyProtein == 1 &&
                        activeUser.haveSupplements != 0)
                ? primaryColor
                : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
