import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../views/screens/home_screen.dart';

class AuthService {
  static var email = '';
  static var userId = '';

  /// サインイン
  Future<void> sighIn(context) async {

    /// Googleサインイン画面へ飛ばす
    final googleUser = await GoogleSignIn(scopes: [
      'email',
    ]).signIn();

    /// responseデータからアクセストークンと取得
    final googleAuth = await googleUser?.authentication;
    final accessToken = googleAuth?.accessToken;

    /// アクセストークンが取得できない場合は中止
    if (accessToken == null) {
      return;
    }

    /// firebaseへアクセストークンを送る
    final oAuthCredential = GoogleAuthProvider.credential(
      accessToken: accessToken,
    );
    final userCred =
        await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
    if(userCred.user != null) {
      AuthService.email = userCred.user!.email ?? '';
    }
    // AuthService.idToken = (await userCred.user?.getIdToken())!;
    //
    // final userRepository = UserRepository();
    // final user = await userRepository.getUser(email);
    // AuthService.userId = user.id;

    /// ホームスクリーンへ遷移
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeScreen()));
    // builder: (context) => HomeScreen(user: user)));
  }

  /// サインアウト
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
