import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/screens/video_player_screen.dart';
import 'package:informa/widgets/meal_info_box.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class SingleMealScreen extends StatefulWidget {
  static String id = 'detailed meal';
  final Meal meal;
  const SingleMealScreen({Key? key, required this.meal}) : super(key: key);

  @override
  _SingleMealScreenState createState() => _SingleMealScreenState();
}

class _SingleMealScreenState extends State<SingleMealScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Stack(
                children: [
                  Hero(
                    tag: widget.meal.id!,
                    child: Image.asset(
                      widget.meal.image!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300,
                    ),
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
                    bottom: 15,
                    left: 15,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoPlayerScreen(
                            url: widget.meal.video!,
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                    indent: screenSize.width * 0.37,
                    endIndent: screenSize.width * 0.37,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.meal.category!,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.meal.name!,
                            style: TextStyle(
                              fontSize: 24,
                              height: 1.6
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                              if(!activeUser!.premium){
                                Navigator.pushNamed(context, PlansScreen.id);
                              }
                              else{
                                setState(() {
                                  _isFavorite = !_isFavorite;
                                });
                              }
                            },
                            splashRadius: 5,
                            icon: Icon(
                              _isFavorite ? Icons.bookmark_outlined : Icons.bookmark_outline,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      //SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'نسب الوجبة',
                            style: TextStyle(
                              fontSize: 12
                            ),
                          ),
                          if(!activeUser!.premium)
                            TextButton(
                              onPressed: (){
                                Navigator.pushNamed(context, PlansScreen.id);
                              },
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
                            value: widget.meal.carb!,
                            percent: 0.6,
                          ),
                          MealInfoBox(
                            text: 'سعرات حرارية',
                            value: widget.meal.calories!,
                            percent: 0.2,
                          ),
                          MealInfoBox(
                            text: 'بروتين',
                            value: widget.meal.protein!,
                            percent: 0.2,
                          ),
                          MealInfoBox(
                            text: 'دهون',
                            value: widget.meal.fats!,
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
                      for(int i=0; i<widget.meal.components!.length; i++)
                        Text(
                          (i+1).toString() + '- ' + widget.meal.components![i],
                        ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                    elevation: 0,
                    onPressed: (){
                      if(!activeUser.premium)
                        Navigator.pushNamed(context, PlansScreen.id);
                    },
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
          ],
        ),
      ),
    );
  }
}
