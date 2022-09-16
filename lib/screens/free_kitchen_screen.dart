import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/kitchen_provider.dart';
import 'package:informa/providers/recently_viewed_meals_provider.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/widgets/meal_category_card.dart';
import 'package:informa/widgets/recently_viewed_banner.dart';
import 'package:provider/provider.dart';

class FreeKitchenScreen extends StatefulWidget {
  static String id = 'free kitchen';
  const FreeKitchenScreen({Key? key}) : super(key: key);

  @override
  _FreeKitchenScreenState createState() => _FreeKitchenScreenState();
}

class _FreeKitchenScreenState extends State<FreeKitchenScreen> {
  @override
  Widget build(BuildContext context) {
    var recentlyViewedProvider =
        Provider.of<RecentlyViewedMealsProvider>(context);
    var kitchenProvider = Provider.of<KitchenProvider>(context);
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: Text('مطبخ انفورما'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            splashRadius: splashRadius,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          actions: [
            IconButton(
              splashRadius: splashRadius,
              onPressed: () {
                if (!activeUser!.premium) {
                  Navigator.pushNamed(context, PlansScreen.id);
                }
              },
              icon: Icon(
                Icons.bookmark_outlined,
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/appBg.png'))),
          child: ListView(
            children: [
              if (recentlyViewedProvider.items!.isNotEmpty)
                RecentlyViewedBanner(
                    recentlyViewed: recentlyViewedProvider.items!),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'أقسام الأكل',
                      style: TextStyle(
                        fontFamily: boldFont,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    for (var category in kitchenProvider.items!)
                      Column(
                        children: [
                          MealCategoryCard(
                            mealCategory: category,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //   child: Column(
              //     children: [
              //       //Loop for categories
              //       for(var category in kitchenProvider.items!)
              //       Column(
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text(
              //                 category.name!,
              //                 style: TextStyle(
              //                   fontSize: 16,
              //                   fontFamily: 'CairoBold',
              //                 ),
              //               ),
              //               Text(
              //                 '(${category.meals!.length}) وصفة',
              //                 style: TextStyle(
              //                   fontSize: 16,
              //                   color: Colors.grey,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           SizedBox(height: 10,),
              //           //Loop for meals inside category
              //           for(var meal in category.meals!)
              //           Column(
              //             children: [
              //               WideCard(meal: meal,),
              //               SizedBox(height: 10,),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ));
  }
}
