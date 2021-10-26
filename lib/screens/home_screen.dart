import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/home_banner.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var activeUser = Provider.of<ActiveUserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('الرئيسية',),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          if(activeUser!.premium)
            Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bg_man.jpg',),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'أنضم الي عائلة أنفورما',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'CairoBold',
                        color: Colors.white,
                      ),
                    ),
                    //SizedBox(height: 10,),
                    Text(
                      'للحصول علي برنامج تغذية وتمارين مخصصة لجسمك بالأضافة الي مميزات غير محدودة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                        height: 1.5
                      ),
                    ),
                    SizedBox(height: 10,),
                    MaterialButton(
                      onPressed: (){},
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'أنضم الأن',
                          style: TextStyle(
                            fontSize: 16,
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                HomeBanner(
                  mainText: 'تمارين انفورما',
                  subText: 'للحصول علي برنامج تغذية وتمارين ',
                  btnText: 'تصفح التمارين',
                  onClick: (){},
                ),
                SizedBox(height: 20,),
                HomeBanner(
                  mainText: 'مطبخ انفورما',
                  subText: 'للحصول علي برنامج تغذية وتمارين ',
                  btnText: 'تصفح الوجبات',
                  onClick: (){},
                ),
                SizedBox(height: 20,),
                HomeBanner(
                  mainText: 'تحديات انفورما',
                  subText: 'للحصول علي برنامج تغذية وتمارين ',
                  btnText: 'تصفح التحديات',
                  onClick: (){},
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
