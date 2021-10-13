import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthServices {
  static final fb = FacebookLogin();

  static Future<bool> loginWithFacebook() async{
    final res = await fb.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ],
    );
    switch(res.status){
      case FacebookLoginStatus.success:
        print('It worked');
        final FacebookAccessToken? fbToken = res.accessToken;
        final profile = await fb.getUserProfile();
        print('Profile: ' + profile!.firstName.toString());
        final email = await fb.getUserEmail();
        print('Email: ' + email!);
        return true;
        break;
      case FacebookLoginStatus.cancel:
        print('facebook canceled the login here');
        return false;
        break;
      case FacebookLoginStatus.error:
        print('facebook error here');
        return false;
        break;
    }
  }
}