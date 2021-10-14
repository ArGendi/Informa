import 'package:flutter/cupertino.dart';

class AppLanguageProvider extends ChangeNotifier {
  String _lang = 'ar';

  String get lang => _lang;

  changeLang(lang){
    _lang = lang;
    notifyListeners();
  }

}