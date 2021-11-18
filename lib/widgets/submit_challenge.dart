import 'package:flutter/material.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/widgets/countdown_card.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';

class SubmitChallenge extends StatefulWidget {
  final Challenge challenge;
  const SubmitChallenge({Key? key, required this.challenge}) : super(key: key);

  @override
  _SubmitChallengeState createState() => _SubmitChallengeState();
}

class _SubmitChallengeState extends State<SubmitChallenge> {
  var _formKey = GlobalKey<FormState>();
  String _videoUrl = '';
  String _btnText = 'أرسل';

  onSubmit(){
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid){
      _formKey.currentState!.save();
      print(_videoUrl);
      setState(() {
        _btnText = 'تم';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.challenge.name!,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'CairoBold',
              ),
            ),
            Row(
              children: [
                Text(
                  'متبقي علي نهاية التحدي',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange
                  ),
                ),
                SizedBox(width: 5,),
                CountdownCard(
                  deadline: widget.challenge.deadline!,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.grey[400],
            ),
            SizedBox(height: 10,),
            Form(
              key: _formKey,
              child: CustomTextField(
                text: 'رابط الفيديو',
                obscureText: false,
                textInputType: TextInputType.text,
                anotherFilledColor: true,
                setValue: (value){
                  _videoUrl = value;
                },
                validation: (value){
                  if (value.isEmpty) return 'أدخل رابط الفيديو';
                  return null;
                },
              ),
            ),
            SizedBox(height: 20,),
            Text(
              'تأكد من صلاحية الرابط قبل أرسال التحدي حتي يتم تقيمك بصورة صحيحة',
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600]
              ),
            ),
            SizedBox(height: 10,),
            CustomButton(
              text: _btnText,
              onClick: onSubmit,
            )
          ],
        ),
      ),
    );
  }
}
