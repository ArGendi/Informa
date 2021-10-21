import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/screens/video_player_screen.dart';
import 'package:informa/widgets/meal_info_box.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailedMealScreen extends StatefulWidget {
  const DetailedMealScreen({Key? key}) : super(key: key);

  @override
  _DetailedMealScreenState createState() => _DetailedMealScreenState();
}

class _DetailedMealScreenState extends State<DetailedMealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/burger.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.grey.withOpacity(0.0),
                          Colors.black,
                        ],
                      )
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: InkWell(
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
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'وصفات الدجاج',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'تشكن برجر دايت',
                        style: TextStyle(
                          fontSize: 24,
                          height: 1.6
                        ),
                      ),
                      //SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'النسبة من الهدف اليومي',
                            style: TextStyle(
                              fontSize: 12
                            ),
                          ),
                          TextButton(
                            onPressed: (){},
                            child: Text(
                              'الترقية الي أنفورما بلس',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MealInfoBox(
                            text: 'كاربوهايدرات',
                            value: 1200,
                            percent: 0.6,
                          ),
                          MealInfoBox(
                            text: 'سعرات حرارية',
                            value: 300,
                            percent: 0.2,
                          ),
                          MealInfoBox(
                            text: 'بروتين',
                            value: 500,
                            percent: 0.2,
                          ),
                          MealInfoBox(
                            text: 'دهون',
                            value: 800,
                            percent: 0.1,
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'المكونات',
                        style: TextStyle(
                          fontSize: 20,
                          color: primaryColor
                        ),
                      ),
                      for(int i=0; i<5; i++)
                        Text(
                          'نص كيلو دجاج مخلي'
                        ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                    elevation: 0,
                    onPressed: (){},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'أضف الوجبة الي نظامي الغذائي',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
