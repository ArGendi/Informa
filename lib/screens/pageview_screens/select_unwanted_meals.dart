import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/removable_circle_meal.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/custom_button.dart';

class SelectUnWantedMeals extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectUnWantedMeals({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectUnWantedMealsState createState() => _SelectUnWantedMealsState();
}

class _SelectUnWantedMealsState extends State<SelectUnWantedMeals> {
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
                    'الأكل الغير مرغوب فيه',
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
                    'أضغط علي أصناف الاكل التي لا تحبها أو الغير متوفرة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: boldFont,
                    ),
                  ),
                  SizedBox(height: 15,),
                  for(int i=0; i<12; i+=4)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RemovableCircleMeal(
                              id: i,
                              text: activeUser!.wantedMeals[i].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+1,
                              text: activeUser.wantedMeals[i+1].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+2,
                              text: activeUser.wantedMeals[i+2].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+3,
                              text: activeUser.wantedMeals[i+3].name,
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  Divider(
                    height: 15,
                  ),
                  SizedBox(height: 10,),
                  for(int i=12; i<18; i+=4)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RemovableCircleMeal(
                              id: i,
                              text: activeUser!.wantedMeals[i].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+1,
                              text: activeUser.wantedMeals[i+1].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+2,
                              text: activeUser.wantedMeals[i+2].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+3,
                              text: activeUser.wantedMeals[i+3].name,
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  Divider(
                    height: 15,
                  ),
                  SizedBox(height: 10,),
                  for(int i=18; i<30; i+=4)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RemovableCircleMeal(
                              id: i,
                              text: activeUser!.wantedMeals[i].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+1,
                              text: activeUser.wantedMeals[i+1].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+2,
                              text: activeUser.wantedMeals[i+2].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+3,
                              text: activeUser.wantedMeals[i+3].name,
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  Divider(
                    height: 15,
                  ),
                  SizedBox(height: 10,),
                  for(int i=30; i<37; i+=4)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RemovableCircleMeal(
                              id: i,
                              text: activeUser!.wantedMeals[i].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+1,
                              text: activeUser.wantedMeals[i+1].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+2,
                              text: activeUser.wantedMeals[i+2].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+3,
                              text: activeUser.wantedMeals[i+3].name,
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  Divider(
                    height: 15,
                  ),
                  SizedBox(height: 10,),
                  for(int i=37; i<49; i+=4)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RemovableCircleMeal(
                              id: i,
                              text: activeUser!.wantedMeals[i].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+1,
                              text: activeUser.wantedMeals[i+1].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+2,
                              text: activeUser.wantedMeals[i+2].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+3,
                              text: activeUser.wantedMeals[i+3].name,
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  Divider(
                    height: 15,
                  ),
                  SizedBox(height: 10,),
                  for(int i=49; i<activeUser!.wantedMeals.length; i+=4)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RemovableCircleMeal(
                              id: i,
                              text: activeUser.wantedMeals[i].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+1,
                              text: activeUser.wantedMeals[i+1].name,
                            ),
                            SizedBox(width: 7,),
                            RemovableCircleMeal(
                              id: i+2,
                              text: activeUser.wantedMeals[i+2].name,
                            ),
                            SizedBox(width: 7,),
                            if(i+3 < activeUser.wantedMeals.length)
                              RemovableCircleMeal(
                                id: i+3,
                                text: activeUser.wantedMeals[i+3].name,
                              ),
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: widget.onClick,
          )
        ],
      ),
    );
  }
}
