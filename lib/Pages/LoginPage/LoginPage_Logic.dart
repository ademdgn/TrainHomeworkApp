import 'package:trackinghwapp/Storage_Service/Firebase_Auth.dart';
import 'package:trackinghwapp/Storage_Service/googleCalender.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class LoginController {
  Auth auth = Auth();

  Future Log_In(String email, String password, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    await auth.signIn(email, password);

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future googleSignIn() async {
    await auth.singInWithGoogle();
  }
}
