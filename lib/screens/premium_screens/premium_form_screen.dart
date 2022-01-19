import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/screens/pageview_screens/dont_know_goal.dart';
import 'package:informa/screens/pageview_screens/enter_fats_percent.dart';
import 'package:informa/screens/pageview_screens/premium_fat_percent.dart';
import 'package:informa/screens/pageview_screens/select_disease.dart';
import 'package:informa/screens/pageview_screens/select_fat_percent.dart';
import 'package:informa/screens/pageview_screens/select_goal.dart';
import 'package:informa/screens/pageview_screens/select_level.dart';
import 'package:informa/screens/pageview_screens/select_meals_per_day.dart';
import 'package:informa/screens/pageview_screens/select_meals_time.dart';
import 'package:informa/screens/pageview_screens/select_milk_products_problems.dart';
import 'package:informa/screens/pageview_screens/select_supplements.dart';
import 'package:informa/screens/pageview_screens/upload_body_photos.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/services/notification_service.dart';
import 'package:informa/widgets/select_tools.dart';
import 'package:informa/screens/pageview_screens/select_training_days.dart';
import 'package:informa/screens/pageview_screens/select_unwanted_meals.dart';
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
  bool _isLoading = false;
  bool _selectFromPhotos = false;
  bool _unknownGoal = false;

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

  Future goBack() async{
    await _controller.animateToPage(
        _initialPage - 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut
    );
    setState(() {
      _initialPage -= 1;
    });
  }

  onDone(BuildContext context) async{
    String? id = FirebaseAuth.instance.currentUser!.uid;
    Provider.of<ActiveUserProvider>(context, listen: false).premiumFormFilled();
    Provider.of<ActiveUserProvider>(context, listen: false).removeAllUnwantedMeals();
    var activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
    setState(() {_isLoading = true;});
    await NotificationService.cancelNotification(10);
    DateTime now = DateTime.now();
    var after3days = DateTime(now.year, now.month, now.day, now.hour+72);
    activeUser!.premiumStartDate = after3days;
    FirestoreService firestoreService = new FirestoreService();
    var map = activeUser.toJson();
    await firestoreService.updateUserData(id, map);
    setState(() {_isLoading = false;});
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
              PremiumFatPercent(
                onBack: (){
                  Navigator.pop(context);
                },
                goToFatsImages: (){
                  setState(() {
                    _showFatsImagesPage = true;
                  });
                  goToNextPage();
                },
                onNext: (){
                  setState(() {
                    _showFatsImagesPage = false;
                  });
                  goToNextPage();
                },
                selectFromPhotos: _selectFromPhotos,
              ),
              if(_showFatsImagesPage)
                SelectFatPercent(
                  onBack: goBack,
                  onNext: () async{
                    await goBack();
                    setState(() {
                      _showFatsImagesPage = false;
                      _selectFromPhotos = true;
                    });
                  },
                ),
              if(activeUser!.gender == 1)
                UploadBodyPhotos(
                  onBack: goBack,
                  onClick: goToNextPage,
                ),
              SelectGoal(
                onBack: goBack,
                onClick: goToNextPage,
                unknownGoal: (value){
                  _unknownGoal = value;
                },
              ),
              if(_unknownGoal)
                DoNotKnowGoal(
                  onBack: goBack,
                  onClick: goToNextPage,
                ),
              SelectLevel(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectTrainingDays(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectSupplements(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectMealsPerDay(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectMealsTime(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectMilkProductsProblems(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectUnWantedMeals(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectDisease(
                onBack: goBack,
                onClick: (){
                  onDone(context);
                },
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
