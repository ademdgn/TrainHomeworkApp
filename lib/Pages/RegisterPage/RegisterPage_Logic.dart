import 'package:trackinghwapp/Storage_Service/googleCalender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/UserModel.dart';
import '../../Storage_Service/Firebase_Auth.dart';
import '../../main.dart';

class Register {
  Register();

  Auth auth = Auth();

  Future signUp(
      BuildContext context, Person person, GlobalKey<FormState> formKey) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    await auth.register(person);

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  registerGoogle() async {
    await auth.singInWithGoogle();
  }
}
