import 'dart:convert';

import 'package:informa/services/web_services.dart';

class CountryCodeService{

  late WebServices _webServices;

  CountryCodeService(){
    _webServices = new WebServices();
  }

  Future<dynamic> getAllCountries() async{
    var response = await _webServices.get('https://restcountries.com/v2/all');
    print("response code: " + response.statusCode.toString());
    if(response.statusCode >= 200 && response.statusCode < 300){
      print('Getting countries');
      var body = jsonDecode(response.body);
      return body;
    }
    print('Can\'t getting countries');
    return null;
  }
}