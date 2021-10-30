import 'package:http/http.dart';
import 'package:informa/services/web_services.dart';

class EmailService{
  WebServices? _webServices;

  EmailService(){
    _webServices  = new WebServices();
  }

  Future<Response> sendVerificationCode(String email, String code) async{
    var response = await _webServices!.postWithOrigin('https://api.emailjs.com/api/v1.0/email/send', {
      "user_id": "user_sL5eCDqsL5h8Jaoq71PH0",
      "service_id": "service_emgj8vt",
      "template_id": "template_9oefxlr",
      "template_params": {
        'user_message': code,
        'to_email': email,
      }
    });
    return response;
  }
}