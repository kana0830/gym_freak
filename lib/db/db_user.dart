import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBUser{
  final db = FirebaseFirestore.instance;

  Future<void> create() async {
    await db.collection('user').doc('2').set(
      {

      }
    );
  }

  Future<void> read() async {
    final userInfo = await db.collection('user').doc('1').get();
    final userInfoStr = userInfo.toString();
  }
}