import 'package:flutter/material.dart';
import 'package:informa/constants.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/screens/main_screen.dart';
import 'package:informa/widgets/select_gender.dart';
import 'package:informa/widgets/select_goal.dart';
import 'package:informa/widgets/select_program.dart';
import 'package:provider/provider.dart';

class RegisterScreens extends StatefulWidget {
  const RegisterScreens({Key? key}) : super(key: key);

  @override
  _RegisterScreensState createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  int _initialPage = 0;
  final PageController _controller = PageController(initialPage: 0);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        leading: _initialPage != 0 ? IconButton(
          onPressed: (){
            _controller.animateToPage(
                _initialPage - 1,
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut
            );
            setState(() {
              _initialPage -= 1;
            });
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
        ) : Container(),
      ),
      body: PageView(
        physics:new NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          SelectGender(
            onClick: goToNextPage,
          ),
          SelectProgram(
            onClick: goToNextPage,
          ),
          SelectGoal(
            onClick: (){
              Navigator.pushNamed(context, MainScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
