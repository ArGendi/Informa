import 'package:flutter/material.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/screens/premium_screens/add_external_meal_info_screen.dart';
import 'package:informa/screens/premium_screens/diet_requirements_screen.dart';
import 'package:informa/screens/premium_screens/full_meals_screen.dart';
import 'package:informa/screens/premium_screens/nutrition_concepts_screen.dart';
import 'package:informa/screens/premium_screens/snacks_screen.dart';
import 'package:informa/screens/premium_screens/supplements_screen.dart';
import 'package:informa/widgets/custom_button.dart';
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

  bool getSupplementsDoneStatus(AppUser user, PremiumNutritionProvider nutritionProvider){
    int number = 0;
    if(user.wheyProtein == 1 && user.myProtein! >= 250) number = 2;
    else if(user.wheyProtein == 1 && user.myProtein! >= 200) number = 1;
    number += user.supplements.length;
    if(nutritionProvider.supplementsDone!.length == number) return true;
    return false;
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
            Container(
              height: 60,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, NutritionConceptsScreen.id);
                      },
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'شرح مفاهيم',
                            style: TextStyle(
                              fontFamily: boldFont,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Card(
                            elevation: 0,
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                //size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: double.maxFinite,
                      color: Colors.grey[300],
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, DietRequirementsScreen.id);
                      },
                      child: Text(
                        'متطلبات الدايت',
                        style: TextStyle(
                          fontFamily: boldFont,
                          color: primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
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
                        time: activeUser.datesOfMeals.length > 0 ?
                        activeUser.datesOfMeals[0] : null,
                        onClick: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FullMealsScreen(
                              screenName: 'الفطار',
                              fullMeals: premiumNutritionProvider.breakfast,
                              mealDone: premiumNutritionProvider.breakfastDone,
                              whichMeal: 1,
                              time: activeUser.datesOfMeals.length > 0 ?
                                activeUser.datesOfMeals[0] : null,
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
                        time: activeUser.datesOfMeals.length > (getLunchNumber(activeUser) -1) ?
                        activeUser.datesOfMeals[getLunchNumber(activeUser) -1] : null,
                        onClick: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FullMealsScreen(
                              screenName: 'الغداء',
                              fullMeals: premiumNutritionProvider.lunch,
                              mealDone: premiumNutritionProvider.lunchDone,
                              whichMeal: 2,
                              time: activeUser.datesOfMeals.length > (getLunchNumber(activeUser) -1) ?
                                activeUser.datesOfMeals[getLunchNumber(activeUser) -1] : null,
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
                            time: activeUser.datesOfMeals.length > 2 ?
                            activeUser.datesOfMeals[2] : null,
                            onClick: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FullMealsScreen(
                                  screenName: 'الغداء',
                                  fullMeals: premiumNutritionProvider.lunch2,
                                  mealDone: premiumNutritionProvider.lunch2Done,
                                  whichMeal: 3,
                                  time: activeUser.datesOfMeals.length > 2 ?
                                    activeUser.datesOfMeals[2] : null,
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
                        time: activeUser.datesOfMeals.length > (getDinnerNumber(activeUser) - 1) ?
                        activeUser.datesOfMeals[getDinnerNumber(activeUser) - 1] : null,
                        onClick: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FullMealsScreen(
                              screenName: 'العشاء',
                              fullMeals: premiumNutritionProvider.dinner,
                              mealDone: premiumNutritionProvider.dinnerDone,
                              whichMeal: 4,
                              time: activeUser.datesOfMeals.length > (getDinnerNumber(activeUser) - 1) ?
                                activeUser.datesOfMeals[getDinnerNumber(activeUser) - 1] : null,
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
                            isDone: getSupplementsDoneStatus(activeUser, premiumNutritionProvider),
                            onClick: (){
                              Navigator.pushNamed(context, SupplementsScreen.id);
                            },
                          ),
                        ],
                      ),
                    SizedBox(height: 10,),
                    WaterInfoBanner(),
                    SizedBox(height: 10,),
                    CustomButton(
                      text: 'أضف وجبة خارجية',
                      onClick: (){
                        Navigator.pushNamed(context, AddExternalMealInfoScreen.id);
                      },
                    ),
                    SizedBox(height: 90,),
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
