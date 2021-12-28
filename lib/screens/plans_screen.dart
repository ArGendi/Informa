
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/video_player_screen.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/plan_card.dart';
import 'package:informa/widgets/program_card.dart';
import 'package:informa/widgets/regular_premium_comparison.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class PlansScreen extends StatefulWidget {
  static String id = 'plans';
  const PlansScreen({Key? key}) : super(key: key);

  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  int _selected = 2;

  onSubscribe(BuildContext context){
    Provider.of<ActiveUserProvider>(context, listen: false).setProgram(_selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'شاهد مميزات البريميم',
                    style: TextStyle(),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VideoPlayerScreen(
                          url: 'https://www.youtube.com/watch?v=sLgz57tguKo',
                        )),
                      );
                    },
                    child: Card(
                      elevation: 0,
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'انفورما',
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
                      width: 30,
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
                      width: 30,
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
                      width: 30,
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
          //RegularPremiumComparison(),
          SizedBox(height: 10,),
          Text(
            'أختار برنامجك',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10,),
          CarouselSlider(
              items: [
                ProgramCard(
                  id: 1,
                  selected: _selected,
                  onClick: (){
                    setState(() { _selected = 1; });
                  },
                  mainText: 'تمارين',
                  description: 'يهمني اخد برنامج نمارين مفصل علي روتيني واحتياجاتي',
                ),
                ProgramCard(
                  id: 2,
                  selected: _selected,
                  onClick: (){
                    setState(() { _selected = 2; });
                  },
                  mainText: 'تمارين + تغذية',
                  description: 'مستعد التزم ببرنامج تمارين وتغذية مناسبين لهدفي',
                ),
                ProgramCard(
                  id: 3,
                  selected: _selected,
                  onClick: (){
                    setState(() { _selected = 3; });
                  },
                  mainText: 'نظام غذائي',
                  description: 'معنديش وقت كتير للتمرين ومحتاج نظام غذائي مناسب',
                ),
              ],
              options: CarouselOptions(
                //height: 200,
                aspectRatio: 16/9,
                viewportFraction: 0.5,
                initialPage: 1,
                scrollDirection: Axis.horizontal,
                //reverse: false,
                enableInfiniteScroll: false
              )
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(
              text: 'أشترك الأن',
              onClick: (){
                onSubscribe(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
