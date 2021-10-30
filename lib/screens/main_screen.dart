import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:informa/constants.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/analytics_screen.dart';
import 'package:informa/screens/free_kitchen_screen.dart';
import 'package:informa/screens/home_screen.dart';
import 'package:informa/screens/nutrition_screen.dart';
import 'package:informa/screens/profile_screen.dart';
import 'package:informa/screens/workout_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static String id = 'main';
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;
  final _pageStorageBucket = PageStorageBucket();
  Widget _currentPage = HomeScreen();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageStorage(
        bucket: _pageStorageBucket,
        child: _currentPage,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          width: double.infinity,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Profile
                MaterialButton(
                  shape: CircleBorder(),
                  minWidth: 40,
                  onPressed: (){
                    setState(() {
                      _selectedIndex = 0;
                      _currentPage = ProfileScreen();
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/user.svg',
                        semanticsLabel: 'user',
                        color: _selectedIndex == 0 ? primaryColor : Colors.grey[400],
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        'حسابي',
                        style: TextStyle(
                            color: _selectedIndex == 0 ? primaryColor : Colors.grey[400],
                            fontSize: 10
                        ),
                      ),
                    ],
                  ),
                ),
                //Analytics
                MaterialButton(
                  shape: CircleBorder(),
                  minWidth: 40,
                  onPressed: (){
                    setState(() {
                      _selectedIndex = 1;
                      _currentPage = AnalyticsScreen();
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/chart-histogram.svg',
                        semanticsLabel: 'chart',
                        color: _selectedIndex == 1 ? primaryColor : Colors.grey[400],
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        'التقدم',
                        style: TextStyle(
                            color: _selectedIndex == 1 ? primaryColor : Colors.grey[400],
                            fontSize: 10
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 70,
                  height: 50,
                ),
                //Workout
                MaterialButton(
                  shape: CircleBorder(),
                  minWidth: 40,
                  onPressed: (){
                    setState(() {
                      _selectedIndex = 3;
                      _currentPage = WorkoutScreen();
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/gym.svg',
                        semanticsLabel: 'gym',
                        color: _selectedIndex == 3 ? primaryColor : Colors.grey[400],
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        'التمارين',
                        style: TextStyle(
                            color: _selectedIndex == 3 ? primaryColor : Colors.grey[400],
                            fontSize: 10
                        ),
                      ),
                    ],
                  ),
                ),
                //Nutrition
                MaterialButton(
                  shape: CircleBorder(),
                  minWidth: 40,
                  onPressed: (){
                    setState(() {
                      _selectedIndex = 4;
                      _currentPage = NutritionScreen();
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/fish.svg',
                        semanticsLabel: 'user',
                        color: _selectedIndex == 4 ? primaryColor : Colors.grey[400],
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        'التغذية',
                        style: TextStyle(
                            color: _selectedIndex == 4 ? primaryColor : Colors.grey[400],
                            fontSize: 10
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
            _currentPage = HomeScreen();
          });
        },
        child: SvgPicture.asset(
          'assets/icons/home.svg',
          semanticsLabel: 'home',
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
