import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatabaseManager {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);


  Future<String> get() async {
    CollectionReference todo = FirebaseFirestore.instance.collection('user');
    return todo.toString();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('user');

    return StreamBuilder<QuerySnapshot>(
      stream: user.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return ListTile(
                title: Text(document.get('userName')),
              );
            }).toList(),);


      // FutureBuilder<DocumentSnapshot>(
      // future: user.doc(documentId).get(),
      // builder:
      //     (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        // if (snapshot.hasError) {
        //   return Text("Something went wrong");
        // }
        //
        // if (snapshot.hasData && !snapshot.data!.exists) {
        //   return Text("Document does not exist");
        // }

        // if (snapshot.connectionState == ConnectionState.done) {
        //   Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        //   return Text("${data['userName']}");
        // }

        // return Text("loading");
      },
    );
  }
}