import 'package:flutter/material.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/screens/detailed_meal_screen.dart';

import '../constants.dart';
import 'bottom_shaded_card.dart';

class RecentlyViewedBanner extends StatelessWidget {
  final List<Meal> recentlyViewed;

  const RecentlyViewedBanner({Key? key, required this.recentlyViewed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'تم عرضه مؤخرا',
                  style: TextStyle(
                    fontSize: 18,
                    color: primaryColor,
                    fontFamily: 'CairoBold'
                  ),
                ),
                MaterialButton(
                  height: 30,
                  onPressed: (){
                  },
                  child: Text('عرض الجميع'),
                  color: Colors.white,
                  textColor: primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: primaryColor
                      ),
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: recentlyViewed.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: BottomShadedCard(
                      meal: recentlyViewed[index],
                      onClick: (){
                        Navigator.pushNamed(context, DetailedMealScreen.id);
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
