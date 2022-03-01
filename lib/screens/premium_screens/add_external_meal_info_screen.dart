import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddExternalMealInfoScreen extends StatefulWidget {
  static String id = 'add external meal info';
  const AddExternalMealInfoScreen({Key? key}) : super(key: key);

  @override
  _AddExternalMealInfoScreenState createState() => _AddExternalMealInfoScreenState();
}

class _AddExternalMealInfoScreenState extends State<AddExternalMealInfoScreen> {
  var _formKey = GlobalKey<FormState>();
  String _name = '';
  int _protein = 0;
  int _carb = 0;
  int _fats = 0;
  bool _isLoading = false;
  bool _isDone = false;
  FirestoreService _firestoreService = new FirestoreService();

  onAdd(BuildContext context) async{
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid){
      _formKey.currentState!.save();
      var activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
      int calories = _protein * 4 + _fats * 9 + _carb * 4;
      int newCalories = activeUser!.dailyCalories! - calories;
      int newProtein = activeUser.dailyProtein! - _protein;
      int newCarb = activeUser.dailyCarb! - _carb;
      int newFats = activeUser.dailyFats! - _fats;

      setState(() { _isLoading = true;});
      String id = FirebaseAuth.instance.currentUser!.uid;
      await _firestoreService.updateUserData(id, {
        'dailyCalories': newCalories,
        'dailyProtein': newProtein,
        'dailyCarb': newCarb,
        'dailyFats': newFats,
      });
      Provider.of<PremiumNutritionProvider>(context, listen: false)
          .addToAdditionalMeals(_name);
      var additionalMeals =
          Provider.of<PremiumNutritionProvider>(context, listen: false).additionalMeals;
      await _firestoreService.updateNutrition(id, {
        'additionalMeals': additionalMeals,
      });

      Provider.of<ActiveUserProvider>(context, listen: false)
          .setDailyCalories(newCalories);
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setDailyProtein(newProtein);
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setDailyCarb(newCarb);
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setDailyFats(newFats);

      setState(() { _isLoading = false;});
      setState(() { _isDone = true;});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('أضف بيانات وجبة'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'يمكنك اضافة تفاصيل الوجبة الخارجية التي أكلتها لنضعها فالحسابات',
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
                SizedBox(height: 20,),
                CustomTextField(
                  text: 'أسم الوجبة',
                  obscureText: false,
                  textInputType: TextInputType.text,
                  setValue: (value){
                    _name = value;
                  },
                  validation: (value){
                    if(value.isEmpty) return 'أدخل أسم الوجبة';
                    return null;
                  },
                  anotherFilledColor: true,
                ),
                SizedBox(height: 10,),
                CustomTextField(
                  text: 'البروتين',
                  obscureText: false,
                  textInputType: TextInputType.number,
                  setValue: (value){
                    _protein = int.parse(value.trim());
                  },
                  validation: (value){
                    if(value.isEmpty) return 'أدخل كمية البروتين';
                    return null;
                  },
                  anotherFilledColor: true,
                ),
                SizedBox(height: 10,),
                CustomTextField(
                  text: 'الكارب',
                  obscureText: false,
                  textInputType: TextInputType.number,
                  setValue: (value){
                    _carb = int.parse(value.trim());
                  },
                  validation: (value){
                    if(value.isEmpty) return 'أدخل كمية الكارب';
                    return null;
                  },
                  anotherFilledColor: true,
                ),
                SizedBox(height: 10,),
                CustomTextField(
                  text: 'الدهون',
                  obscureText: false,
                  textInputType: TextInputType.number,
                  setValue: (value){
                    _fats = int.parse(value.trim());
                  },
                  validation: (value){
                    if(value.isEmpty) return 'أدخل كمية الدهون';
                    return null;
                  },
                  anotherFilledColor: true,
                ),
                SizedBox(height: 20,),
                CustomButton(
                  text: !_isDone ? 'أضف الأن' : 'تم',
                  onClick: (){
                    onAdd(context);
                  },
                  iconExist: false,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
