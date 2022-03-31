import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:informa/constants.dart';
import 'package:informa/models/challenge.dart';
import 'package:informa/models/meals_list.dart';
import 'package:informa/models/user.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/providers/challenges_provider.dart';
import 'package:informa/screens/challenges_screen.dart';
import 'package:informa/screens/dummy.dart';
import 'package:informa/screens/free_kitchen_screen.dart';
import 'package:informa/screens/plans_screen.dart';
import 'package:informa/screens/premium_screens/premium_form_screen.dart';
import 'package:informa/screens/video_player_screen.dart';
import 'package:informa/services/payment_service.dart';
import 'package:informa/widgets/home_banner.dart';
import 'package:informa/widgets/submit_challenge.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';
import 'muscle_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PaymentService _paymentService = new PaymentService();

  callPaymentAPIs(AppUser user) async{
    bool errorOccur = false;
    String? token = await _paymentService.authRequest();
    if(token != null){
      String? id = await _paymentService.orderRegRequest(token, 10, []);
      if(id != null){
        String? token2 = await _paymentService.paymentKeyRequest(token, id, 10, user);
        if(token2 != null){
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Dummy(token: token2)),
          // );
        } else errorOccur = true;
      } else errorOccur = true;
    } else errorOccur = true;

    if(errorOccur)
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ'))
      );
  }

  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    var challengesProvider = Provider.of<ChallengesProvider>(context);
    var localization = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(localization!.translate('الرئيسية').toString(),),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: (){
        //       print('map: ' + activeUser!.toJson().toString());
        //     },
        //     icon: Icon(Icons.add),
        //   )
        // ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/appBg.png')
          )
        ),
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'شاهد شرح التطبيق',
                      style: TextStyle(
                        fontFamily: boldFont,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoPlayerScreen(
                            url: 'https://www.youtube.com/watch?v=sLgz57tguKo',
                          )),
                        );
                      },
                      child: Card(
                        elevation: 0,
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //SizedBox(height: 3,),
            if(activeUser!.premiumStartDate != null)
              Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الوقت المتبقي علي تجهيز البرنامج',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: CountdownTimer(
                        endTime: activeUser.premiumStartDate!.millisecondsSinceEpoch,
                        textStyle: TextStyle(
                            color: primaryColor,
                          fontSize: 14,
                          fontFamily: boldFont,
                        ),
                        endWidget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            '',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12
                            ),
                          ),
                        ),
                        onEnd: (){},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(!activeUser.premium || activeUser.premiumStartDate == null)
              Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                  image: AssetImage('assets/images/home1.png',),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localization.translate('أنضم الي عائلة أنفورما').toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'CairoBold',
                          color: Colors.white,
                        ),
                      ),
                      //SizedBox(height: 10,),
                      Text(
                        localization.translate('للحصول علي برنامج تغذية وتمارين مخصصة لجسمك بالأضافة الي مميزات غير محدودة').toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 10,),
                      MaterialButton(
                        onPressed: (){
                          Navigator.pushNamed(context, PlansScreen.id);
                        },
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            localization.translate('أنضم الأن').toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'CairoBold',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if(activeUser.premium && !activeUser.fillPremiumForm)
              Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                    image: AssetImage('assets/images/home1.png',),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'جاوب عالأسئلة عشان نعملك برنامجك الخاص بيك',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'CairoBold',
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5,),
                        MaterialButton(
                          onPressed: (){
                            Navigator.pushNamed(context, PremiumFormScreen.id);
                          },
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'أبدأ الأسئلة',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'CairoBold',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  HomeBanner(
                    mainText: 'تمارين انفورما',
                    subText: 'تصفح التمارين وابدأ الأن',
                    btnText: 'تصفح التمارين',
                    imagePath: 'assets/images/home3.jpg',
                    onClick: (){
                      Navigator.pushNamed(context, MuscleSelectionScreen.id);
                    },
                  ),
                  SizedBox(height: 10,),
                  HomeBanner(
                    mainText: 'مطبخ انفورما',
                    subText: 'تصفح الوجبات المفيدة الان',
                    btnText: 'تصفح الوجبات',
                    imagePath: 'assets/images/home4.png',
                    onClick: (){
                      Navigator.pushNamed(context, FreeKitchenScreen.id);
                    },
                  ),
                  SizedBox(height: 10,),
                  HomeBanner(
                    mainText: 'تحديات انفورما',
                    subText: 'شارك في التحديات وفز بالهدايا',
                    btnText: 'تصفح التحديات',
                    imagePath: 'assets/images/home2.png',
                    challenge: challengesProvider.challenges.isNotEmpty?
                      challengesProvider.challenges[0] : null,
                    onClick: (){
                      Navigator.pushNamed(context, ChallengesScreen.id);
                    },
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'المشتركين معنا',
                            style: TextStyle(
                              fontFamily: boldFont,
                            ),
                          ),
                          SizedBox(height: 5,),
                          CarouselSlider(
                              items: [
                                Image.asset(
                                  'assets/images/before_after.jpg',
                                  width: 180,
                                ),
                                Image.asset(
                                  'assets/images/before_after.jpg',
                                  width: 180,
                                ),
                                Image.asset(
                                  'assets/images/before_after.jpg',
                                  width: 180,
                                ),
                                Image.asset(
                                  'assets/images/before_after.jpg',
                                  width: 180,
                                ),
                              ],
                              options: CarouselOptions(
                                //height: 200,
                                  aspectRatio: 16/7,
                                  viewportFraction: 0.45,
                                  initialPage: 0,
                                  scrollDirection: Axis.horizontal,
                                  //reverse: false,
                                  enableInfiniteScroll: true,
                                autoPlay: true,
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 75,),
          ],
        ),
      )
    );
  }
}
