import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _userProfile;
  GoogleSignInAccount get user => _userProfile!;

  Future signInGoogle() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return;
    _userProfile = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }

  Future signOutGoogle() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
