import 'package:flutter/material.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/widgets/confirm_user_info.dart';
import 'package:informa/widgets/register.dart';
import 'package:informa/widgets/select_age_tall_weight.dart';
import 'package:informa/widgets/select_fat_percent.dart';
import 'package:informa/widgets/select_level.dart';
import 'package:informa/widgets/select_tools.dart';
import 'package:informa/widgets/select_training_days.dart';
import 'package:informa/widgets/select_training_period.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class MoreUserInfoScreen extends StatefulWidget {
  static String id = 'more user info';
  const MoreUserInfoScreen({Key? key}) : super(key: key);

  @override
  _MoreUserInfoScreenState createState() => _MoreUserInfoScreenState();
}

class _MoreUserInfoScreenState extends State<MoreUserInfoScreen> {
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
              Register(
                onClick: goToNextPage,
                onBack: (){
                  Navigator.pop(context);
                },
              ),
              SelectAgeTallWeight(
                onClick: goToNextPage,
                onBack: goBack,
              ),
              SelectLevel(
                onClick: goToNextPage,
                onBack: goBack,
              ),
              SelectFatPercent(
                onClick: goToNextPage,
                onBack: goBack,
              ),
              SelectTrainingPeriod(
                onClick: goToNextPage,
                onBack: goBack,
              ),
              if(activeUser!.workoutPlace != 2)
                SelectTools(
                  onClick: goToNextPage,
                  onBack: goBack,
                ),
              SelectTrainingDays(
                onClick: goToNextPage,
                onBack: goBack,
              ),
              ConfirmUserInfo(
                onBack: goBack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
