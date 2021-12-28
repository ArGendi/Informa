import 'package:flutter/material.dart';

import '../constants.dart';

class ProgramCard extends StatefulWidget {
  final int id;
  final int selected;
  final String mainText;
  final String description;
  final VoidCallback onClick;
  const ProgramCard({Key? key, required this.id, required this.selected, required this.onClick, required this.mainText, required this.description}) : super(key: key);

  @override
  _ProgramCardState createState() => _ProgramCardState();
}

class _ProgramCardState extends State<ProgramCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: widget.id == widget.selected ? primaryColor : Colors.grey.shade300,
            width: widget.id == widget.selected ? 2 : 1,
          )
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: widget.onClick,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.mainText,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: boldFont,
                  ),
                ),
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
