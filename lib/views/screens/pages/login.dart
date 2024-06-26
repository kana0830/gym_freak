import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:gym_freak/models/aurh_service.dart';

/// ログイン画面
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Freak - 筋トレ記録アプリ -'),
        backgroundColor: const Color(0xFF7b755e),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SignInButton(
                Buttons.Google,
                onPressed: () async {
                  final service = AuthService();
                  await service.sighIn(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
