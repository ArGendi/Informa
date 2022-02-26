import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:provider/provider.dart';

class WaterInfoBanner extends StatefulWidget {
  const WaterInfoBanner({Key? key}) : super(key: key);

  @override
  _WaterInfoBannerState createState() => _WaterInfoBannerState();
}

class _WaterInfoBannerState extends State<WaterInfoBanner> {
  FirestoreService _firestoreService = new FirestoreService();

  decreaseWater(BuildContext context, AppUser user){
    if(user.dailyWater! >= user.myWater!) return;
    double newValue = user.dailyWater! + 0.250;
    if(newValue > user.myWater!) newValue = user.myWater!;
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyWater(newValue);
    HelpFunction.saveDailyWater(newValue);
  }

  increaseWater(BuildContext context, AppUser user){
    if(user.dailyWater! < 0) return;
    double newValue = user.dailyWater! - 0.250;
    if(newValue < 0.25) newValue = -0.25;
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyWater(newValue);
    HelpFunction.saveDailyWater(newValue);
  }

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.grey.shade200, width: 2)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              'أستهلاك المياة اليومي',
              style: TextStyle(
                fontFamily: boldFont,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ثابت',
                          style: TextStyle(
                            //fontFamily: boldFont,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'مستهلك',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'متبقي',
                          style: TextStyle(
                            //fontFamily: boldFont,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20,),
                    Column(
                      children: [
                        Text(
                          activeUser!.myWater!.toStringAsFixed(1) + ' لتر',
                          style: TextStyle(
                            fontSize: 15,
                            color: primaryColor,
                            fontFamily: boldFont,
                          ),
                        ),
                        Text(
                          (activeUser.myWater! - activeUser.dailyWater!).toStringAsFixed(2) + ' لتر',
                          style: TextStyle(
                            fontSize: 15,
                            color: primaryColor,
                            fontFamily: boldFont,
                          ),
                        ),
                        Text(
                          (activeUser.dailyWater!).toStringAsFixed(1) + ' لتر',
                          style: TextStyle(
                            fontSize: 15,
                            color: activeUser.dailyWater! >= 0 ? primaryColor : Colors.red,
                            fontFamily: boldFont,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            decreaseWater(context, activeUser);
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Image.asset(
                          'assets/images/cup_of_water.png',
                          width: 35,
                        ),
                        IconButton(
                          onPressed: (){
                            increaseWater(context, activeUser);
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                    Text(
                      '250 ملي',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
