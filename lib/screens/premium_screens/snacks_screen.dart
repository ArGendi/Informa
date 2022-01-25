import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/full_meal.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/snacks_list.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/widgets/wide_meal_card.dart';
import 'package:provider/provider.dart';

class SnacksScreen extends StatefulWidget {
  static String id = 'snacks';
  const SnacksScreen({Key? key}) : super(key: key);

  @override
  _SnacksScreenState createState() => _SnacksScreenState();
}

class _SnacksScreenState extends State<SnacksScreen> {
  List<Meal> _mainList = [];
  List<Meal> _orList = [];

  getSnacks(){
    //FullMeal? snacks = Provider.of<PremiumNutritionProvider>(context ,listen: false).snacks;
    var activeUser = Provider.of<ActiveUserProvider>(context ,listen: false).user;
    if(activeUser!.wheyProtein == 1 && activeUser.myProtein! >= 250){
      _mainList.add(SnacksList.snacks[0]);
      _mainList.add(SnacksList.snacks[0]);
      _orList.add(SnacksList.snacks[1]);
      _orList.add(SnacksList.snacks[2]);
      _orList.add(SnacksList.snacks[3]);
    }
    else if(activeUser.wheyProtein == 1 && activeUser.myProtein! >= 200){
      _mainList.add(SnacksList.snacks[0]);
      _orList.add(SnacksList.snacks[1]);
      _orList.add(SnacksList.snacks[2]);
      _orList.add(SnacksList.snacks[3]);
    }
    else if(activeUser.wheyProtein == 1 && activeUser.myProtein! >= 150) {
      _orList.add(SnacksList.snacks[1]);
      _orList.add(SnacksList.snacks[2]);
      _orList.add(SnacksList.snacks[3]);
    }
    else if(activeUser.wheyProtein == 2 && activeUser.myProtein! >= 250) {
      _mainList.add(SnacksList.snacks[4]);
      _mainList.add(SnacksList.snacks[4]);
    }
    else if(activeUser.wheyProtein == 2 && activeUser.myProtein! >= 150) {
      _mainList.add(SnacksList.snacks[4]);
    }

    if(activeUser.myCarb! >= 350) {
      _mainList.add(SnacksList.snacks[5]);
      _mainList.add(SnacksList.snacks[8]);
    }
    else if(activeUser.myCarb! >= 300) {
      _mainList.add(SnacksList.snacks[5]);
      _mainList.add(SnacksList.snacks[7]);
    }
    else if(activeUser.myCarb! >= 250) {
      _mainList.add(SnacksList.snacks[5]);
    }
    else if(activeUser.myCarb! >= 200) {
      _mainList.add(SnacksList.snacks[8]);
    }
    else if(activeUser.myCarb! >= 125) {
      _mainList.add(SnacksList.snacks[7]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSnacks();
  }

  @override
  Widget build(BuildContext context) {
    //var premiumNutritionProvider = Provider.of<PremiumNutritionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('الوجبات الخفيفة'),
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
          child: ListView(
            children: [
              for(var snack in _mainList)
                Column(
                  children: [
                    WideMealCard(meal: snack),
                    SizedBox(height: 10,),
                  ],
                ),
              if(_mainList.isNotEmpty)
                SizedBox(height: 15,),
              if(_orList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'أختار وجبة واحدة فقط',
                      style: TextStyle(
                        fontFamily: boldFont,
                      ),
                    ),
                    SizedBox(height: 10,),
                    for(var snack in _orList)
                      Column(
                        children: [
                          WideMealCard(meal: snack),
                          SizedBox(height: 10,),
                        ],
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
