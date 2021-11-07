import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:provider/provider.dart';

class ProgramSelectCard extends StatefulWidget {
  final VoidCallback onClick;
  final String mainText;
  final String subText;
  final int number;
  final int userChoice;

  const ProgramSelectCard({Key? key, required this.onClick, required this.mainText, required this.subText, required this.number, required this.userChoice}) : super(key: key);

  @override
  _ProgramSelectCardState createState() => _ProgramSelectCardState();
}

class _ProgramSelectCardState extends State<ProgramSelectCard> {
  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return InkWell(
      borderRadius: BorderRadius.circular(7),
      onTap: widget.onClick,
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
                color: widget.userChoice == widget.number? primaryColor : Colors.white,
                width: 2
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               widget.mainText,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'CairoBold'
                ),
              ),
              Text(
                widget.subText,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
