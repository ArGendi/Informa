import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/countdown_card.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';

import '../constants.dart';

class SingleChallengeScreen extends StatefulWidget {
  static String id = 'single challenge';
  final Challenge challenge;
  const SingleChallengeScreen({Key? key, required this.challenge}) : super(key: key);

  @override
  _SingleChallengeScreenState createState() => _SingleChallengeScreenState(challenge);
}

class _SingleChallengeScreenState extends State<SingleChallengeScreen> {
  var _formKey = GlobalKey<FormState>();
  FirestoreService _firestoreService = new FirestoreService();
  String _videoUrl = '';
  String _btnText = 'أرسل';
  late Challenge _challenge;

  _SingleChallengeScreenState(Challenge ch){
    _challenge = ch;
  }

  onSubmit(BuildContext context) async{
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid){
      _formKey.currentState!.save();
      if(widget.challenge.status == 0){
        var id = FirebaseAuth.instance.currentUser!.uid;
        _challenge.submits![id] = _videoUrl;
        await _firestoreService.submitChallenge(_challenge);
        setState(() {
          _btnText = 'تم';
        });
      }
      else{
        showLanguageBottomSheet(context);
      }
    }
  }

  showLanguageBottomSheet(BuildContext context){
    showModalBottomSheet(
      context: context,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 250,
          child: Center(
            child: Text(
              'هات فلوس',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('تحدي أنفورما'),
        centerTitle: true,
        leading: IconButton(
          splashRadius: splashRadius,
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.challenge.name!,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'CairoBold',
                    ),
                  ),
                  Text(
                    widget.challenge.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 5,),
                  CountdownCard(
                    deadline: widget.challenge.deadline!,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 160,
                    color: Colors.grey[400],
                    child: widget.challenge.url!.isNotEmpty ?
                    Image.network(
                      widget.challenge.url!,
                      fit: BoxFit.cover,
                    ) : Container(),
                  ),
                  SizedBox(height: 10,),
                  Form(
                    key: _formKey,
                    child: CustomTextField(
                      text: 'رابط الفيديو',
                      obscureText: false,
                      textInputType: TextInputType.text,
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
                    onClick: (){
                      onSubmit(context);
                    },
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
