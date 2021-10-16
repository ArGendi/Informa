import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:pinput/pin_put/pin_put.dart';

class EmailConfirmationScreen extends StatefulWidget {
  final String code;
  const EmailConfirmationScreen({Key? key, required this.code}) : super(key: key);

  @override
  _EmailConfirmationScreenState createState() => _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  Color _codeStatusColor = Colors.grey.shade500;

  onSubmit(){
    FocusScope.of(context).unfocus();
    String input = _controller.text.split('').reversed.join();
    if(input == widget.code)
      setState(() {
        _codeStatusColor = Colors.green;
      });
    else
      setState(() {
        _codeStatusColor = Colors.red;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/mailed.png',
                    width: 140,
                  ),
                  SizedBox(height: 15,),
                  Text(
                    'تأكيد البريد الألكتروني',
                    style: TextStyle(
                      fontSize: 24,
                      //height: 0.3
                    ),
                  ),
                  Text(
                    'تم أرسال رمز التأكيد لك, من فضلك تحقق من البريد الوارد وأعد كتابة الرمز لتعيين كلمة المرور',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: PinPut(
                      fieldsCount: 5,
                      controller: _controller,
                      submittedFieldDecoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(200),
                        color: Colors.white,
                      ),
                      selectedFieldDecoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(200),
                        color: Colors.white,
                      ),
                      followingFieldDecoration: BoxDecoration(
                        border: Border.all(color: _codeStatusColor),
                        borderRadius: BorderRadius.circular(200),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  CustomButton(
                    text: 'تأكيد البريد الألكتروني',
                    onClick: onSubmit,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'لم يصل رمز التأكيد؟',
                    style: TextStyle(
                    ),
                  ),
                  TextButton(
                    onPressed: (){},
                    child: Text(
                      'أعد ارسال رمز التأكيد مرة أخرى',
                      style: TextStyle(
                          color: primaryColor,
                        height: 0.2
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}