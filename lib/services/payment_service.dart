import 'dart:convert';

import 'package:informa/models/user.dart';
import 'package:informa/services/web_services.dart';

class PaymentService{
  String _authRequestUrl = 'https://accept.paymob.com/api/auth/tokens';
  String _orderRegRequestUrl = 'https://accept.paymob.com/api/ecommerce/orders';
  String _paymentKeyRequestUrl = 'https://accept.paymob.com/api/acceptance/payment_keys';
  WebServices _webServices = new WebServices();

  Future<String?> authRequest() async{
    var response = await _webServices.post(_authRequestUrl, {
      "api_key": "ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6VXhNaUo5LmV5SndjbTltYVd4bFgzQnJJam94TkRnMk56SXNJbU5zWVhOeklqb2lUV1Z5WTJoaGJuUWlMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuMkc4OHdiaXNsWjJDQjVudkZoblRxaF9sQ1BjWUR4MUxLTk5sNzNpQ1F2RXhHLXhfdG5lNFdVb3hPa0dXUkJuNm4tUzlTejVHWUxmR0gxY2tPVXJVR1E="
    });
    if(response.statusCode >=200 && response.statusCode < 300){
      var body = jsonDecode(response.body);
      String token = body['token'];
      return token;
    }
    else return null;
  }

  Future<String?> orderRegRequest(String token, int price, List<Map<String, String>> items) async{
    var response = await _webServices.post(_orderRegRequestUrl, {
      "auth_token":  token,
      "delivery_needed": "false",
      "amount_cents": (price * 100).toString(),
      "currency": "EGP",
      "items": items,
    });
    if(response.statusCode >=200 && response.statusCode < 300){
      var body = jsonDecode(response.body);
      String id = body['id'].toString();
      return id;
    }
    else return null;
  }

  Future<String?> paymentKeyRequest(String token, String id, int price, AppUser user) async{
    List<String> fullName = user.name!.split(' ');
    String firstName = fullName[0];
    String lastName = fullName.length > 1 ? fullName[1] : 'informa';
    var response = await _webServices.post(_paymentKeyRequestUrl, {
      "auth_token": token,
      "amount_cents": (price * 100).toString(),
      "expiration": 3600,
      "order_id": id,
      "billing_data": {
        "first_name": firstName,
        "last_name": lastName,
        "email": user.email,
        "phone_number": user.phone,
        "country": "NA",
        "apartment": "NA",
        "floor": "NA",
        "street": "NA",
        "building": "NA",
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": 1711358
    });
    if(response.statusCode >=200 && response.statusCode < 300){
      var body = jsonDecode(response.body);
      String token = body['token'];
      return token;
    }
    else return null;
  }

}