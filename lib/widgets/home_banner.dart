import 'package:flutter/material.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/widgets/countdown_card.dart';

import '../constants.dart';

class HomeBanner extends StatelessWidget {
  final String mainText;
  final String subText;
  final String btnText;
  final VoidCallback onClick;
  final Challenge? challenge;

  const HomeBanner({Key? key, required this.mainText, required this.subText, required this.onClick, required this.btnText, this.challenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/bg_man.jpg',),
        ),
        borderRadius: BorderRadius.circular(borderRadius)
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
            SizedBox(height: 5,),
            if(challenge != null)
              Row(
                children: [
                  Text(
                    'متبقي علي نهاية التحدي',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange
                    ),
                  ),
                  SizedBox(width: 5,),
                  CountdownCard(
                    deadline: challenge!.deadline!,
                  ),
                ],
              ),
            SizedBox(height: 5,),
            MaterialButton(
              onPressed: onClick,
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  btnText,
                  style: TextStyle(
                    fontSize: 14,
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

