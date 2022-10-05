import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:informa/constants.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/screens/premium_screens/premium_form_screen.dart';
import 'package:informa/screens/settings_screen.dart';
import 'package:provider/provider.dart';

import '../helpers/shared_preference.dart';
import '../widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _age = '';
  String _tall = '';
  String _weight = '';
  String _fatsPercent = '';
  bool _isChangeHappen = false;
  Future checkAndUpdateInFirebase(BuildContext ctx) async {
    Map<String, dynamic> map = new Map();
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
    // print the variable and the _variable.trim

    print(age);
    print(_age.trim());
    print(weight);
    print(_weight.trim());
    print(tall);
    print(_tall.trim());
    print(fatsPercent);
    print(_fatsPercent.trim());

    if (_age.trim() != '') {
      map['age'] = int.parse(_age.trim());
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setAge(int.parse(_age.trim()));
      HelpFunction.saveUserAge(int.parse(_age.trim()));
      _isChangeHappen = true;
    }
    if (_tall.trim() != '') {
      map['tall'] = int.parse(_tall.trim());
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setTall(int.parse(_tall.trim()));
      HelpFunction.saveUserTall(int.parse(_tall.trim()));
      _isChangeHappen = true;
    }
    if (_weight.trim() != '') {
      print(_weight.runtimeType);
      map['weight'] = int.parse(_weight.trim());
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setWeight(int.parse(_weight.trim()));
      HelpFunction.saveUserWeight(int.parse(_weight.trim()));
      _isChangeHappen = true;
    }
    if (_fatsPercent.trim() != '') {
      map['fatsPercent'] = int.parse(_fatsPercent.trim());
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setFatPercent(int.parse(_fatsPercent.trim()));
      HelpFunction.saveUserFatsPercent(int.parse(_fatsPercent.trim()));
      _isChangeHappen = true;
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
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('متأكد من تغيير بيناتك ؟'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'ألغاء',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () async {
              await checkAndUpdateInFirebase(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text(
              'تأكيد',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    _age = activeUser!.age.toString();
    _tall = activeUser.tall.toString();
    _weight = activeUser.weight.toString();
    _fatsPercent = activeUser.fatsPercent.toString();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png'))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey.shade300)),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, right: 20, bottom: 20, left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 25,
                            child: Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            activeUser.name.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              //fontFamily: 'CairoBold',
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SettingsScreen.id);
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/settings.svg',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (activeUser.premium && !activeUser.fillPremiumForm)
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey.shade300)),
                  elevation: 0,
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.pushNamed(context, PremiumFormScreen.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.format_list_bulleted,
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'أبدأ الأسئلة',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey.shade300)),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (!activeUser.premium)
                            Navigator.pushNamed(context, PlansScreen.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/gym.svg',
                                semanticsLabel: 'gym',
                                color: Colors.black,
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'التمارين المفضلة',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (!activeUser.premium)
                            Navigator.pushNamed(context, PlansScreen.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/fish.svg',
                                semanticsLabel: 'gym',
                                color: Colors.black,
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'الوجبات المفضلة',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey.shade300)),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'معلومات شخصية',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  'assets/images/weight_sm.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(activeUser.weight.toString() + ' كجم'),
                              Text(
                                'وزن الجسم الحالي',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.grey[600],
                            ),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0))),
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'أدخل وزنك الحالي',
                                          style: TextStyle(fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        ProfileScreenTextField(
                                          label: 'الوزن',
                                          onChanged: (value) {
                                            _weight = value;
                                          },
                                          initialValue: _weight.toString(),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: CustomButton(
                                            text: 'حفظ',
                                            onClick: () {
                                              showConfirmationAlertDialog(
                                                  context);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                'assets/images/ruler_sm.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(activeUser.tall.toString() + ' سم'),
                              Text(
                                'طول الجسم',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.grey[600],
                            ),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0))),
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'أدخل طولك الحالي',
                                          style: TextStyle(fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        ProfileScreenTextField(
                                          label: 'الطول',
                                          onChanged: (value) {
                                            print(value);
                                            _tall = value;
                                          },
                                          initialValue: _tall.toString(),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: CustomButton(
                                            text: 'حفظ',
                                            onClick: () {
                                              showConfirmationAlertDialog(
                                                  context);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Image.asset(
                                'assets/images/percentage_sm.png',
                                width: 35,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(activeUser.fatsPercent.toString() + '%'),
                              Text(
                                'نسبة الدهون',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.grey[600],
                            ),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0))),
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'أدخل نسبة دهونك الحالية',
                                          style: TextStyle(fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        ProfileScreenTextField(
                                          label: 'نسبة الدهون',
                                          onChanged: (value) {
                                            print(value);
                                            _fatsPercent = value;
                                          },
                                          initialValue: _fatsPercent.toString(),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: CustomButton(
                                            text: 'حفظ',
                                            onClick: () {
                                              showConfirmationAlertDialog(
                                                  context);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/hourglass_sm.png',
                                width: 35,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(activeUser.age.toString() + ' سنة'),
                              Text(
                                'العمر',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.grey[600],
                            ),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0))),
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'أدخل عمرك الحالي',
                                          style: TextStyle(fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        ProfileScreenTextField(
                                          label: 'العمر',
                                          onChanged: (value) {
                                            print(value);
                                            _age = value;
                                          },
                                          initialValue: _age.toString(),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: CustomButton(
                                            text: 'حفظ',
                                            onClick: () {
                                              showConfirmationAlertDialog(
                                                  context);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (!activeUser.premium)
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey.shade300)),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'أنفورما',
                              style: TextStyle(
                                fontFamily: 'CairoBold',
                              ),
                            ),
                            Column(
                              children: [
                                Card(
                                  elevation: 0,
                                  color: primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      'بريميم',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          'أنضم الي عائلة أنفورما',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'CairoBold',
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'للحصول علي برنامج تغذية وتمارين مخصصة لجسمك بالأضافة الي مميزات غير محدودة',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(borderRadius),
                          onTap: () {
                            Navigator.pushNamed(context, PlansScreen.id);
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius:
                                    BorderRadius.circular(borderRadius)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'أنضم الأن',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(
                height: 75,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreenTextField extends StatelessWidget {
  const ProfileScreenTextField({
    Key? key,
    this.onChanged,
    this.initialValue,
    required this.label,
  }) : super(key: key);
  final void Function(String)? onChanged;
  final String? initialValue;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: TextEditingController(text: initialValue),
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade500,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        focusColor: Colors.grey.shade100,
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            //width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            //width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Colors.red,
            //width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Colors.red,
            //width: 2.0,
          ),
        ),
      ),
      keyboardType: TextInputType.numberWithOptions(),
      onChanged: onChanged,
    );
  }
}
