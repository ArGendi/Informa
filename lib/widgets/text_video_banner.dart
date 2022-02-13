import 'package:flutter/material.dart';
import 'package:informa/screens/video_player_screen.dart';

import '../constants.dart';

class TextVideoBanner extends StatelessWidget {
  final String text;
  final String videoLink;
  const TextVideoBanner({Key? key, required this.text, required this.videoLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideoPlayerScreen(
            url: videoLink,
          )),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: boldFont,
            ),
          ),
          Card(
            elevation: 0,
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
