import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/models/snacks_list.dart';
import 'package:informa/models/supplements_list.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/wide_meal_card.dart';
import 'package:provider/provider.dart';

class SupplementsScreen extends StatefulWidget {
  static String id = 'supplements';
  const SupplementsScreen({Key? key}) : super(key: key);

  @override
  _SupplementsScreenState createState() => _SupplementsScreenState();
}

class _SupplementsScreenState extends State<SupplementsScreen> {
  List<Meal> _supplements = [];
  FirestoreService _firestoreService = new FirestoreService();

  getSupplements() {
    var activeUser =
        Provider.of<ActiveUserProvider>(context, listen: false).user;
    if (activeUser!.wheyProtein == 1 && activeUser.myProtein! >= 250) {
      _supplements.add(SnacksList.snacks[0]);
      _supplements.add(SnacksList.snacks[0]);
    } else if (activeUser.wheyProtein == 1 && activeUser.myProtein! >= 200) {
      _supplements.add(SnacksList.snacks[0]);
    }
    for (var id in activeUser.supplements) {
      Meal supplement = SupplementsList.supplements[int.parse(id) - 1];
      _supplements.add(supplement);
    }
    print(_supplements);
  }

  @override
  void initState() {
    super.initState();
    if (mounted) getSupplements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المكملات'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png'))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              for (int i = 0; i < _supplements.length; i++)
                Column(
                  children: [
                    WideMealCard(
                      meal: _supplements[i],
                      isDone: Provider.of<PremiumNutritionProvider>(context)
                          .supplementsDone!
                          .contains(i),
                      onClick: () async {
                        String id = FirebaseAuth.instance.currentUser!.uid;
                        Provider.of<PremiumNutritionProvider>(context,
                                listen: false)
                            .addToSupplementsDone(i);
                        await _firestoreService.updateNutrition(id, {
                          'supplementsDone':
                              Provider.of<PremiumNutritionProvider>(context,
                                      listen: false)
                                  .supplementsDone,
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
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
