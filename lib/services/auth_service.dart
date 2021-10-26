import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final _fb = FacebookLogin();
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount get user => _user!;
  FacebookLogin get fb => _fb;
  GoogleSignIn get googleSignIn => _googleSignIn;

  Future<bool> loginWithFacebook() async{
    final res = await _fb.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ],
    );
    switch(res.status){
      case FacebookLoginStatus.success:
        print('It worked');
        final FacebookAccessToken? fbToken = res.accessToken;
        final profile = await _fb.getUserProfile();
        print('Profile: ' + profile!.firstName.toString());
        final email = await _fb.getUserEmail();
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

  Future<bool> loginWithGoogle() async{
    final googleUser = await _googleSignIn.signIn();
    if(googleUser == null) return false;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
      }
      else if (e.code == 'invalid-credential') {
        // handle the error here
      }
      return false;
    } catch (e) {
      // handle the error here
      return false;
    }
    print(_user!.email);
    print(_user!.displayName);
    return true;
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch(e) {
      return e.message;
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch(e) {
      return e.message;
    }
  }

  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      return "Signed out";
    } on FirebaseAuthException catch(e) {
      return e.message;
    }
  }

  User? getUser() {
    try {
      return _auth.currentUser;
    } on FirebaseAuthException {
      return null;
    }
  }
}