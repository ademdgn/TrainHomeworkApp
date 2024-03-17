import 'package:trackinghwapp/Storage_Service/Firebase_Storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Model/UserModel.dart';
import '../Pages/Const/Utils.dart';
import '../main.dart';

class Auth {
  Storage storage = Storage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  register(Person person) async {
    try {
      var authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: person.email.trim(),
        password: person.password.trim(),
      );
      await storage.addUser(person, authResult);
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }

  singInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      final String? email = user.email;
      final String? displayName = user.displayName;

      Person person = Person(name: displayName!, email: email!, password: " ",userRoll: "student");

      storage.addUser(person, userCredential);
    } else {
      Utils.showSnackBar("Kullanıcı Girişinde Hata");
    }
  }

  currentUser() {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      return uid;
    } else {
      return null;
    }
  }

  signOut() async {
    return await _auth.signOut();
  }

  void changeEmail(String newEmail, String password) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String? currentEmail = user.email;

      if (currentEmail != null) {
        AuthCredential credential = EmailAuthProvider.credential(
            email: currentEmail, password: password);
        await user.reauthenticateWithCredential(credential);

        await user.updateEmail(newEmail);
      } else {
        // Kullanıcının e-posta adresi mevcut değilse, uygun hata işlemlerini yapabilirsiniz.
      }
    } else {
      // Kullanıcı oturum açmamışsa, uygun hata işlemlerini yapabilirsiniz.
    }
  }

  void changePassword(String newPassword) async {
    await currentUser().updatePassword(newPassword);
  }

  void SendPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      Utils.showSnackBar("Password reset Email Sent");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
