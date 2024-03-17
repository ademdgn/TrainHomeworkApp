import 'package:flutter/material.dart';
import '../../Storage_Service/Firebase_Auth.dart';

class ForgotPasswordController {
  Auth auth = Auth();

  Future resetPassword(BuildContext context, String email) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    auth.SendPassword(email, context);
  }
}
