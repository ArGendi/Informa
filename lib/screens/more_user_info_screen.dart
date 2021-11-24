import 'package:flutter/material.dart';
import 'package:informa/widgets/select_age_tall_weight.dart';
import 'package:informa/widgets/select_fat_percent.dart';
import 'package:informa/widgets/select_level.dart';
import 'package:informa/widgets/select_tools.dart';
import 'package:informa/widgets/select_training_days.dart';
import 'package:informa/widgets/select_training_period.dart';

import '../constants.dart';

class MoreUserInfoScreen extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        leading: _initialPage != 0 ? IconButton(
          splashRadius: splashRadius,
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
          SelectAgeTallWeight(
            onClick: goToNextPage,
          ),
          SelectLevel(
            onClick: goToNextPage,
          ),
          SelectFatPercent(
            onClick: goToNextPage,
          ),
          SelectTrainingPeriod(
            onClick: goToNextPage,
          ),
          SelectTools(
            onClick: goToNextPage,
          ),
          SelectTrainingDays(
            onClick: (){},
          ),
        ],
      ),
    );
  }
}
