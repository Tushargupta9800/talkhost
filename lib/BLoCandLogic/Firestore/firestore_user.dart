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

Future updateUserProfilePic({required String fileLink}) async {
  final docUser = FirebaseFirestore.instance.collection("users").doc(User.email);
  await docUser.update({"profile_pic" : fileLink});
}

Future updateUserName({required String name}) async {
  final docUser = FirebaseFirestore.instance.collection("users").doc(User.email);
  await docUser.update({"name" : name});
}

Future updateUserPhoneNumber({required String number}) async {
  final docUser = FirebaseFirestore.instance.collection("users").doc(User.email);
  await docUser.update({"phone_number" : number});
}

Future updateUserAddress({required String address}) async {
  final docUser = FirebaseFirestore.instance.collection("users").doc(User.email);
  await docUser.update({"address" : address});
}

Future updateUserBannerPic({required String fileLink}) async {
  final docUser = FirebaseFirestore.instance.collection("users").doc(User.email);
  await docUser.update({"banner_pic" : fileLink});
}
