import 'package:flutter/material.dart';
import 'package:informa/widgets/advantage_row.dart';

import '../constants.dart';

class RegularPremiumComparison extends StatefulWidget {
  const RegularPremiumComparison({Key? key}) : super(key: key);

  @override
  _RegularPremiumComparisonState createState() => _RegularPremiumComparisonState();
}

class _RegularPremiumComparisonState extends State<RegularPremiumComparison> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'أنفورما',
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'بريميم',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20,),
              Text(
                'أنفورما',
                style: TextStyle(
                  //fontFamily: 'CairoBold',
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                AdvantageRow(
                  text: 'تسجيل ومتابعة اوزانك وتغييرات جسمك',
                ),
                Divider(height: 20,),
                AdvantageRow(
                  text: 'تسجيل ومتابعة اوزانك وتغييرات جسمك',
                ),
                Divider(height: 20,),
                AdvantageRow(
                  text: 'تسجيل ومتابعة اوزانك وتغييرات جسمك',
                ),
                Divider(height: 20,),
                AdvantageRow(
                  text: 'تسجيل ومتابعة اوزانك وتغييرات جسمك',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
