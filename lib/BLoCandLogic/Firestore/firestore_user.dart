import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user.dart';

Stream<User> readUser(String? emailId) =>
    FirebaseFirestore.instance.collection("users").doc(emailId).snapshots().map(
          (snapshot) => User.fromJson(
            snapshot.data(),
          ),
        );

Future createUserInFirestore({required String? email}) async {
  User.email = email!;
  final docUser = FirebaseFirestore.instance.collection("users").doc(email);
  var docExist = await docUser.get();
  if (!docExist.exists) {
    log("creating the user in firestore with email");
    log(email);
    log(User.email);
    log("************");
    await docUser.set(User.toJson());
  }

}

Future updateUserParticularInfo({required String key, required String value}) async {
  final docUser = FirebaseFirestore.instance.collection("users").doc(User.email);
  await docUser.update({key : value});
}
