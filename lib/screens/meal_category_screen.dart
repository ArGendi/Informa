import 'package:flutter/material.dart';
import 'package:informa/providers/kitchen_provider.dart';
import 'package:informa/widgets/wide_meal_card.dart';
import 'package:provider/provider.dart';

class MealCategoryScreen extends StatefulWidget {
  static String id = 'meal category';
  final int initialIndex;
  const MealCategoryScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _MealCategoryScreenState createState() => _MealCategoryScreenState();
}

class _MealCategoryScreenState extends State<MealCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var kitchenProvider = Provider.of<KitchenProvider>(context);
    return DefaultTabController(
      initialIndex: widget.initialIndex,
      length: kitchenProvider.items!.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text('مطبخ انفورما'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              for(var category in kitchenProvider.items!)
                Text(category.name!),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/appBg.png')
              )
          ),
          child: TabBarView(
            children: [
              for(var category in kitchenProvider.items!)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ListView.builder(
                    itemCount: category.meals!.length,
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                          WideMealCard(meal: category.meals![index]),
                          SizedBox(height: 10,),
                        ],
                      );
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
