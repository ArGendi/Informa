import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/providers/recently_viewed_meals_provider.dart';
import 'package:informa/widgets/bottom_shaded_card.dart';
import 'package:informa/widgets/recently_viewed_banner.dart';
import 'package:informa/widgets/wide_card.dart';
import 'package:provider/provider.dart';

class FreeKitchenScreen extends StatefulWidget {
  const FreeKitchenScreen({Key? key}) : super(key: key);

  @override
  _FreeKitchenScreenState createState() => _FreeKitchenScreenState();
}

class _FreeKitchenScreenState extends State<FreeKitchenScreen> {
  @override
  Widget build(BuildContext context) {
    var recentlyViewedProvider = Provider.of<RecentlyViewedMealsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('مطبخ أنفورما'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          RecentlyViewedBanner(recentlyViewed: recentlyViewedProvider.items!),
          //SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'وصفات الدجاج',
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      '(${recentlyViewedProvider.items!.length}) وصفة',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                WideCard(),
                SizedBox(height: 10,),
                WideCard(),
                SizedBox(height: 10,),
                WideCard(),
                SizedBox(height: 10,),
                WideCard(),
              ],
            ),
          ),
        ],
      )
    );
  }
}
