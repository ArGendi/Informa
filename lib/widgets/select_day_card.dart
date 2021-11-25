import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SelectDayCard extends StatefulWidget {
  final String text;
  final int id;
  const SelectDayCard({Key? key, required this.text, required this.id}) : super(key: key);

  @override
  _SelectDayCardState createState() => _SelectDayCardState();
}

class _SelectDayCardState extends State<SelectDayCard> {
  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: (){
        if(!activeUser!.trainingDays.contains(widget.id))
          Provider.of<ActiveUserProvider>(context, listen: false).
          addTrainingDay(widget.id);
        else
          Provider.of<ActiveUserProvider>(context, listen: false).
          removeTrainingDay(widget.id);
      },
      child: Container(
        width: 80,
        height: 42,
        decoration: BoxDecoration(
          color: activeUser!.trainingDays.contains(widget.id) ? primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                color: activeUser.trainingDays.contains(widget.id) ? Colors.white : Colors.grey[700],
                fontSize: 15
            ),
          ),
        ),
      ),
    );
  }
}
