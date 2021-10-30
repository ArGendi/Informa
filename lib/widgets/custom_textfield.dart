import 'package:flutter/material.dart';
import 'package:informa/constants.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final bool obscureText;
  final TextInputType textInputType;
  final Function(String textInput) setValue;
  final Function(String value) validation;
  final bool anotherFilledColor;

  const CustomTextField({Key? key, required this.text, required this.obscureText, required this.textInputType, required this.setValue, required this.validation, this.anotherFilledColor = false}) : super(key: key);

  @override
  _CustomTextFieldState createState() =>
      _CustomTextFieldState(obscureText: obscureText);
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _visibility = false;
  bool obscureText;

  _CustomTextFieldState({required this.obscureText});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.grey.shade600,
      keyboardType: widget.textInputType,
      style: TextStyle(color: Colors.grey.shade600),
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: widget.obscureText ? IconButton(
          icon: Icon(!_visibility ? Icons.visibility_off : Icons.visibility),
          color: Colors.grey.shade500,
          onPressed: () {
            setState(() {
              _visibility = !_visibility;
              obscureText = !obscureText;
            });
          },
        ) : null,
        labelText: widget.text,
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade500,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        focusColor: widget.anotherFilledColor ? Colors.white : Colors.grey.shade100,
        fillColor: widget.anotherFilledColor ? Colors.white : Colors.grey.shade100,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            //width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            //width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.red,
            //width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.red,
            //width: 2.0,
          ),
        ),
      ),
      onSaved: (value){
        widget.setValue(value!);
      },
      validator: (value){
        return widget.validation(value!);
      },
    );
  }
}
