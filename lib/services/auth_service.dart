import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final _fb = FacebookLogin();
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount get user => _user!;
  FacebookLogin get fb => _fb;
  GoogleSignIn get googleSignIn => _googleSignIn;

  Future<UserCredential?> loginWithFacebook() async {
    final res = await _fb.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ],
    );
    switch (res.status) {
      case FacebookLoginStatus.success:
        print('It worked');
        final FacebookAccessToken? fbToken = res.accessToken;
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(fbToken!.token);
        final userCredential =
            await _auth.signInWithCredential(facebookCredential);
        final profile = await _fb.getUserProfile();
        print('Profile: ' + profile!.firstName.toString());
        final email = await _fb.getUserEmail();
        print('Email: ' + email!);
        return userCredential;
        break;
      case FacebookLoginStatus.cancel:
        print('facebook canceled the login here');
        return null;
        break;
      case FacebookLoginStatus.error:
        print('facebook error here');
        return null;
        break;
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      var cred = await _auth.signInWithCredential(credential);
      print(_user!.email);
      print(_user!.displayName);
      return cred;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
      } else if (e.code == 'invalid-credential') {
        // handle the error here
      }
      return null;
    } catch (e) {
      // handle the error here
      return null;
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred;
    } on FirebaseAuthException {
      return null;
    }
  }

  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return '#' + 'رقم المرور ضعيف';
      } else if (e.code == 'email-already-in-use') {
        return '#' + 'الحساب موجود بالفعل';
      }
    }
    return null;
  }

  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      return "Signed out";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
    return null;
  }

  User? getUser() {
    try {
      return _auth.currentUser;
    } on FirebaseAuthException {
      return null;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
