import 'package:flutter/material.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/screens/premium_screens/full_meals_screen.dart';
import 'package:informa/screens/premium_screens/snacks_screen.dart';
import 'package:informa/widgets/macro_banner.dart';
import 'package:informa/widgets/main_meal_card.dart';
import 'package:informa/widgets/water_info_banner.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  int getLunchNumber(AppUser user){
    if(user.numberOfMeals == 3 || user.numberOfMeals == 4) return 2;
    else if(user.numberOfMeals == 2 && user.whichTwoMeals == 1) return 2;
    else return 1;
  }

  int getDinnerNumber(AppUser user){
    if(user.numberOfMeals == 3) return 3;
    else if(user.numberOfMeals == 4) return 4;
    else return 2;
  }

  @override
  Widget build(BuildContext context) {
    var premiumNutritionProvider = Provider.of<PremiumNutritionProvider>(context);
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
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
        child: Column(
          children: [

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(borderRadius),
                          border: Border.all(color: Colors.grey.shade200, width: 2)
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'اليوم',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: boldFont,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2,),
                    MacroBanner(),
                    SizedBox(height: 10,),
                    //if(premiumNutritionProvider.breakfast.isNotEmpty)
                    if(!(activeUser!.numberOfMeals == 2 && activeUser.whichTwoMeals == 2))
                      MainMealCard(
                        text: 'الفطار',
                        mealNumber: 1,
                        description: 'أبدأ بوجبة فطار لذيذة وصحية',
                        isDone: premiumNutritionProvider.breakfastDone != null?
                            true : false,
                        onClick: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FullMealsScreen(
                              screenName: 'الفطار',
                              fullMeals: premiumNutritionProvider.breakfast,
                              mealDone: premiumNutritionProvider.breakfastDone,
                              whichMeal: 1,
                            )),
                          );
                        },
                      ),
                    SizedBox(height: 10,),
                      MainMealCard(
                        text: 'الغداء',
                        mealNumber: getLunchNumber(activeUser),
                        description: 'وجبة الغداء اكتر وجبة فيها بروتينات لعضلاتك',
                        isDone: premiumNutritionProvider.lunchDone != null?
                        true : false,
                        onClick: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FullMealsScreen(
                              screenName: 'الغداء',
                              fullMeals: premiumNutritionProvider.lunch,
                              mealDone: premiumNutritionProvider.lunchDone,
                              whichMeal: 2,
                            )),
                          );
                        },
                      ),
                    SizedBox(height: 10,),
                    if(activeUser.numberOfMeals == 4)
                      Column(
                        children: [
                          MainMealCard(
                            text: 'الغداء',
                            mealNumber: 3,
                            description: 'وجبة الغداء اكتر وجبة فيها بروتينات لعضلاتك',
                            isDone: premiumNutritionProvider.lunch2Done != null?
                            true : false,
                            onClick: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FullMealsScreen(
                                  screenName: 'الغداء',
                                  fullMeals: premiumNutritionProvider.lunch2,
                                  mealDone: premiumNutritionProvider.lunch2Done,
                                  whichMeal: 3,
                                )),
                              );
                            },
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    //if(premiumNutritionProvider.dinner.isNotEmpty)
                    if(!(activeUser.numberOfMeals == 2 && activeUser.whichTwoMeals == 1))
                      MainMealCard(
                        text: 'العشاء',
                        mealNumber: getDinnerNumber(activeUser),
                        description: 'حافظ علي ان وجبة العشاء قبل النوم عالأقل بنص ساعة',
                        isDone: premiumNutritionProvider.dinnerDone != null?
                        true : false,
                        onClick: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FullMealsScreen(
                              screenName: 'العشاء',
                              fullMeals: premiumNutritionProvider.dinner,
                              mealDone: premiumNutritionProvider.dinnerDone,
                              whichMeal: 4,
                            )),
                          );
                        },
                      ),
                    if(premiumNutritionProvider.snacks)
                      Column(
                        children: [
                          SizedBox(height: 10,),
                          MainMealCard(
                            text: 'وجبات خفيفة',
                            description: 'وجبات خفيفة لذيذة بين الوجبات الاساسية (في اي وقت متاح فاليوم)',
                            isDone: premiumNutritionProvider.snackDone != null?
                            true : false,
                            onClick: (){
                              Navigator.pushNamed(context, SnacksScreen.id);
                            },
                          ),
                        ],
                      ),
                    if(activeUser.wheyProtein == 1 && activeUser.haveSupplements != 2)
                      Column(
                        children: [
                          SizedBox(height: 10,),
                          MainMealCard(
                            text: 'المكملات',
                            description: 'المكملات الجانبية بجانب الوجبات الاساسية',
                            onClick: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FullMealsScreen(
                                  screenName: 'المكملات',
                                  fullMeals: [],
                                )),
                              );
                            },
                          ),
                        ],
                      ),
                    SizedBox(height: 10,),
                    WaterInfoBanner(),
                    SizedBox(height: 80,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
