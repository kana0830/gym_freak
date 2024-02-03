import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../views/screens/home_screen.dart';

class AuthService {
  Future<void> sighIn(context) async {
    print('サービスクラスが動きました');

    const clientId =
        '437282078150-ah80jvlernp1e82t1q70n6fddqf4hl93.apps.googleusercontent.com';

    const scope = [
      'openid',
      'profile',
      'email',
    ];

    // Googleサインイン画面へ飛ばす
    final request = GoogleSignIn(clientId: clientId, scopes: scope);
    final response = await request.signIn();

    // responseデータからアクセストークンと取得
    final authn = await response?.authentication;
    final accessToken = authn?.accessToken;

    // アクセストークンが取得できない場合は中止
    if (accessToken == null) {
      return;
    }

    // firebaseへアクセストークンを送る
    final oAuthCredential = GoogleAuthProvider.credential(
      accessToken: accessToken,
    );
    final userCred =
        await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
    final idToken = await userCred.user?.getIdToken();


    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen()));
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
