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
  const SelectAgeTallWeight({Key? key, required this.onClick}) : super(key: key);

  @override
  _SelectAgeTallWeightState createState() => _SelectAgeTallWeightState();
}

class _SelectAgeTallWeightState extends State<SelectAgeTallWeight> {
  double _tallSliderValue = 170;
  double _weightSliderValue = 80;
  double _ageSliderValue = 30;

  onSubmit(BuildContext context){
    var activeUserProvider = Provider.of<ActiveUserProvider>(context, listen: false);
    activeUserProvider.setAge(_ageSliderValue.round());
    activeUserProvider.setTall(_tallSliderValue.round());
    activeUserProvider.setWeight(_weightSliderValue.round());
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 40,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'شكرا لتسجيلك معانا',
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
                      CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 18,
                        child: Text(
                          _ageSliderValue.toStringAsFixed(0),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14
                          ),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _ageSliderValue,
                    min: 10,
                    max: 90,
                    divisions: 80,
                    label: _ageSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _ageSliderValue = value;
                      });
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
                      CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 18,
                        child: Text(
                          _tallSliderValue.toStringAsFixed(0),
                          style: TextStyle(
                              color: Colors.white,
                            fontSize: 14
                          ),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _tallSliderValue,
                    min: 120,
                    max: 220,
                    divisions: 100,
                    label: _tallSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _tallSliderValue = value;
                      });
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
                      CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 18,
                        child: Text(
                          _weightSliderValue.toStringAsFixed(0),
                          style: TextStyle(
                              color: Colors.white,
                            fontSize: 14
                          ),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _weightSliderValue,
                    min: 20,
                    max: 250,
                    divisions: 230,
                    label: _weightSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _weightSliderValue = value;
                      });
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
            onClick: (){
              onSubmit(context);
              widget.onClick();
            },
          )
        ],
      ),
    );
  }
}
