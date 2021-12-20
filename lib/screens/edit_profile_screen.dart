import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class EditProfileScreen extends StatefulWidget {
  static String id = 'edit profile';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var _personalInfoKey = GlobalKey<FormState>();
  var _accountInfoKey = GlobalKey<FormState>();
  String _name = '';
  String _age = '';
  String _tall = '';
  String _weight = '';
  String _fatsPercent = '';
  String _gender = 'ذكر';
  String _email = '';
  String _password = '';
  bool _isChangeHappen = false;
  bool _isNameChanged = false;
  bool _isAgeChanged = false;
  bool _isTallChanged = false;
  bool _isWeightChanged = false;
  bool _isFatsPercentChanged = false;
  bool _isGenderChanged = false;
  bool _isEmailChanged = false;
  bool _isPasswordChanged = false;

  onSaveChanges(BuildContext context){
    FocusScope.of(context).unfocus();
    bool personalValid = _personalInfoKey.currentState!.validate();
    bool accountValid = _accountInfoKey.currentState!.validate();
    if(personalValid && accountValid){
      _personalInfoKey.currentState!.save();
      _accountInfoKey.currentState!.save();
      print("--> " + _name);
      print("--> " + _age);
      print("--> " + _tall);
      print("--> " + _weight);
      print("--> " + _fatsPercent);
      print("--> " + _gender);
      print("--> " + _email);
      //print("--> " + _name);
      showConfirmationAlertDialog(context);
    }
  }

  Future checkChangesAndUpdateInFirebase(BuildContext context) async{
    Map<String, dynamic> map = new Map();
    String? name = Provider.of<ActiveUserProvider>(context, listen: false)
        .user!.name;
    String? age = Provider.of<ActiveUserProvider>(context, listen: false)
        .user!.age.toString();
    String? tall = Provider.of<ActiveUserProvider>(context, listen: false)
        .user!.tall.toString();
    String? weight = Provider.of<ActiveUserProvider>(context, listen: false)
        .user!.weight.toString();
    String? fatsPercent = Provider.of<ActiveUserProvider>(context, listen: false)
        .user!.fatsPercent.toString();
    int? gender = Provider.of<ActiveUserProvider>(context, listen: false)
        .user!.gender;
    String? email = Provider.of<ActiveUserProvider>(context, listen: false)
        .user!.email;

    int iGender = _gender == 'ذكر'? 1 : 2;

    if(name != _name.trim()){
      map['name'] = _name;
      Provider.of<ActiveUserProvider>(context, listen: false).setName(_name);
      HelpFunction.saveUserName(_name);
      _isChangeHappen = true;
    }
    if(age != _age.trim()){
      print('age: ' + _age.trim());
      map['age'] = int.parse(_age.trim());
      Provider.of<ActiveUserProvider>(context, listen: false).setAge(int.parse(_age.trim()));
      HelpFunction.saveUserAge(int.parse(_age.trim()));
      _isChangeHappen = true;
    }
    if(tall != _tall.trim()){
      map['tall'] = int.parse(_tall.trim());
      Provider.of<ActiveUserProvider>(context, listen: false).setTall(int.parse(_tall.trim()));
      HelpFunction.saveUserTall(int.parse(_tall.trim()));
      _isChangeHappen = true;
    }
    if(weight != _weight.trim()){
      map['weight'] = int.parse(_weight.trim());
      Provider.of<ActiveUserProvider>(context, listen: false).setWeight(int.parse(_weight.trim()));
      HelpFunction.saveUserWeight(int.parse(_weight.trim()));
      _isChangeHappen = true;
    }
    if(fatsPercent != _fatsPercent.trim()){
      map['fatsPercent'] = int.parse(_fatsPercent.trim());
      Provider.of<ActiveUserProvider>(context, listen: false).setFatPercent(int.parse(_fatsPercent.trim()));
      HelpFunction.saveUserFatsPercent(int.parse(_fatsPercent.trim()));
      _isChangeHappen = true;
    }
    if(gender != iGender){
      map['gender'] = iGender;
      Provider.of<ActiveUserProvider>(context, listen: false).setGender(iGender);
      HelpFunction.saveUserGender(iGender);
      _isChangeHappen = true;
    }
    if(email != _email.trim()){
      map['email'] = _email.trim();
      Provider.of<ActiveUserProvider>(context, listen: false).setEmail(_email.trim());
      HelpFunction.saveUserEmail(_email.trim());
      await FirebaseAuth.instance.currentUser!.updateEmail(_email.trim());
      _isChangeHappen = true;
    }
    if(_password.isNotEmpty){
      await FirebaseAuth.instance.currentUser!.updatePassword(_password);
    }
    if(_isChangeHappen){
      var id = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users')
          .doc(id)
          .update(map)
          .catchError((e){
        print(e);
      });
    }
  }

  showConfirmationAlertDialog(BuildContext context) async{
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('متأكد من تغيير بيناتك ؟'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'ألغاء',
              style: TextStyle(
                color: Colors.red
              ),
            ),
          ),
          TextButton(
            onPressed: () async{
              await checkChangesAndUpdateInFirebase(context);
              Navigator.pop(context);
            },
            child: const Text(
              'تأكيد',
              style: TextStyle(
                  color: Colors.black
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(this.mounted){
      int gender = Provider.of<ActiveUserProvider>(context, listen: false)
          .user!.gender;
      if(gender == 2) _gender = 'أنثى';
      else _gender = 'ذكر';
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var activeUser = Provider.of<ActiveUserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('البيانات الشخصية'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Text(
                'المعلومات الشخصية',
                style: TextStyle(
                  fontFamily: 'CairoBold',
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _personalInfoKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 5,),
                        CustomTextField(
                          text: 'الأسم',
                          obscureText: false,
                          textInputType: TextInputType.text,
                          setValue: (value){
                            _name = value;
                          },
                          validation: (value){
                            if(value.isEmpty) return 'ادخل اسمك';
                            return null;
                          },
                          anotherFilledColor: true,
                          initialValue: activeUser.user!.name,
                        ),
                        SizedBox(height: 15,),
                        CustomTextField(
                          text: 'العمر',
                          obscureText: false,
                          textInputType: TextInputType.number,
                          setValue: (value){
                            _age = value;
                          },
                          validation: (value){
                            if(value.isEmpty) return 'ادخل عمرك';
                            return null;
                          },
                          anotherFilledColor: true,
                          initialValue: activeUser.user!.age.toString(),
                        ),
                        SizedBox(height: 15,),
                        CustomTextField(
                          text: 'الطول',
                          obscureText: false,
                          textInputType: TextInputType.number,
                          setValue: (value){
                            _tall = value;
                          },
                          validation: (value){
                            if(value.isEmpty) return 'ادخل طولك';
                            return null;
                          },
                          anotherFilledColor: true,
                          initialValue: activeUser.user!.tall.toString(),
                        ),
                        SizedBox(height: 15,),
                        CustomTextField(
                          text: 'الوزن',
                          obscureText: false,
                          textInputType: TextInputType.number,
                          setValue: (value){
                            _weight = value;
                          },
                          validation: (value){
                            if(value.isEmpty) return 'ادخل وزنك';
                            return null;
                          },
                          anotherFilledColor: true,
                          initialValue: activeUser.user!.weight.toString(),
                        ),
                        SizedBox(height: 15,),
                        CustomTextField(
                          text: 'نسبة الدهون',
                          obscureText: false,
                          textInputType: TextInputType.number,
                          setValue: (value){
                            _fatsPercent = value;
                          },
                          validation: (value){
                            if(value.isEmpty) return 'ادخل نسبة الدهون';
                            return null;
                          },
                          anotherFilledColor: true,
                          initialValue: activeUser.user!.fatsPercent.toString(),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              //width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _gender,
                              elevation: 10,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black
                              ),
                              underline: Container(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _gender = newValue!;
                                });
                              },
                              items: <String>['ذكر', 'أنثى']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'بيانات الحساب',
                style: TextStyle(
                  fontFamily: 'CairoBold',
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _accountInfoKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 5,),
                        CustomTextField(
                          text: 'البريد الألكتروني',
                          obscureText: false,
                          textInputType: TextInputType.emailAddress,
                          setValue: (value){
                            _email = value;
                          },
                          validation: (value){
                            if(value.isEmpty) return 'ادخل البريد الألكتروني';
                            if (!value.contains('@') || !value.contains('.'))
                              return 'بريد الكتروني خاطىء';
                            return null;
                          },
                          anotherFilledColor: true,
                          initialValue: activeUser.user!.email,
                        ),
                        SizedBox(height: 15,),
                        CustomTextField(
                          text: 'تغيير كلمة السر',
                          obscureText: true,
                          textInputType: TextInputType.text,
                          setValue: (value){
                            _password = value;
                          },
                          validation: (value){
                            if(value.isNotEmpty && value.length < 6) return 'كلمة سر ضعيفة';
                            return null;
                          },
                          anotherFilledColor: true,
                        ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              CustomButton(
                text: 'حفظ الأعدادات',
                onClick: (){
                  onSaveChanges(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
