import 'package:flutter/material.dart';
import 'package:informa/widgets/regular_premium_comparison.dart';

import '../constants.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'أنفورما',
                      style: TextStyle(
                          fontFamily: 'CairoBold',
                          fontSize: 22
                      ),
                    ),
                    Column(
                      children: [
                        Card(
                          elevation: 0,
                          color: primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'بريميم',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                      ],
                    ),
                  ],
                ),
                Text(
                  'للحصول علي برنامج تغذية وتمارين مخصصة لجسمك بالأضافة الي مميزات غير محدودة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/premium.png',
                      width: 35,
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تمارين مخصصة لنوع جسمك',
                            style: TextStyle(
                              fontFamily: 'CairoBold',
                            ),
                          ),
                          Text(
                            'للحصول علي برنامج تغذية وتمارين مخصصة لجسمك',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                  indent: 30,
                  endIndent: 30,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/premium.png',
                      width: 35,
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تمارين مخصصة لنوع جسمك',
                            style: TextStyle(
                              fontFamily: 'CairoBold',
                            ),
                          ),
                          Text(
                            'للحصول علي برنامج تغذية وتمارين مخصصة لجسمك',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                  indent: 30,
                  endIndent: 30,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/premium.png',
                      width: 35,
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تمارين مخصصة لنوع جسمك',
                            style: TextStyle(
                              fontFamily: 'CairoBold',
                            ),
                          ),
                          Text(
                            'للحصول علي برنامج تغذية وتمارين مخصصة لجسمك',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          RegularPremiumComparison(),
        ],
      ),
    );
  }
}
