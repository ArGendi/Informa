import 'package:flutter/material.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/screens/premium_screens/full_meals_screen.dart';
import 'package:informa/screens/premium_screens/snacks_screen.dart';
import 'package:informa/widgets/main_meal_card.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  @override
  Widget build(BuildContext context) {
    var premiumNutritionProvider = Provider.of<PremiumNutritionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('الدايت'),
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
          child: premiumNutritionProvider.snacks == null && premiumNutritionProvider.breakfast.isEmpty
              && premiumNutritionProvider.lunch.isEmpty && premiumNutritionProvider.dinner.isEmpty ?
          Center(
            child: Text(
              'لا يوجد أكلات الأن 🍇',
              style: TextStyle(
                fontSize: 18,
                fontFamily: boldFont,
              ),
            ),
          ) : ListView(
            children: [
              if(premiumNutritionProvider.snacks)
                MainMealCard(
                  text: 'وجبات خفيفة',
                  description: 'وجبات خفيفة لزيزة بين الوجبات الاساسية',
                  onClick: (){
                    Navigator.pushNamed(context, SnacksScreen.id);
                  },
                ),
              SizedBox(height: 10,),
              if(premiumNutritionProvider.breakfast.isNotEmpty)
                MainMealCard(
                  text: 'الفطار',
                  description: 'أبدأ بوجبة فطار لزيزة وصحية',
                  onClick: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FullMealsScreen(
                        screenName: 'الفطار',
                        fullMeals: premiumNutritionProvider.breakfast,
                      )),
                    );
                  },
                ),
              SizedBox(height: 10,),
              if(premiumNutritionProvider.lunch.isNotEmpty)
                MainMealCard(
                  text: 'الغداء',
                  description: 'وجبة الغداء اكتر وجبة فيها بروتينات لعضلاتك',
                  onClick: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FullMealsScreen(
                        screenName: 'الغداء',
                        fullMeals: premiumNutritionProvider.lunch,
                      )),
                    );
                  },
                ),
              SizedBox(height: 10,),
              if(premiumNutritionProvider.dinner.isNotEmpty)
                MainMealCard(
                  text: 'العشاء',
                  description: 'حافظ علي ان وجبة العشاء قبل النوم عالأقل بنص ساعة',
                  onClick: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FullMealsScreen(
                        screenName: 'العشاء',
                        fullMeals: premiumNutritionProvider.dinner,
                      )),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
