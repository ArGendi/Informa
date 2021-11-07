import 'package:flutter/material.dart';

class AdvantageRow extends StatelessWidget {
  final String text;

  const AdvantageRow({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20,),
        CircleAvatar(
          radius: 13,
          backgroundColor: Colors.green[200],
          child: Icon(
            Icons.check,
            color: Colors.green[600],
            size: 22,
          ),
        ),
        SizedBox(width: 75,),
        CircleAvatar(
          radius: 13,
          backgroundColor: Colors.red[200],
          child: Icon(
            Icons.clear,
            color: Colors.red[600],
            size: 22,
          ),
        ),
        SizedBox(width: 30,),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
