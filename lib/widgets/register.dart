import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/services/auth_service.dart';
import 'package:informa/services/country_code_service.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'custom_button.dart';

class Register extends StatefulWidget {
  final VoidCallback onClick;
  const Register({Key? key, required this.onClick}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _password = '';
  String _phoneNumber = '';
  String _dialCode = '20';
  bool _isLoading = false;
  String _flag = 'https://flagcdn.com/w320/eg.png';
  FirestoreService _firestoreService = new FirestoreService();
  CountryCodeService _countryCodeService = new CountryCodeService();

  showSelectCountryBottomSheet(List data){
    showModalBottomSheet(
      context: context,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        _flag = data[index]['flags']['png'];
                        _dialCode = data[index]['callingCodes'][0];
                      });
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.network(
                                data[index]['flags']['png'],
                                width: 40.0,
                              ),
                              SizedBox(width: 10,),
                              Text('+' + data[index]['callingCodes'][0]),
                            ],
                          ),
                          Flexible(
                            child: Text(
                              data[index]['name'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 10,),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<UserCredential?> createAccount() async{
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email.trim(), password: _password);
      return credential;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('رقم المرور ضعيف'))
        );
        return null;
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('الحساب موجود بالفعل'))
        );
        return null;
      }
    }
    return null;
  }

  onSubmit(BuildContext context) async{
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    bool valid = _formKey.currentState!.validate();
    if(valid){
      bool fromSocialMedia = Provider.of<ActiveUserProvider>(context, listen: false).user!.fromSocialMedia;
      if(!fromSocialMedia){
        setState(() { _isLoading = true; });
        var credential = await createAccount();
        if(credential != null) {
          Provider.of<ActiveUserProvider>(context, listen: false).setId(credential.user!.uid);
          Provider.of<ActiveUserProvider>(context, listen: false).setName(_fullName);
          Provider.of<ActiveUserProvider>(context, listen: false).setEmail(_email.trim());
          Provider.of<ActiveUserProvider>(context, listen: false).setPassword(_password);
          AppUser user =  Provider.of<ActiveUserProvider>(context, listen: false).user!;
          await _firestoreService.saveNewAccount(user);
          setState(() { _isLoading = false; });
          widget.onClick();
        }
        else{
          setState(() { _isLoading = false; });
          return;
        }
      }
      Provider.of<ActiveUserProvider>(context, listen: false).setPhoneNumber("+" + _dialCode + _phoneNumber);
      widget.onClick();
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 40,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'أهلا بك معانا',
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
                      activeUser!.fromSocialMedia ? 'أدخل رقم الهاتف' : 'أدخل البيانات التالية',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'CairoBold'
                      ),
                    ),
                    SizedBox(height: 25,),
                    if(!activeUser.fromSocialMedia)
                      Column(
                        children: [
                          CustomTextField(
                            text: 'الأسم كامل',
                            obscureText: false,
                            textInputType: TextInputType.text,
                            setValue: (value){
                              _fullName = value;
                            },
                            validation: (value){
                              if(value.isEmpty) return 'ادخل الأسم';
                              return null;
                            },
                          ),
                          SizedBox(height: 10,),
                          CustomTextField(
                            text: 'البريد الألكتروني',
                            obscureText: false,
                            textInputType: TextInputType.emailAddress,
                            setValue: (value){
                              _email = value;
                            },
                            validation: (value){
                              if (value.isEmpty) return 'أدخل البريد الألكتروني';
                              if (!value.contains('@') || !value.contains('.'))
                                return 'بريد الكتروني خاطىء';
                              return null;
                            },
                          ),
                          SizedBox(height: 10,),
                          CustomTextField(
                            text: 'كلمة المرور',
                            obscureText: true,
                            textInputType: TextInputType.text,
                            setValue: (value){
                              _password = value;
                            },
                            validation: (value){
                              if (value.isEmpty) return 'أدخل كلمة المرور';
                              if (value.length < 6) return 'كلمة المرور قصيرة';
                              return null;
                            },
                          ),
                          SizedBox(height: 10,),
                          CustomTextField(
                            text: 'تأكيد كلمة المرور',
                            obscureText: true,
                            textInputType: TextInputType.text,
                            setValue: (value){},
                            validation: (value){
                              if (value.isEmpty) return 'أدخل كلمة المرور';
                              if(_password != value) return 'كلمة المرور غير متطابقة';
                              return null;
                            },
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    Row(
                      children: [
                        // CountryCodePicker(
                        //   onChanged: (value){
                        //     _dialCode = value.dialCode!;
                        //   },
                        //   initialSelection: 'EG',
                        //   showCountryOnly: false,
                        //   showOnlyCountryWhenClosed: false,
                        //   alignLeft: false,
                        // ),
                        FutureBuilder(
                          future: _countryCodeService.getAllCountries(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.hasData) {
                              var data = snapshot.data;
                              print(data);
                              return InkWell(
                                onTap: (){
                                  showSelectCountryBottomSheet(data);
                                },
                                child: Container(
                                  width: 80,
                                  height: 45,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          _flag,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text('+' + _dialCode),
                                    ],
                                  ),
                                ),
                              );
                            }
                            else return Container(
                              width: 80,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: CustomTextField(
                            text: 'رقم الهاتف',
                            obscureText: false,
                            textInputType: TextInputType.phone,
                            setValue: (value){
                              _phoneNumber = value;
                            },
                            validation: (value){
                              if(value.isEmpty) return 'أدخل رقم الهاتف';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
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
            isLoading: _isLoading,
          )
        ],
      ),
    );
  }
}
