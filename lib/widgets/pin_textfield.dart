import 'package:flutter/material.dart';

class PinTextField extends StatefulWidget {
  const PinTextField({Key? key}) : super(key: key);

  @override
  _PinTextFieldState createState() => _PinTextFieldState();
}

class _PinTextFieldState extends State<PinTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade500),
          borderRadius: BorderRadius.circular(200)
      ),
      child: TextFormField(
        cursorColor: Colors.grey.shade600,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.grey.shade600),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade500,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
        onSaved: (value){},
        validator: (value){},
      ),
    );
  }
}
