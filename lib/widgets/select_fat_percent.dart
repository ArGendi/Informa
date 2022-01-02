import 'package:flutter/material.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/body_fat_card.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'custom_button.dart';

class SelectFatPercent extends StatefulWidget {
  final VoidCallback onBack;
  const SelectFatPercent({Key? key, required this.onBack}) : super(key: key);

  @override
  _SelectFatPercentState createState() => _SelectFatPercentState();
}

class _SelectFatPercentState extends State<SelectFatPercent> {
  bool _isLoading = false;
  FirestoreService _firestoreService = new FirestoreService();

  onConfirm(BuildContext context) async{
    bool done = true;
    var activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
    setState(() { _isLoading = true; });
    await _firestoreService.saveNewAccountWithFullInfo(activeUser!).catchError((e){
      setState(() { _isLoading = false; });
      done = false;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ'))
      );
    });
    if(done) {
      await activeUser.saveInSharedPreference();
      await HelpFunction.saveInitScreen(MainScreen.id);
      setState(() { _isLoading = false; });
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainScreen.id, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: widget.onBack,
                        icon: Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(color: Colors.grey.shade300),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/coach_face.jpg'),
                        )
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'نسبة الدهون في جسمك',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    color: Colors.grey[600],
                    indent: screenSize.width * .3,
                    endIndent: screenSize.width * .3,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'اختار الجسم الأقرب لجسمك',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CairoBold'
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/6.PNG',
                          percent: 6,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/10.PNG',
                          percent: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/15.PNG',
                          percent: 15,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/20.PNG',
                          percent: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/25.PNG',
                          percent: 25,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/30.PNG',
                          percent: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/35.PNG',
                          percent: 35,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: BodyFatCard(
                          imagePath: 'assets/images/body_fat/40.PNG',
                          percent: 40,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: activeUser!.fatsPercent != 0? (){
              onConfirm(context);
            } : (){},
            bgColor: activeUser.fatsPercent != 0? primaryColor : Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
