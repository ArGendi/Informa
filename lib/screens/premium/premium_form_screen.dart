import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/enter_fats_percent.dart';
import 'package:informa/widgets/premium_fat_percent.dart';
import 'package:informa/widgets/select_fat_percent.dart';
import 'package:informa/widgets/select_goal.dart';
import 'package:informa/widgets/select_level.dart';
import 'package:informa/widgets/select_meals_per_day.dart';
import 'package:informa/widgets/select_meals_time.dart';
import 'package:informa/widgets/select_supplements.dart';
import 'package:informa/widgets/select_tools.dart';
import 'package:informa/widgets/select_training_days.dart';
import 'package:informa/widgets/select_unwanted_meals.dart';
import 'package:provider/provider.dart';

class PremiumFormScreen extends StatefulWidget {
  static String id = 'premium form';
  const PremiumFormScreen({Key? key}) : super(key: key);

  @override
  _PremiumFormScreenState createState() => _PremiumFormScreenState();
}

class _PremiumFormScreenState extends State<PremiumFormScreen> {
  int _initialPage = 0;
  late final PageController _controller;
  bool _showFatsImagesPage = false;

  goToNextPage(){
    _controller.animateToPage(
        _initialPage + 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut
    );
    setState(() {
      _initialPage += 1;
    });
  }

  goBack(){
    _controller.animateToPage(
        _initialPage - 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut
    );
    setState(() {
      _initialPage -= 1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: SafeArea(
          child: PageView(
            physics:new NeverScrollableScrollPhysics(),
            controller: _controller,
            children: [
              // PremiumFatPercent(
              //   onBack: (){
              //     Navigator.pop(context);
              //   },
              //   goToFatsImages: (){
              //     setState(() {
              //       _showFatsImagesPage = true;
              //     });
              //     goToNextPage();
              //   },
              //   onNext: (){
              //     setState(() {
              //       _showFatsImagesPage = false;
              //     });
              //     goToNextPage();
              //   },
              // ),
              // if(_showFatsImagesPage)
              //   SelectFatPercent(
              //     onBack: goBack,
              //     onNext: goToNextPage,
              //   ),
              // SelectGoal(
              //   onBack: goBack,
              //   onClick: goToNextPage,
              // ),
              // SelectLevel(
              //   onBack: goBack,
              //   onClick: goToNextPage,
              // ),
              // SelectTrainingDays(
              //   onBack: goBack,
              //   onClick: goToNextPage,
              // ),
              // SelectSupplements(
              //   onBack: goBack,
              //   onClick: goToNextPage,
              // ),
              // SelectMealsPerDay(
              //   onBack: goBack,
              //   onClick: goToNextPage,
              // ),
              // SelectMealsTime(
              //   onBack: goBack,
              //   onClick: goToNextPage,
              // ),
              SelectUnWantedMeals(
                onBack: goBack,
                onClick: goToNextPage,
              )
            ],
          ),
        ),
      ),
    );
  }
}
