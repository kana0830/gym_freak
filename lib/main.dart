import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_freak/repositories/user_repository.dart';
import 'package:gym_freak/views/screens/pages/login.dart';
import 'package:gym_freak/views/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gym_freak',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16.0),
        ),
      ),
      home: _initialPage(),
    );
  }

  Widget _initialPage() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var user = getData(currentUser);
      return HomeScreen(user: user);
    } else {
      return const Login();
    }
  }

  QueryDocumentSnapshot<Map<String, dynamic>> getData(currentUser) {
    try {
      var snapshot = _fetchData(currentUser);
      return snapshot;
    } catch (error) {
      throw Exception('データが取得できませんでした');
    }
  }

  QueryDocumentSnapshot<Map<String, dynamic>> _fetchData(User currentUser) {
    final userRepository = UserRepository();
    var user = userRepository.getUser(currentUser.email!);
    return user;
  }
}
