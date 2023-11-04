import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym_freak/firebase_options.dart';
import 'package:gym_freak/screens/home_screen.dart';

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
    return MaterialApp(
      title: 'gym_freak',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16.0))
      ),
      home: HomeScreen(),
    );
  }
}
