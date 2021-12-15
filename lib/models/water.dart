import 'package:informa/helpers/shared_preference.dart';

class Water {
  bool isActivated = false;
  int numberOfTimes = 0;

  Water({this.isActivated = false, this.numberOfTimes = 0});

  Future getFromSharedPreference() async{
    bool? activated = await HelpFunction.getUserWaterIsActivated();
    int? nOT = await HelpFunction.getUserWaterNumberOfTimes();
    if(activated != null)
      isActivated = activated;
    if(nOT != null)
      numberOfTimes = nOT;
  }
}