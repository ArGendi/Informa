
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/plan_card.dart';
import 'package:informa/widgets/regular_premium_comparison.dart';

import '../constants.dart';

class PlansScreen extends StatefulWidget {
  static String id = 'plans';
  const PlansScreen({Key? key}) : super(key: key);

  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  int _selected = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_controller.jumpTo(2);
  }

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
                          fontSize: 20
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
                SizedBox(height: 30,),
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
          SizedBox(height: 10,),
          Text(
            'خطط الأسعار المتاحة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10,),
          CarouselSlider(
              items: [
                PlanCard(
                  id: 0,
                  selected: _selected,
                  name: '',
                  price: 200,
                  amountPerWeek: 14,
                  freePeriod: '6 شهور',
                  oldPrice: 300,
                  onClick: (){
                    setState(() { _selected = 0; });
                  },
                ),
                PlanCard(
                  id: 1,
                  selected: _selected,
                  name: '',
                  price: 200,
                  amountPerWeek: 14,
                  freePeriod: '6 شهور',
                  oldPrice: 300,
                  onClick: (){
                    setState(() { _selected = 1; });
                  },
                ),
                PlanCard(
                  id: 2,
                  selected: _selected,
                  name: '',
                  price: 200,
                  amountPerWeek: 14,
                  freePeriod: '6 شهور',
                  oldPrice: 300,
                  onClick: (){
                    setState(() { _selected = 2; });
                  },
                ),
                PlanCard(
                  id: 3,
                  selected: _selected,
                  name: '',
                  price: 200,
                  amountPerWeek: 14,
                  freePeriod: '6 شهور',
                  oldPrice: 300,
                  onClick: (){
                    setState(() { _selected = 3; });
                  },
                ),
              ],
              options: CarouselOptions(
                //height: 200,
                aspectRatio: 16/9,
                viewportFraction: 0.5,
                initialPage: 2,
                scrollDirection: Axis.horizontal,
                //reverse: false,
                enableInfiniteScroll: false
              )
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(
              text: 'أشترك الأن',
              onClick: (){},
            ),
          )
        ],
      ),
    );
  }
}
