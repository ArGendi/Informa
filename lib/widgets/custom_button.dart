import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onClick;
  final bool isLoading;
  final Color bgColor;
  final bool? iconExist;

  const CustomButton({Key? key, required this.text, required this.onClick, this.isLoading = false, this.bgColor = primaryColor, this.iconExist}) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      borderRadius: BorderRadius.circular(borderRadius),
      child: AnimatedContainer(
        width: double.infinity,
        decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(borderRadius)
        ),
        duration: Duration(milliseconds: 400),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: !widget.isLoading ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),
              ),
              SizedBox(width: 10,),
              if(widget.iconExist == null || widget.iconExist == true)
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ],
          ) : Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
