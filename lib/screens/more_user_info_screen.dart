import 'package:flutter/material.dart';
import 'package:informa/helpers/shared_preference.dart';
import 'package:informa/providers/active_user_provider.dart';
import 'package:informa/services/firestore_service.dart';
import 'package:informa/widgets/confirm_user_info.dart';
import 'package:informa/widgets/enter_fats_percent.dart';
import 'package:informa/widgets/register.dart';
import 'package:informa/widgets/select_age_tall_weight.dart';
import 'package:informa/widgets/select_fat_percent.dart';
import 'package:informa/widgets/select_level.dart';
import 'package:informa/widgets/select_tools.dart';
import 'package:informa/widgets/select_training_days.dart';
import 'package:informa/widgets/select_training_period.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'main_screen.dart';

class MoreUserInfoScreen extends StatefulWidget {
  static String id = 'more user info';
  const MoreUserInfoScreen({Key? key}) : super(key: key);

  @override
  _MoreUserInfoScreenState createState() => _MoreUserInfoScreenState();
}

class _MoreUserInfoScreenState extends State<MoreUserInfoScreen> {
  int _initialPage = 0;
  final PageController _controller = PageController(initialPage: 0);
  FirestoreService _firestoreService = new FirestoreService();
  bool _isLoading = false;

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

  onConfirm(BuildContext context) async{
    bool done = true;
    var activeUser = Provider.of<ActiveUserProvider>(context, listen: false).user;
    setState(() { _isLoading = true; });
    await _firestoreService.saveNewAccountWithFullInfo(activeUser!).catchError((e){
      setState(() { _isLoading = false; });
      done = false;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ'))
      );
    });
    if(done) {
      await activeUser.saveInSharedPreference();
      await HelpFunction.saveInitScreen(MainScreen.id);
      setState(() { _isLoading = false; });
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainScreen.id, (Route<dynamic> route) => false);
    }
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
              FatsPercent(
                onBack: goBack,
                onClick: goToNextPage,
              ),
              SelectFatPercent(
                onBack: goBack,
                onNext: (){
                  onConfirm(context);
                },
                loading: _isLoading,
              ),
              // SelectLevel(
              //   onClick: goToNextPage,
              //   onBack: goBack,
              // ),
              // SelectTrainingPeriod(
              //   onClick: goToNextPage,
              //   onBack: goBack,
              // ),
              // if(activeUser!.workoutPlace != 2)
              //   SelectTools(
              //     onClick: goToNextPage,
              //     onBack: goBack,
              //   ),
              // SelectTrainingDays(
              //   onClick: goToNextPage,
              //   onBack: goBack,
              // ),
              // ConfirmUserInfo(
              //   onBack: goBack,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
