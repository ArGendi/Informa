import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:informa/constants.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class SelectGender extends StatefulWidget {
  final VoidCallback onClick;
  const SelectGender({Key? key, required this.onClick}) : super(key: key);

  @override
  _SelectGenderState createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Text(
                  //   'أهلا',
                  //   style: TextStyle(
                  //       fontSize: 26,
                  //       color: primaryColor,
                  //       fontFamily: 'CairoBold'
                  //   ),
                  // ),
                  Image.asset(
                    'assets/images/ahlan.png',
                    width: 90,
                  ),
                  Text(
                    'دعنا نتعرف عليك أكثر',
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ),
                  Divider(
                    color: primaryColor,
                    indent: screenSize.width * .3,
                    endIndent: screenSize.width * .3,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'أختار النوع',
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'CairoBold'
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Provider.of<ActiveUserProvider>(context, listen: false).setGender(1);
                          },
                          child: Ink(
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: activeUser!.gender == 1 ? primaryColor : Colors.white,
                                    width: 2
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/icons/male.svg'
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'ذكر',
                                    style: TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Provider.of<ActiveUserProvider>(context, listen: false).setGender(2);
                          },
                          child: Ink(
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: activeUser.gender == 2 ? primaryColor : Colors.white,
                                    width: 2
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Center(
                                        child: SvgPicture.asset(
                                            'assets/icons/female.svg'
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'انثى',
                                    style: TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
            onClick: activeUser.gender == 0 ? (){} : widget.onClick,
            bgColor: activeUser.gender == 0 ? Colors.grey.shade400 : primaryColor,
          )
        ],
      ),
    );
  }
}
