import 'package:flutter/material.dart';

import '../constants.dart';

class HomeBanner extends StatelessWidget {
  final String mainText;
  final String subText;
  final String btnText;
  final VoidCallback onClick;

  const HomeBanner({Key? key, required this.mainText, required this.subText, required this.onClick, required this.btnText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/bg_man.jpg',),
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainText,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'CairoBold',
                color: Colors.white,
              ),
            ),
            //SizedBox(height: 10,),
            Text(
              subText,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.5,
              ),
            ),
            SizedBox(height: 10,),
            MaterialButton(
              onPressed: onClick,
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  btnText,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'CairoBold',
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

