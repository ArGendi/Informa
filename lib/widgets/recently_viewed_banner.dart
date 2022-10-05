import 'package:flutter/material.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/screens/single_meal_screen.dart';

import 'bottom_shaded_card.dart';

class RecentlyViewedBanner extends StatelessWidget {
  final List<Meal> recentlyViewed;

  const RecentlyViewedBanner({Key? key, required this.recentlyViewed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'تم عرضه مؤخرا',
                  style: TextStyle(fontSize: 16, fontFamily: 'CairoBold'),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: recentlyViewed.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: BottomShadedCard(
                      meal: recentlyViewed[index],
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleMealScreen(
                                    meal: recentlyViewed[index],
                                  )),
                        );
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
