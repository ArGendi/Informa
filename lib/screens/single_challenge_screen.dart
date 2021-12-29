import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/screens/video_player_screen.dart';
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

class _SingleChallengeScreenState extends State<SingleChallengeScreen> with SingleTickerProviderStateMixin{
  var _formKey = GlobalKey<FormState>();
  FirestoreService _firestoreService = new FirestoreService();
  String _first = '';
  String _second = '';
  String _btnText = 'أرسل';
  late Challenge _challenge;
  late AnimationController _controller;
  late Animation<Offset> _btnOffset;

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
        if(_challenge.submits == null){
          _challenge.submits = Map<String, dynamic>();
        }
        _challenge.submits![id] = {
          if(widget.challenge.first != null)
            widget.challenge.first: _first,
          if(widget.challenge.second != null)
            widget.challenge.second: _second,
        };
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _btnOffset = Tween<Offset>(
      begin: Offset(0, 6),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    ));
    Timer(Duration(milliseconds: 300), (){
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                  InkWell(
                    onTap: (){
                      if(widget.challenge.video != null)
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoPlayerScreen(
                            url: widget.challenge.video!,
                          )),
                        );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 160,
                      color: Colors.grey[400],
                      child: widget.challenge.image != null ?
                      Image.network(
                        widget.challenge.image!,
                        fit: BoxFit.cover,
                      ) : Container(),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if(widget.challenge.first != null)
                          CustomTextField(
                            text: widget.challenge.first!,
                            obscureText: false,
                            textInputType: TextInputType.text,
                            setValue: (value){
                              _first = value;
                            },
                            validation: (value){
                              if (value.isEmpty) return 'أدخل ' + widget.challenge.first!;
                              return null;
                            },
                          ),
                        SizedBox(height: 10,),
                        if(widget.challenge.second != null)
                          CustomTextField(
                            text: widget.challenge.second!,
                            obscureText: false,
                            textInputType: TextInputType.text,
                            setValue: (value){
                              _second = value;
                            },
                            validation: (value){
                              if (value.isEmpty) return 'أدخل ' + widget.challenge.second!;
                              return null;
                            },
                          ),
                      ],
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
                  SlideTransition(
                    position: _btnOffset,
                    child: CustomButton(
                      text: _btnText,
                      onClick: (){
                        onSubmit(context);
                      },
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
