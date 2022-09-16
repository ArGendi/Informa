import 'package:flutter/material.dart';
import 'package:informa/screens/auth_screens/main_register_screen.dart';
import 'package:informa/screens/pageview_screens/select_gender.dart';

class RegisterScreens extends StatefulWidget {
  static String id = 'register screens';
  const RegisterScreens({Key? key}) : super(key: key);

  @override
  _RegisterScreensState createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  int _initialPage = 0;
  final PageController _controller = PageController(initialPage: 0);

  goToNextPage() {
    _controller.animateToPage(_initialPage + 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    setState(() {
      _initialPage += 1;
    });
  }

  goBack() {
    _controller.animateToPage(_initialPage - 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    setState(() {
      _initialPage -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png'))),
        child: SafeArea(
          child: PageView(
            physics: new NeverScrollableScrollPhysics(),
            controller: _controller,
            children: [
              SelectGender(
                onClick: () {
                  Navigator.pushNamed(context, MainRegisterScreen.id);
                },
              ),
              // SelectPlace(
              //   onClick: (){
              //     Navigator.pushNamed(context, MainRegisterScreen.id);
              //   },
              //   onBack: goBack,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
