import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SalesPaymentScreen extends StatefulWidget {
  static String id = 'sales payment';
  const SalesPaymentScreen({Key? key}) : super(key: key);

  @override
  _SalesPaymentScreenState createState() => _SalesPaymentScreenState();
}

class _SalesPaymentScreenState extends State<SalesPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طرق الدفع'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          splashRadius: splashRadius,
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              'تقدر تتواصل مع فريق المبيعات وتدفع عن طريق فودافون كاش او تحويل بنكي',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: boldFont,
              ),
            ),
            SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أرسال الكود الخاص بيك لفريق المبيعات',
                  style: TextStyle(),
                ),
                SizedBox(height: 5,),
                InkWell(
                  borderRadius: BorderRadius.circular(borderRadius),
                  onTap: (){},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(color: Colors.grey.shade300,),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.message,
                            color: primaryColor,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            'أرسال الكود',
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    ),
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
