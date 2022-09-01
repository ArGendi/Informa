import 'package:flutter/cupertino.dart';
import 'package:informa/models/plans.dart';

class PlansProvider extends ChangeNotifier {
  List<Plans> _plans = [
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

  List<Plans> get plans => _plans;
  bool get isDataLoaded => _isDataLoaded;

  setSupplements(List<Plans> supplement) {
    _plans = [...supplement];
    notifyListeners();
  }

  addSupplement(Plans supplement) {
    _plans.add(supplement);
    notifyListeners();
  }

  removeSupplement(Plans supplement) {
    _plans.remove(supplement);
    notifyListeners();
  }

  dataLoaded() {
    _isDataLoaded = true;
    notifyListeners();
  }
}
