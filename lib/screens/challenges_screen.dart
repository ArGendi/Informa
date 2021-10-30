import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';

class ChallengesScreen extends StatefulWidget {
  final Challenge challenge;

  const ChallengesScreen({Key? key, required this.challenge}) : super(key: key);

  @override
  _ChallengesScreenState createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('تحديات أنفورما'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
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
                            fontSize: 13,
                            color: Colors.orange
                          ),
                        ),
                        SizedBox(width: 5,),
                        Card(
                          elevation: 0,
                          color: Colors.orange,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: CountdownTimer(
                                endTime: widget.challenge.deadline!.millisecondsSinceEpoch,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                                ),
                                endWidget: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    'أنتهى التحدي',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: double.infinity,
                      height: 200,
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
            ),
          ],
        ),
      ),
    );
  }
}
