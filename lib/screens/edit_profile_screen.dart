import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';
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
  // bool _isNameChanged = false;
  // bool _isAgeChanged = false;
  // bool _isTallChanged = false;
  // bool _isWeightChanged = false;
  // bool _isFatsPercentChanged = false;
  // bool _isGenderChanged = false;
  // bool _isEmailChanged = false;
  // bool _isPasswordChanged = false;

  onSaveChanges(BuildContext context) {
    FocusScope.of(context).unfocus();
    bool personalValid = _personalInfoKey.currentState!.validate();
    bool accountValid = _accountInfoKey.currentState!.validate();
    if (personalValid && accountValid) {
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

  Future checkChangesAndUpdateInFirebase(BuildContext context) async {
    Map<String, dynamic> map = new Map();
    String? name =
        Provider.of<ActiveUserProvider>(context, listen: false).user!.name;
    String? age = Provider.of<ActiveUserProvider>(context, listen: false)
        .user!
        .age
        .toString();
    String? tall = Provider.of<ActiveUserProvider>(context, listen: false)
        .user!
        .tall
        .toString();
    String? weight = Provider.of<ActiveUserProvider>(context, listen: false)
        .user!
        .weight
        .toString();
    String? fatsPercent =
        Provider.of<ActiveUserProvider>(context, listen: false)
            .user!
            .fatsPercent
            .toString();
    int? gender =
        Provider.of<ActiveUserProvider>(context, listen: false).user!.gender;
    String? email =
        Provider.of<ActiveUserProvider>(context, listen: false).user!.email;

    int iGender = _gender == 'ذكر' ? 1 : 2;

    if (name != _name.trim()) {
      map['name'] = _name;
      Provider.of<ActiveUserProvider>(context, listen: false).setName(_name);
      HelpFunction.saveUserName(_name);
      _isChangeHappen = true;
    }
    if (age != _age.trim()) {
      print('age: ' + _age.trim());
      map['age'] = int.parse(_age.trim());
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setAge(int.parse(_age.trim()));
      HelpFunction.saveUserAge(int.parse(_age.trim()));
      _isChangeHappen = true;
    }
    if (tall != _tall.trim()) {
      map['tall'] = int.parse(_tall.trim());
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setTall(int.parse(_tall.trim()));
      HelpFunction.saveUserTall(int.parse(_tall.trim()));
      _isChangeHappen = true;
    }
    if (weight != _weight.trim()) {
      map['weight'] = int.parse(_weight.trim());
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setWeight(int.parse(_weight.trim()));
      HelpFunction.saveUserWeight(int.parse(_weight.trim()));
      _isChangeHappen = true;
    }
    if (fatsPercent != _fatsPercent.trim()) {
      map['fatsPercent'] = int.parse(_fatsPercent.trim());
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setFatPercent(int.parse(_fatsPercent.trim()));
      HelpFunction.saveUserFatsPercent(int.parse(_fatsPercent.trim()));
      _isChangeHappen = true;
    }
    if (gender != iGender) {
      map['gender'] = iGender;
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setGender(iGender);
      HelpFunction.saveUserGender(iGender);
      _isChangeHappen = true;
    }
    if (email != _email.trim()) {
      map['email'] = _email.trim();
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setEmail(_email.trim());
      HelpFunction.saveUserEmail(_email.trim());
      await FirebaseAuth.instance.currentUser!.updateEmail(_email.trim());
      _isChangeHappen = true;
    }
    if (_password.isNotEmpty) {
      await FirebaseAuth.instance.currentUser!.updatePassword(_password);
    }
    if (_isChangeHappen) {
      var id = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(map)
          .catchError((e) {
        print(e);
      });
    }
  }

  showConfirmationAlertDialog(BuildContext context) async {
    var localization = AppLocalization.of(context);
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          localization!.translate('متأكد من تغيير بيناتك ؟').toString(),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              localization.translate('ألغاء').toString(),
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () async {
              await checkChangesAndUpdateInFirebase(context);
              Navigator.pop(context);
            },
            child: Text(
              localization.translate('تأكيد').toString(),
              style: TextStyle(color: Colors.black),
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
    if (this.mounted) {
      int gender =
          Provider.of<ActiveUserProvider>(context, listen: false).user!.gender;
      if (gender == 2)
        _gender = 'أنثى';
      else
        _gender = 'ذكر';
    }
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var screenSize = MediaQuery.of(context).size;
    var activeUserProvider =
        Provider.of<ActiveUserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(localization!.translate('البيانات الشخصية').toString()),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png'))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Text(
                localization.translate('المعلومات الشخصية').toString(),
                style: TextStyle(
                  fontFamily: 'CairoBold',
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          text: 'الأسم',
                          obscureText: false,
                          textInputType: TextInputType.text,
                          setValue: (value) {
                            _name = value;
                          },
                          validation: (value) {
                            if (value.isEmpty)
                              return localization
                                  .translate('ادخل اسمك')
                                  .toString();
                            return null;
                          },
                          anotherFilledColor: true,
                          initialValue: activeUserProvider.user!.name,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          text: localization.translate('العمر').toString(),
                          obscureText: false,
                          textInputType: TextInputType.number,
                          setValue: (value) {
                            _age = value;
                          },
                          validation: (value) {
                            if (value.isEmpty)
                              return localization
                                  .translate('ادخل عمرك')
                                  .toString();
                            return null;
                          },
                          anotherFilledColor: true,
                          initialValue: activeUserProvider.user!.age.toString(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          text: localization.translate('الطول').toString(),
                          obscureText: false,
                          textInputType: TextInputType.number,
                          setValue: (value) {
                            _tall = value;
                          },
                          validation: (value) {
                            if (value.isEmpty)
                              return localization
                                  .translate('ادخل طولك')
                                  .toString();
                            return null;
                          },
                          anotherFilledColor: true,
                          initialValue:
                              activeUserProvider.user!.tall.toString(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          text: localization.translate('الوزن').toString(),
                          obscureText: false,
                          textInputType: TextInputType.number,
                          setValue: (value) {
                            _weight = value;
                          },
                          validation: (value) {
                            if (value.isEmpty)
                              return localization
                                  .translate('ادخل وزنك')
                                  .toString();
                            return null;
                          },
                          anotherFilledColor: true,
                          initialValue:
                              activeUserProvider.user!.weight.toString(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          text:
                              localization.translate('نسبة الدهون').toString(),
                          obscureText: false,
                          textInputType: TextInputType.number,
                          setValue: (value) {
                            _fatsPercent = value;
                          },
                          validation: (value) {
                            if (value.isEmpty)
                              return localization
                                  .translate('ادخل نسبة الدهون')
                                  .toString();
                            else if (double.parse(value) > 80)
                              return localization
                                  .translate('نسبة الدهون غير صحيحة')
                                  .toString();
                            return null;
                          },
                          anotherFilledColor: true,
                          initialValue:
                              activeUserProvider.user!.fatsPercent.toString(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
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
                                  fontSize: 17, color: Colors.black),
                              underline: Container(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _gender = newValue!;
                                });
                              },
                              items: <String>[
                                localization.translate('ذكر').toString(),
                                localization.translate('أنثى').toString(),
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                localization.translate('بيانات الحساب').toString(),
                style: TextStyle(
                  fontFamily: 'CairoBold',
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          text: localization
                              .translate('البريد الألكتروني')
                              .toString(),
                          obscureText: false,
                          textInputType: TextInputType.emailAddress,
                          setValue: (value) {
                            _email = value;
                          },
                          validation: (value) {
                            if (value.isEmpty)
                              return localization
                                  .translate('ادخل البريد الألكتروني')
                                  .toString();
                            if (!value.contains('@') || !value.contains('.'))
                              return localization
                                  .translate('بريد الكتروني خاطىء')
                                  .toString();
                            return null;
                          },
                          anotherFilledColor: true,
                          initialValue: activeUserProvider.user!.email,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        if (!activeUserProvider.user!.fromSocialMedia)
                          CustomTextField(
                            text: localization
                                .translate('تغيير كلمة السر')
                                .toString(),
                            obscureText: true,
                            textInputType: TextInputType.text,
                            setValue: (value) {
                              _password = value;
                            },
                            validation: (value) {
                              if (value.isNotEmpty && value.length < 6)
                                return localization
                                    .translate('كلمة سر ضعيفة')
                                    .toString();
                              return null;
                            },
                            anotherFilledColor: true,
                          ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                text: localization.translate('حفظ الأعدادات').toString(),
                onClick: () {
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
