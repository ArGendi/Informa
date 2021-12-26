import 'package:flutter/material.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/widgets/countdown_card.dart';

import '../app_localization.dart';
import '../constants.dart';

class HomeBanner extends StatelessWidget {
  final String mainText;
  final String subText;
  final String btnText;
  final VoidCallback onClick;
  final Challenge? challenge;
  final String imagePath;

  const HomeBanner({Key? key, required this.mainText, required this.subText, required this.onClick, required this.btnText, this.challenge, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onClick,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
            image: AssetImage(imagePath,),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization!.translate(mainText).toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'CairoBold',
                  color: Colors.white,
                ),
              ),
              //SizedBox(height: 10,),
              Text(
                localization.translate(subText).toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    height: 1.5,
                ),
              ),
              SizedBox(height: 5,),
              if(challenge != null)
                CountdownCard(
                  deadline: challenge!.deadline!,
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
                    localization.translate(btnText).toString(),
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
      ),
    );
  }
}

