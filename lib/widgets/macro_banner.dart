import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class MacroBanner extends StatefulWidget {
  const MacroBanner({Key? key}) : super(key: key);

  @override
  _MacroBannerState createState() => _MacroBannerState();
}

class _MacroBannerState extends State<MacroBanner> {
  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Colors.grey.shade200, width: 2)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مخفي',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'ثابت',
                      style: TextStyle(
                        //fontFamily: boldFont,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'مستهلك',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'متبقي',
                      style: TextStyle(
                        //fontFamily: boldFont,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'سعراتك الحرارية',
                      style: TextStyle(
                        fontFamily: boldFont,
                        fontSize: 14
                      ),
                    ),
                    Text(
                      activeUser!.dietType != 2?
                      activeUser.myCalories.toString() :
                      (activeUser.myProtein! * 4 + activeUser.myFats! * 9 + activeUser.lowAndHighCarb![activeUser.carbCycleIndex!] * 4).toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontFamily: boldFont,
                      ),
                    ),
                    Text(
                      (activeUser.myCalories! - activeUser.dailyCalories!).toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontFamily: boldFont,
                      ),
                    ),
                    Text(
                      activeUser.dietType != 2?
                      (activeUser.dailyCalories!).toString():
                      (activeUser.dailyProtein! * 4 + activeUser.dailyFats! * 9 + activeUser.dailyCarbCycle! * 4).toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontFamily: boldFont,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: 1,
              height: double.maxFinite,
              color: Colors.grey[300],
            ),
            //protein
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'البروتين',
                  style: TextStyle(
                      fontFamily: boldFont,
                      fontSize: 14
                  ),
                ),
                Text(
                  activeUser.myProtein.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontFamily: boldFont,
                  ),
                ),
                Text(
                  (activeUser.myProtein! - activeUser.dailyProtein!).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                    fontFamily: boldFont,
                  ),
                ),
                Text(
                  (activeUser.dailyProtein!).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontFamily: boldFont,
                  ),
                ),
              ],
            ),
            //carb
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'الكارب',
                  style: TextStyle(
                      fontFamily: boldFont,
                      fontSize: 14
                  ),
                ),
                Text(
                  activeUser.dietType != 2 ? activeUser.myCarb.toString() :
                    activeUser.lowAndHighCarb![activeUser.carbCycleIndex!].toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontFamily: boldFont,
                  ),
                ),
                Text(
                  activeUser.dietType != 2 ?
                  (activeUser.myCarb! - activeUser.dailyCarb!).toString() :
                  (activeUser.lowAndHighCarb![activeUser.carbCycleIndex!] - activeUser.dailyCarbCycle).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                    fontFamily: boldFont,
                  ),
                ),
                Text(
                  activeUser.dietType != 2 ?
                  (activeUser.dailyCarb!).toString() : activeUser.dailyCarbCycle.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontFamily: boldFont,
                  ),
                ),
              ],
            ),
            //fats
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'الدهون',
                  style: TextStyle(
                      fontFamily: boldFont,
                      fontSize: 14
                  ),
                ),
                Text(activeUser.myFats.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontFamily: boldFont,
                  ),
                ),
                Text(
                  (activeUser.myFats! - activeUser.dailyFats!).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                    fontFamily: boldFont,
                  ),
                ),
                Text(
                  (activeUser.dailyFats!).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontFamily: boldFont,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
