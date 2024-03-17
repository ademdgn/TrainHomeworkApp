import 'package:trackinghwapp/Pages/ForgotPasswordPage/ForgotPassword_Logic.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../Const/Fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  ForgotPasswordController forgotPasswordController =
      ForgotPasswordController();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          // logoRUR (18:291)
          margin: EdgeInsets.fromLTRB(25 * fem, 20 * fem, 26 * fem, 55 * fem),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                // logoXGZ (18:293)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 45 * fem, 0 * fem, 0 * fem),
                width: 40 * fem,
                height: 40 * fem,
                child: Image.asset(
                  'assets/5027360.png',
                  width: 63 * fem,
                  height: 63 * fem,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                // billinvoiceSuK (18:292)
                'Billinvoice',
                style: SafeGoogleFont(
                  'Ubuntu',
                  fontSize: 40 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.15 * ffem / fem,
                  color: Color(0xff000000),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.white70,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: "Email"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? " Enter a valid Email "
                        : null,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(Icons.email_outlined),
                  label: const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 24),
                  ), // Text
                  onPressed: () {
                    forgotPasswordController.resetPassword(
                        context, _emailController.text);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
