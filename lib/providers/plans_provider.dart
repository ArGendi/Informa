import 'package:flutter/cupertino.dart';
import 'package:informa/models/plans.dart';

class PlansProvider extends ChangeNotifier {
  bool get isDataLoaded => _isDataLoaded;

  // diet plans
  List<Plans> _dietPlans = [];

  bool _isDataLoaded = false;

  List<Plans> get dietPlans => _dietPlans;

  setDietSupplements(List<Plans> supplement) {
    _dietPlans = [...supplement];
    notifyListeners();
  }

  addDietSupplement(Plans supplement) {
    _dietPlans.add(supplement);
    notifyListeners();
  }

  removeDietSupplement(Plans supplement) {
    _dietPlans.remove(supplement);
    notifyListeners();
  }

// training plans

  List<Plans> _trainingPlans = [];

  List<Plans> get trainingPlans => _trainingPlans;

  setTrainingSupplements(List<Plans> supplement) {
    _trainingPlans = [...supplement];
    notifyListeners();
  }

  addTrainingSupplement(Plans supplement) {
    _trainingPlans.add(supplement);
    notifyListeners();
  }

  removeTrainingSupplement(Plans supplement) {
    _trainingPlans.remove(supplement);
    notifyListeners();
  }

// diet and training plans

  List<Plans> _dietAndTrainingPlans = [];

  List<Plans> get dietAndTrainingPlans => _dietAndTrainingPlans;

  setDietAndTrainingSupplements(List<Plans> supplement) {
    _dietAndTrainingPlans = [...supplement];
    notifyListeners();
  }

  addDietAndTrainingSupplement(Plans supplement) {
    _dietAndTrainingPlans.add(supplement);
    notifyListeners();
  }

  removeDietAndTrainingSupplement(Plans supplement) {
    _dietAndTrainingPlans.remove(supplement);
    notifyListeners();
  }

  dataLoaded() {
    _isDataLoaded = true;
    notifyListeners();
  }
}
