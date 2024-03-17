import 'package:trackinghwapp/Pages/LoginPage/LoginPage_Logic.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../Const/Fonts.dart';
import '../ForgotPasswordPage/ForgotPasswordPage.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginPage({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginController loginController = LoginController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              // logoRUR (18:291)
              margin:
                  EdgeInsets.fromLTRB(25 * fem, 30 * fem, 26 * fem, 55 * fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    // logoXGZ (18:293)
                    margin: EdgeInsets.fromLTRB(
                        15 * fem, 0 * fem, 17 * fem, 0 * fem),
                    width: 63 * fem,
                    height: 63 * fem,
                    child: Image.asset(
                      'assets/5027360.png',
                      width: 63 * fem,
                      height: 63 * fem,
                    ),
                  ),
                  Text(
                    // billinvoiceSuK (18:292)
                    'HwTrack',
                    style: SafeGoogleFont(
                      'Ubuntu',
                      fontSize: 50 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.15 * ffem / fem,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // signupzR3 (18:298)
              margin: EdgeInsets.fromLTRB(1 * fem, 20 * fem, 0 * fem, 52 * fem),
              child: Text(
                'Sign In',
                style: SafeGoogleFont(
                  'Ubuntu',
                  fontSize: 37 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.15 * ffem / fem,
                  color: Colors.black54,
                ),
              ),
            ),
            TextFormField(
              controller: _emailController,
              cursorColor: Colors.white70,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: "Email"),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? "Email a valid email"
                      : null,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              cursorColor: Colors.white70,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: "Password"),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value != null && value.length < 8
                  ? " Enter min. 8 characters "
                  : null,
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton.icon(
              onPressed: () {
                loginController.Log_In(
                    _emailController.text, _passwordController.text, context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: const Icon(
                Icons.lock_open,
                size: 32,
              ),
              label: const Text(
                "Sign in",
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              // alreadyhaveanaccount6eR (18:309)
              margin: EdgeInsets.fromLTRB(190 * fem, 0 * fem, 2 * fem, 0 * fem),

              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    style: SafeGoogleFont(
                      'Inter',
                      fontSize: 19 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.2102272636 * ffem / fem,
                      color: Color(0xff000000),
                    ),
                    children: const [
                      TextSpan(
                        text: "Forgot Password",
                        style: TextStyle(
                            color: Color(0xfff116A7B),
                            fontSize: 15,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              // alreadyhaveanaccount6eR (18:309)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2 * fem, 0 * fem),
              child: RichText(
                text: TextSpan(
                  style: SafeGoogleFont(
                    'Inter',
                    fontSize: 19 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.2102272636 * ffem / fem,
                    color: Color(0xff000000),
                  ),
                  children: [
                    TextSpan(
                      text: "Don't have an account",
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 19 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * ffem / fem,
                        color: Color(0xff242424),
                      ),
                    ),
                    TextSpan(
                      text: ' ',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 19 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * ffem / fem,
                        color: Color(0xff2f4859),
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: "Sign Up",
                      style: const TextStyle(
                          color: Color(0xfff4C9040),
                          fontSize: 17,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
              ),
              onPressed: () {
                loginController.googleSignIn();
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/Google__G__logo.svg.png"),
                      height: 25.0,
                      width: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 24, right: 8),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
