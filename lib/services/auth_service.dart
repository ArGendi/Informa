import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  static final fb = FacebookLogin();
  static final googleSignIn = GoogleSignIn();
  static GoogleSignInAccount? user;
  //GoogleSignInAccount get user => _user!;

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

  static Future<bool> googleLogin() async{
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null) return false;
    user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print(user!.email);
    print(user!.displayName);
    return true;
  }
}