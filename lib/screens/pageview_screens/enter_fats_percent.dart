import 'package:flutter/material.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/custom_button.dart';

class FatsPercent extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onGetImages;
  final VoidCallback onNext;
  final bool? isLoading;
  const FatsPercent({Key? key, required this.onBack, required this.onGetImages, required this.onNext, this.isLoading = false,}) : super(key: key);

  @override
  _FatsPercentState createState() => _FatsPercentState();
}

class _FatsPercentState extends State<FatsPercent> {
  String _fatPercent = '';
  var _formKey = GlobalKey<FormState>();
  FirestoreService _firestoreService = new FirestoreService();

  onSubmit(BuildContext context){
    FocusScope.of(context).unfocus();
    var valid = _formKey.currentState!.validate();
    if(valid){
      _formKey.currentState!.save();
      Provider.of<ActiveUserProvider>(context, listen: false).setFatPercent(int.parse(_fatPercent.trim()));
      widget.onNext();
    }
  }
  //
  // onConfirm(BuildContext context) async{
  //   bool done = true;
  //   var activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
  //   setState(() { _isLoading = true; });
  //   await _firestoreService.saveNewAccountWithFullInfo(activeUser!).catchError((e){
  //     setState(() { _isLoading = false; });
  //     done = false;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('حدث خطأ'))
  //     );
  //   });
  //   if(done) {
  //     await activeUser.saveInSharedPreference();
  //     await HelpFunction.saveInitScreen(MainScreen.id);
  //     setState(() { _isLoading = false; });
  //     Navigator.of(context)
  //         .pushNamedAndRemoveUntil(MainScreen.id, (Route<dynamic> route) => false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var activeUserProvider = Provider.of<ActiveUserProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                          border: Border.all(color: primaryColor),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/coach_face.jpg'),
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'محتاجين نعرف عنك معلومات أكتر',
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
                      'قولنا نسبة دهونك',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'CairoBold'
                      ),
                    ),
                    SizedBox(height: 25,),
                    CustomTextField(
                      text: 'نسبة الدهون',
                      obscureText: false,
                      textInputType: TextInputType.number,
                      anotherFilledColor: true,
                      setValue: (value){
                        _fatPercent = value;
                      },
                      validation: (value){
                        if (value.isEmpty) return 'أدخل نسبة الدهون';
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      borderRadius: BorderRadius.circular(borderRadius),
                      onTap: widget.onGetImages,
                      child: Container(
                        width: screenSize.width,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'لا أعرف نسبة الدهون',
                              style: TextStyle(
                                  fontSize: 16,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onClick: (){
              onSubmit(context);
            },
            isLoading: widget.isLoading!,
          )
        ],
      ),
    );
  }
}
