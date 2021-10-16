import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onClick;

  const CustomButton({Key? key, required this.text, required this.onClick}) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      borderRadius: BorderRadius.circular(30),
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(30)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              SizedBox(width: 10,),
              Text(
                widget.text,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
