import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class MealInfoBox extends StatefulWidget {
  final String text;
  final int value;
  final double percent;
  const MealInfoBox({Key? key, required this.text, required this.value, required this.percent}) : super(key: key);

  @override
  _MealInfoBoxState createState() => _MealInfoBoxState();
}

class _MealInfoBoxState extends State<MealInfoBox> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return Column(
      children: [
        Container(
          width: screenSize.width * .16,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
            ),
          ),
          child: activeUser!.premium ? Center(
            child: Text(
              widget.value.toString(),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600]
              ),
            ),
          ) : Icon(
            Icons.lock,
            color: Colors.grey[600],
            size: 15,
          ),
        ),
        LinearPercentIndicator(
          width: screenSize.width * .2,
          animation: true,
          lineHeight: 3.0,
          animationDuration: 1000,
          percent: activeUser.premium ? widget.percent : 0,
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: Colors.grey[600],
        ),
        Text(
          widget.text,
          style: TextStyle(
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
