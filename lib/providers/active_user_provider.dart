import 'package:flutter/cupertino.dart';
import 'package:informa/models/user.dart';

class ActiveUserProvider extends ChangeNotifier{
  User _user = new User();

  User get user => _user;

  setUser(User user){
    _user = user;
    notifyListeners();
  }

}