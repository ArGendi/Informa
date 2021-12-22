import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants.dart';
import 'custom_button.dart';

class SelectAgeTallWeight extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onBack;
  const SelectAgeTallWeight({Key? key, required this.onClick, required this.onBack}) : super(key: key);

  @override
  _SelectAgeTallWeightState createState() => _SelectAgeTallWeightState();
}

class _SelectAgeTallWeightState extends State<SelectAgeTallWeight> {

  @override
  Widget build(BuildContext context) {
    var activeUserProvider = Provider.of<ActiveUserProvider>(context);
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
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 40,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'شكرا ' + activeUserProvider.user!.name! + ' لتسجيلك معانا',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'محتاجين نعرف عنك معلومات أكتر',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    color: Colors.grey[600],
                    indent: screenSize.width * .3,
                    endIndent: screenSize.width * .3,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'دعنا نتعرف علي عمرك, طولك و وزنك الحالي',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'CairoBold'
                    ),
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'عمرك',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: Text(
                            activeUserProvider.user!.age.toString() + ' سنة',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: activeUserProvider.user!.age.toDouble(),
                    min: 10,
                    max: 90,
                    divisions: 80,
                    label: activeUserProvider.user!.age.toString(),
                    onChanged: (double value) {
                      activeUserProvider.setAge(value.round());
                    },
                    activeColor: primaryColor,
                    inactiveColor: Colors.grey[300],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'طولك',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: Text(
                            activeUserProvider.user!.tall.toString() + ' سم',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: activeUserProvider.user!.tall.toDouble(),
                    min: 120,
                    max: 220,
                    divisions: 100,
                    label: activeUserProvider.user!.tall.toString(),
                    onChanged: (double value) {
                      activeUserProvider.setTall(value.round());
                    },
                    activeColor: primaryColor,
                    inactiveColor: Colors.grey[300],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'وزنك',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: Text(
                            activeUserProvider.user!.weight.toString() + ' كجم',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: activeUserProvider.user!.weight.toDouble(),
                    min: 20,
                    max: 250,
                    divisions: 230,
                    label: activeUserProvider.user!.weight.toString(),
                    onChanged: (double value) {
                      activeUserProvider..setWeight(value.round());
                    },
                    activeColor: primaryColor,
                    inactiveColor: Colors.grey[300],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الوزن الي محتاج توصله',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: Text(
                            activeUserProvider.user!.goalWeight.toString() + ' كجم',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: activeUserProvider.user!.goalWeight.toDouble(),
                    min: 20,
                    max: 250,
                    divisions: 230,
                    label: activeUserProvider.user!.goalWeight.toString(),
                    onChanged: (double value) {
                      activeUserProvider.setGoalWeight(value.round());
                    },
                    activeColor: primaryColor,
                    inactiveColor: Colors.grey[300],
                  ),
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
