import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym_freak/firebase_options.dart';
import 'package:gym_freak/view/screens/home_screen.dart';
import 'package:gym_freak/view/screens/login_screen.dart';
import 'package:gym_freak/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);

    return MaterialApp(
      title: 'gym_freak',
      theme: ThemeData(
          brightness: Brightness.dark,
          textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16.0))),
      home: FutureBuilder(
        future: loginViewModel.isSingIn(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
