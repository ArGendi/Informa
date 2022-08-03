import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/meal.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/premium_nutrition_provider.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/screens/video_player_screen.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/custom_button.dart';
import 'package:informa/widgets/meal_info_box.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SingleMealScreen extends StatefulWidget {
  static String id = 'detailed meal';
  final Meal meal;
  final int? otherId;
  final int? mealDoneNumber;
  final VoidCallback? onClick;
  final VoidCallback? onBack;
  final bool? isDone;
  const SingleMealScreen({Key? key, required this.meal, this.otherId, this.mealDoneNumber, this.onClick, this.isDone, this.onBack}) : super(key: key);

  @override
  _SingleMealScreenState createState() => _SingleMealScreenState(otherId, mealDoneNumber, isDone);
}

class _SingleMealScreenState extends State<SingleMealScreen> with SingleTickerProviderStateMixin{
  bool _isFavorite = false;
  bool _isLoading = false;
  late bool _isDone;
  bool _isVideoPlayed = false;
  FirestoreService _firestoreService = new FirestoreService();
  final ScrollController _controller = ScrollController();
  YoutubePlayerController? _youtubeController;
  List<String> _saladsIds = [];
  late AnimationController _animationController;
  late Animation<Offset> _offset;
  double _protein = 0, _carb = 0, _fats = 0;

  _SingleMealScreenState(int? id, int? mealDoneNumber, bool? done){
    _isDone = false;
    if(id != null && mealDoneNumber != null){
      if(id == mealDoneNumber) _isDone = true;
    }
    if(done != null){
      if(done) _isDone = true;
    }
  }

  Future<void> _showDoneDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('AlertDialog Title'),
          content: SlideTransition(
            position: _offset,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'بالهنا والشفة يا وحش',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Image.asset(
                  'assets/images/informa_nutrition.png',
                  width: 300,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'اغلاق',
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  onDone(BuildContext context) async{
    var activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
    if(!activeUser!.premium)
      Navigator.pushNamed(context, PlansScreen.id);
    else{
      int newCalories = activeUser.dailyCalories! - widget.meal.calories!.toInt();
      int newProtein = activeUser.dailyProtein! - widget.meal.protein!.toInt();
      int newCarb = activeUser.dailyCarb! - widget.meal.carb!.toInt();
      int newCarbCycle = 0;
      if(activeUser.dailyCarbCycle != null)
       newCarbCycle = activeUser.dailyCarbCycle! - widget.meal.carb!.toInt();
      int newFats = activeUser.dailyFats! - widget.meal.fats!.toInt();
      if(newCalories <= 17 && newCalories >= 0) newCalories = 0;
      if(newProtein == 1) newProtein = 0;
      if(newCarb == 1) newCarb = 0;
      if(newCarbCycle == 1) newCarbCycle = 0;
      if(newFats == 1) newFats = 0;

      setState(() {_isLoading = true;});

      String id = FirebaseAuth.instance.currentUser!.uid;
      await _firestoreService.updateUserData(id, {
        'dailyCalories': newCalories,
        'dailyProtein': newProtein,
        'dailyCarb': newCarb,
        'dailyFats': newFats,
        'dailyCarbCycle': newCarbCycle,
      });
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setDailyCalories(newCalories);
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setDailyProtein(newProtein);
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setDailyCarb(newCarb);
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setDailyFats(newFats);
      Provider.of<ActiveUserProvider>(context, listen: false)
          .setDailyCarbCycle(newCarbCycle);

      if(widget.onClick != null) widget.onClick!();

      setState(() {_isLoading = false;});
      setState(() {_isDone = true;});

      _showDoneDialog();
      _animationController.forward();
    }
  }

  onCancel(BuildContext context) async{
    var activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
    int newCalories = activeUser!.dailyCalories! + widget.meal.calories!.toInt();
    int newProtein = activeUser.dailyProtein! + widget.meal.protein!.toInt();
    int newCarb = activeUser.dailyCarb! + widget.meal.carb!.toInt();
    int newCarbCycle = activeUser.dailyCarbCycle! + widget.meal.carb!.toInt();
    int newFats = activeUser.dailyFats! + widget.meal.fats!.toInt();

    setState(() {_isLoading = true;});

    String id = FirebaseAuth.instance.currentUser!.uid;
    await _firestoreService.updateUserData(id, {
      'dailyCalories': newCalories,
      'dailyProtein': newProtein,
      'dailyCarb': newCarb,
      'dailyFats': newFats,
      'dailyCarbCycle': newCarbCycle,
    });
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyCalories(newCalories);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyProtein(newProtein);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyCarb(newCarb);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyFats(newFats);
    Provider.of<ActiveUserProvider>(context, listen: false)
        .setDailyCarbCycle(newCarbCycle);

    if(widget.onBack != null) widget.onBack!();

    setState(() {_isLoading = false;});
    setState(() {_isDone = false;});
  }

  String convertMealIntoString(Meal meal){
    String r = '';
    r += meal.amount!.toString() + ' ';
    if(meal.unit!.trim() == 'gm' || meal.unit!.trim() == 'tsp') r += 'جرام ';
    r += meal.name!;
    return r;
  }

  Future scrollUp() async{
    await _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future scrollDown() async{
    await _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  runYoutubePlayer(String video){
    _youtubeController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(video)!,
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: true,
        )
    );
  }

  onPlayVideo(String video) async{
    if(_youtubeController != null){
      _youtubeController!.pause();
      await scrollUp();
      _youtubeController!.load(YoutubePlayer.convertUrlToId(video)!);
      return;
    }
    else{
      await scrollUp();
      setState(() {
        runYoutubePlayer(video);
        _isVideoPlayed = true;
      });
    }
  }

  Widget getMealSections(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المكونات',
          style: TextStyle(
            fontSize: 20,
            //color: primaryColor,
          ),
        ),
        for(int i=0; i<widget.meal.sections!.length; i++)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.meal.sections![i].name!,
                  style: TextStyle(
                      fontSize: 18,
                    color: primaryColor,
                  ),
                ),
                if(widget.meal.video != null)
                InkWell(
                  onTap: (){
                    onPlayVideo(widget.meal.video!);
                  },
                  child: Card(
                    elevation: 0,
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //SizedBox(height: 15,),
            for(int j=0; j<widget.meal.sections![i].meals!.length; j++)
              Text(
                (j+1).toString() + '- ' + convertMealIntoString(widget.meal.sections![i].meals![j]),
              ),
            Divider(height: 20,),
          ],
        ),
      ],
    );
  }

  Widget getMealComponents(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المكونات',
          style: TextStyle(
              fontSize: 20,
              color: primaryColor
          ),
        ),
        for(int i=0; i<widget.meal.components!.length; i++)
          Text(
            (i+1).toString() + '- ' + widget.meal.components![i],
          ),
      ],
    );
  }

  Widget getOptional(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أختار نوع واحد من السلطة',
          style: TextStyle(
            fontSize: 16,
            fontFamily: boldFont,
          ),
        ),
        for(var salad in widget.meal.salads!)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    if(_saladsIds.contains(salad.id!))
                      _saladsIds.remove(salad.id!);
                    else  _saladsIds.add(salad.id!);
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      salad.name!,
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                      ),
                    ),
                    Icon(
                      _saladsIds.contains(salad.id!) ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              if(_saladsIds.contains(salad.id!))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 10,),
                    for(int i=0; i<salad.components!.length; i++)
                      Text(
                        (i+1).toString() + '- ' + salad.components![i],
                      ),
                  ],
               ),
              SizedBox(height: 10,),
            ],
          ),
      ],
    );
  }

  calculateAccurateMarcos(){
    //double p = 0, c = 0, f = 0;
    if(widget.meal.sections != null){
      for(var section in widget.meal.sections!){
        for(var meal in section.meals!){
          if(meal.serving == 1){
            _protein += meal.protein! * meal.amount!;
            _carb += meal.carb! * meal.amount!;
            _fats += meal.fats! * meal.amount!;
          }
          else{
            _protein += meal.protein! * (meal.amount! / 100);
            _carb += meal.carb! * (meal.amount! / 100);
            _fats += meal.fats! * (meal.amount! / 100);
          }
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _offset = Tween<Offset>(
      begin: Offset(0, -2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    calculateAccurateMarcos();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
    if(_youtubeController != null)
      _youtubeController!.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    if(_youtubeController != null)
      _youtubeController!.pause();
  }


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: ListView(
          controller: _controller,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: !_isVideoPlayed ? Stack(
                children: [
                  Hero(
                    tag: widget.meal.id!,
                    child: widget.meal.image != null ? Image.network(
                      widget.meal.image!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300,
                    ) : Container(
                      width: double.infinity,
                      height: 300,
                      color: Colors.grey[300],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 300,
                    alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.grey.withOpacity(0.0),
                            Colors.black,
                          ],
                        )
                    ),
                  ),
                ],
              ) : YoutubePlayerBuilder(
                player: YoutubePlayer(
                  progressColors: ProgressBarColors(
                      playedColor: primaryColor,
                      handleColor: Colors.white
                  ),
                  progressIndicatorColor: primaryColor,
                  controller: _youtubeController!,
                ),
                builder: (context , player) {
                  return player;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                    indent: screenSize.width * 0.37,
                    endIndent: screenSize.width * 0.37,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(widget.meal.category != null)
                        Text(
                          widget.meal.category!,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.meal.name!,
                            style: TextStyle(
                              fontSize: 24,
                              height: 1.6
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                              if(!activeUser!.premium){
                                Navigator.pushNamed(context, PlansScreen.id);
                              }
                              else{
                                setState(() {
                                  _isFavorite = !_isFavorite;
                                });
                              }
                            },
                            splashRadius: 5,
                            icon: Icon(
                              _isFavorite ? Icons.bookmark_outlined : Icons.bookmark_outline,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      //SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'نسب الوجبة',
                            style: TextStyle(
                              fontSize: 12
                            ),
                          ),
                          if(!activeUser!.premium)
                            TextButton(
                              onPressed: (){
                                Navigator.pushNamed(context, PlansScreen.id);
                              },
                              child: Text(
                                'الترقية الي أنفورما بلس',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MealInfoBox(
                            text: 'سعرات حرارية',
                            value: widget.meal.calories!.toInt(),
                            percent: 0.0,
                          ),
                          MealInfoBox(
                            text: 'بروتين',
                            value: widget.meal.protein!.toInt(),
                            percent: 0.0,
                          ),
                          MealInfoBox(
                            text: 'كاربوهايدرات',
                            value: widget.meal.carb!.toInt(),
                            percent: 0.0,
                          ),
                          MealInfoBox(
                            text: 'دهون',
                            value: widget.meal.fats!.toInt(),
                            percent: 0.0,
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),

                      Text('p:' + _protein.toStringAsFixed(2) + ' - c:' + _carb.toStringAsFixed(2) + ' - f:' + _fats.toStringAsFixed(2)),
                      SizedBox(height: 20,),

                      widget.meal.sections != null ?
                        getMealSections() : getMealComponents(),

                       if(widget.meal.salads != null) getOptional(),
                    ],
                  ),
                  SizedBox(height: 20,),
                  CustomButton(
                    text: _isDone ? 'لم انتهي بعد' : 'تم',
                    onClick: (){
                      if(!_isDone) onDone(context);
                      else onCancel(context);
                    },
                    iconExist: false,
                    isLoading: _isLoading,
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
