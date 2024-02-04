import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:gym_freak/models/aurh_service.dart';
import 'package:gym_freak/views/screens/home_screen.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Freak - 筋トレ記録アプリ -'),
        backgroundColor: Color(0xFF7b755e),
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
