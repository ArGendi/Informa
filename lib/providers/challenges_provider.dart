import 'package:flutter/cupertino.dart';
import 'package:informa/models/challenge.dart';

class ChallengesProvider extends ChangeNotifier{
  List<Challenge> _challenges = [
    // Challenge(
    //   name: 'تحدي شيست بريس',
    //   description: 'تحدي الشيست بريس هو عبارة عن تحدي تقوم بيه بعمل 100 ضغط',
    //   deadline: DateTime(
    //     DateTime.now().year,
    //     DateTime.now().month,
    //     DateTime.now().day + 1,
    //   ),
    // ),
  ];
  bool _isDataLoaded = false;

  List<Challenge> get challenges => _challenges;
  bool get isDataLoaded => _isDataLoaded;

  setChallenges(List<Challenge> challenges){
    _challenges = [...challenges];
    notifyListeners();
  }

  addChallenge(Challenge challenge){
    _challenges.add(challenge);
    notifyListeners();
  }

  removeChallenge(Challenge challenge){
    _challenges.remove(challenge);
    notifyListeners();
  }

  dataLoaded(){
    _isDataLoaded = true;
    notifyListeners();
  }

}