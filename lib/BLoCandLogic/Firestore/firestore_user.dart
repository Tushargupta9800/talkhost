import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/User.dart';

Stream<User> readUser(String? emailId) => FirebaseFirestore.instance
    .collection("users")
    .doc(emailId)
    .snapshots()
    .map((snapshot) => User.fromJson(snapshot.data()));

Future createUserInFirestore({required String? email}) async {
  final docUser = FirebaseFirestore.instance.collection("users").doc(email);
  var docExist = await docUser.get();
  if(!docExist.exists) {
    User.email = email!;
    log("creating the user in firestore with email");
    log(email);
    log(User.email);
    log("************");
    await docUser.set(User.toJson());
  }
}
