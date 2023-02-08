import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:talkhost/Utilities/debuggin_handler.dart';
import 'package:talkhost/Utilities/strings.dart';

class AuthState {
  static User? user;
  static String? userEmail;
  static String? userPassword;
  static String? userProfilePic;
  static String? userName;
  static String errorString = "Some Error has been occurred please try again";

  Future<bool> isUserSignedIn() async {

    if(authStateDebugging){
      log("Inside BLoCandLogic/Authentication/auth_state/isUserSignedIn");
    }

    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;

    if (user == null) return false;

    userEmail = user!.email;
    userProfilePic = user!.photoURL;
    userName = user!.displayName;

    return true;
  }

  Future<bool> isUserEmailVerified() async {
    if(authStateDebugging){
      log("Inside BLoCandLogic/Authentication/auth_state/isUserEmailVerified");
    }
    bool isUserLoggedIn = await isUserSignedIn();
    if (isUserLoggedIn) return user!.emailVerified;
    return false;
  }

  Future<bool> letUserSignedInWithGoogle() async {

    if(authStateDebugging){
      log("Inside BLoCandLogic/Authentication/auth_state/letUserSignedInWithGoogle");
    }
    await Firebase.initializeApp();
    final FirebaseAuth auth = FirebaseAuth.instance;
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
          await auth.signInWithPopup(authProvider);

      user = userCredential.user;
    } catch (e) {
      if (e.toString().contains(']')) {
        errorString = e.toString().split(']')[1].trim();
      } else {
        errorString = e.toString();
      }
      log(e.toString());
      return false;
    }

    if (user != null) {
      userEmail = user!.email!;
      userName = user!.displayName;
      userProfilePic = user!.photoURL!;
      log(user!.email.toString());
      log("User Signed in success");
    } else {
      return false;
    }

    return true;
  }

  Future<bool> letUserSignedInWithEmailAndPassword(
    String email,
    String passcode,
  ) async {
    try {

      if(authStateDebugging){
        log("Inside BLoCandLogic/Authentication/auth_state/letUserSignedInWithEmailAndPassword");
      }
      await Firebase.initializeApp();
      final FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential credit = await auth.signInWithEmailAndPassword(
        email: email,
        password: passcode,
      );
      user = credit.user;
    } catch (e) {
      if (e.toString().contains(']')) {
        errorString = e.toString().split(']')[1].trim();
      } else {
        errorString = e.toString();
      }
      log(e.toString());
      return false;
    }

    if (user != null) {
      userPassword = passcode;
      userEmail = user!.email!;
      userName = user!.displayName;
      userProfilePic = user!.photoURL!;

      log(user!.email.toString());
      log("User Signed in success");
    } else {
      return false;
    }

    return true;
  }

  Future<bool> createUserWithLoginAndPassword(String email, String passcode) async{
    try {

      if(authStateDebugging){
        log("Inside BLoCandLogic/Authentication/auth_state/createUserWithLoginAndPassword");
      }
      await Firebase.initializeApp();
      final FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential credit = await auth.createUserWithEmailAndPassword(
        email: email,
        password: passcode,
      );
      user = credit.user;
    } catch (e) {
      if (e.toString().contains(']')) {
        errorString = e.toString().split(']')[1].trim();
      } else {
        errorString = e.toString();
      }
      log(e.toString());
      return false;
    }

    if (user != null) {
      userPassword = passcode;
      userEmail = user!.email!;
      userName = user!.displayName;
      userProfilePic = user!.photoURL!;
      log(user!.email.toString());
      log("User Signed in success");
    } else {
      return false;
    }

    return true;
  }

  Future logout() async {

    if(authStateDebugging){
      log("Inside BLoCandLogic/Authentication/auth_state/logout");
    }
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    userEmail = userPassword = userProfilePic = userName = null;
    errorString = defaultErrorLine;
  }

  Future<bool> letUserAddingAPassword(String passcode) async {

    if(authStateDebugging){
      log("Inside BLoCandLogic/Authentication/auth_state/letUserAddingAPassword");
    }
    await Firebase.initializeApp();
    if (user == null) return false;
    try {
      final AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: passcode,
      );
      await user!.linkWithCredential(credential);
    } catch (e) {
      if (e.toString().contains(']')) {
        errorString = e.toString().split(']')[1].trim();
      } else {
        errorString = e.toString();
      }
      log(e.toString());
      return false;
    }

    userPassword = passcode;

    return true;
  }

  Future<bool> sendPasswordResetEmail(String email) async {

    if(authStateDebugging){
      log("Inside BLoCandLogic/Authentication/auth_state/sendPasswordResetEmail");
    }
    await Firebase.initializeApp();
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      if (e.toString().contains(']')) {
        errorString = e.toString().split(']')[1].trim();
      } else {
        errorString = e.toString();
      }
      log(e.toString());
      return false;
    }
    return true;
  }

}
