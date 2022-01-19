import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/screens/premium_screens/ready_fill_premium_form_screen.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../constants.dart';

class SalesPaymentScreen extends StatefulWidget {
  static String id = 'sales payment';
  const SalesPaymentScreen({Key? key}) : super(key: key);

  @override
  _SalesPaymentScreenState createState() => _SalesPaymentScreenState();
}

class _SalesPaymentScreenState extends State<SalesPaymentScreen> {
  String _activateCode = '';
  var _formKey = GlobalKey<FormState>();
  FirestoreService _firestoreService = new FirestoreService();
  bool _isLoading = false;

  onShare(){
    String id = FirebaseAuth.instance.currentUser!.uid;
    Share.share(id);
  }

  onActivate(BuildContext context) async{
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid){
      _formKey.currentState!.save();
      setState(() { _isLoading = true; });
      String id = FirebaseAuth.instance.currentUser!.uid;
      String? originalCode = await _firestoreService.getUserActivateCode(id);
      if(originalCode != null){
        if(_activateCode.trim() == originalCode.trim()){
          await Provider.of<ActiveUserProvider>(context, listen: false).setPremium(true, id);
          await HelpFunction.saveUserPremium(true);
          setState(() { _isLoading = false; });
          Navigator.pushNamed(context, ReadyFillPremiumForm.id);
        }
      }
      else ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('انت غير مشترك من فضلك تواصل مع فريق الدعم'))
      );
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طرق الدفع'),
        centerTitle: true,
        elevation: 0,
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'تقدر تتواصل مع فريق المبيعات وتدفع عن طريق فودافون كاش او تحويل بنكي',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: boldFont,
                  ),
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'التحدث مع فريق المبيعات',
                      style: TextStyle(),
                    ),
                    SizedBox(height: 5,),
                    InkWell(
                      borderRadius: BorderRadius.circular(borderRadius),
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(borderRadius),
                          border: Border.all(color: Colors.grey.shade300,),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.whatsapp,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'التحدث الي فريق المبيعات',
                                style: TextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      'أرسل الكود الخاص بيك لفريق المبيعات',
                      style: TextStyle(),
                    ),
                    Text(
                      'هذا الكود خاص بحسابك تقوم بأرساله لفريق المبيعات عند طلبهم منك',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 5,),
                    InkWell(
                      borderRadius: BorderRadius.circular(borderRadius),
                      onTap: onShare,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(borderRadius),
                          border: Border.all(color: Colors.grey.shade300,),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.share,
                                color: primaryColor,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'أرسال الكود',
                                style: TextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ],
            ),
            CustomButton(
              text: 'تم',
              //isLoading: _isLoading,
              onClick: (){
                Navigator.popUntil(context, ModalRoute.withName(MainScreen.id));
              },
            ),
          ],
        ),
      ),
    );
  }
}
