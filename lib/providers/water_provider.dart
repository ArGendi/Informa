import 'package:flutter/cupertino.dart';
import 'package:informa/models/water.dart';

class WaterProvider extends ChangeNotifier{
  late Water _water;

  WaterProvider(){
    _water = new Water();
  }

  Water get water => _water;


  setStatus(bool value){
    _water.isActivated = value;
    notifyListeners();
  }

  setNumberOfTimes(int value){
    _water.numberOfTimes = value;
    notifyListeners();
  }

  setWater(Water water){
    _water = water;
    notifyListeners();
  }

}