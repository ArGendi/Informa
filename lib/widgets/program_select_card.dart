import 'package:flutter/material.dart';
import 'package:informa/constants.dart';

class ProgramSelectCard extends StatefulWidget {
  final VoidCallback onClick;
  final String mainText;
  final String? subText;
  final int number;
  final int userChoice;
  final String? imagePath;
  final Color? borderColor;

  const ProgramSelectCard(
      {Key? key,
      required this.onClick,
      required this.mainText,
      this.subText,
      required this.number,
      required this.userChoice,
      this.imagePath,
      this.borderColor})
      : super(key: key);

  @override
  _ProgramSelectCardState createState() => _ProgramSelectCardState();
}

class _ProgramSelectCardState extends State<ProgramSelectCard> {
  @override
  Widget build(BuildContext context) {
    // var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return InkWell(
      borderRadius: BorderRadius.circular(7),
      onTap: widget.onClick,
      child: AnimatedContainer(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: widget.userChoice == widget.number
                  ? primaryColor
                  : widget.borderColor != null
                      ? widget.borderColor!
                      : Colors.grey.shade300,
              width: widget.userChoice == widget.number ? 2 : 1,
            )),
        duration: Duration(milliseconds: 400),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.mainText,
                      style: TextStyle(
                        fontSize: widget.subText != null ? 16 : null,
                        fontFamily: widget.subText != null ? boldFont : null,
                      ),
                    ),
                    if (widget.subText != null)
                      Text(
                        widget.subText!,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                  ],
                ),
              ),
              if (widget.imagePath != null)
                Image.asset(
                  widget.imagePath!,
                  width: 60,
                  height: 50,
                  fit: BoxFit.cover,
                )
            ],
          ),
        ),
      ),
    );
  }
}
