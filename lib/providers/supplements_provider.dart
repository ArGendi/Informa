import 'package:flutter/cupertino.dart';
import 'package:informa/models/supplement.dart';

class SupplementsProvider extends ChangeNotifier {
  List<Supplement> _supplements = [
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

  List<Supplement> get supplement => _supplements;
  bool get isDataLoaded => _isDataLoaded;

  setSupplements(List<Supplement> supplement) {
    _supplements = [...supplement];
    notifyListeners();
  }

  addSupplement(Supplement supplement) {
    _supplements.add(supplement);
    notifyListeners();
  }

  removeSupplement(Supplement supplement) {
    _supplements.remove(supplement);
    notifyListeners();
  }

  dataLoaded() {
    _isDataLoaded = true;
    notifyListeners();
  }
}
