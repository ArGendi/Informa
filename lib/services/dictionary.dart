class Dictionary{
  String convertLevelToString(int level){
    if(level == 1)
      return 'خبرتي بسيطة وبتعب بسرعة';
    else if(level == 2)
      return 'بتمرن بشكل متقتع وعندي لياقة معقولة';
    else if(level == 3)
      return 'بتمرن بشكل منتظم ولياقتي عالية';
    else if(level == 4)
      return 'شخص رياضي وبقدر أعمل تمارين متقدمة';
    return 'لا يوجد';
  }

  String convertTrainingPeriodToString(int value){
    if(value == 1)
      return 'طويلة (أكتر من ساعة)';
    else if(value == 2)
      return 'متوسط (أقل من ساعة)';
    else if(value == 3)
      return 'قصيرة (حوالي نص ساعة)';
    return 'لا يوجد';
  }

  String convertTrainingToolsToString(List<int> tools){
    String result = '';
    for(var tool in tools){
      if(tool == 1)
        result += 'دامبل';
      else if(tool == 2)
        result += 'بار';
      else if(tool == 3)
        result += 'كاتل بيل';
      result += ',';
    }
    return result.length > 0 ? result : 'لا يوجد';
  }

}