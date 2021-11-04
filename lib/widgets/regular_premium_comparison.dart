import 'package:flutter/material.dart';

import '../constants.dart';

class RegularPremiumComparison extends StatefulWidget {
  const RegularPremiumComparison({Key? key}) : super(key: key);

  @override
  _RegularPremiumComparisonState createState() => _RegularPremiumComparisonState();
}

class _RegularPremiumComparisonState extends State<RegularPremiumComparison> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'أنفورما',
                      style: TextStyle(
                        fontFamily: 'CairoBold',
                      ),
                    ),
                    Card(
                      elevation: 0,
                      color: primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'بريميم',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: 30,),
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.green[200],
                  child: Icon(
                    Icons.check,
                    color: Colors.green[600],
                    size: 22,
                  ),
                ),
                Divider(height: 30,),
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.green[200],
                  child: Icon(
                    Icons.check,
                    color: Colors.green[600],
                    size: 22,
                  ),
                ),
                Divider(height: 30,),
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.green[200],
                  child: Icon(
                    Icons.check,
                    color: Colors.green[600],
                    size: 22,
                  ),
                ),
                Divider(height: 30,),
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.green[200],
                  child: Icon(
                    Icons.check,
                    color: Colors.green[600],
                    size: 22,
                  ),
                ),
              ],
            ),
            SizedBox(width: 20,),
            Column(
              children: [
                Text(
                  'أنفورما',
                  style: TextStyle(
                    //fontFamily: 'CairoBold',
                  ),
                ),
                Divider(height: 30,),
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.red[200],
                  child: Icon(
                    Icons.clear,
                    color: Colors.red[600],
                    size: 22,
                  ),
                ),
                Divider(height: 30,),
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.red[200],
                  child: Icon(
                    Icons.clear,
                    color: Colors.red[600],
                    size: 22,
                  ),
                ),
                Divider(height: 30,),
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.red[200],
                  child: Icon(
                    Icons.clear,
                    color: Colors.red[600],
                    size: 22,
                  ),
                ),
                Divider(height: 30,),
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.red[200],
                  child: Icon(
                    Icons.clear,
                    color: Colors.red[600],
                    size: 22,
                  ),
                ),
              ],
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'أنفورما',
                    style: TextStyle(
                      color: bgColor
                    ),
                  ),
                  Divider(height: 30,),
                  Text(
                    'تسجيل ومتابعة اوزانك وتغييرات جسمك',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Divider(height: 30,),
                  Text(
                    'تسجيل ومتابعة اوزانك وتغييرات جسمك',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Divider(height: 30,),
                  Text(
                    'تسجيل ومتابعة اوزانك وتغييرات جسمك',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Divider(height: 30,),
                  Text(
                    'تسجيل ومتابعة اوزانك وتغييرات جسمك',
                    style: TextStyle(
                      fontSize: 12,
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
