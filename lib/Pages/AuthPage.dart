import 'package:trackinghwapp/Pages/RegisterPage/RegisterPage.dart';
import 'package:flutter/cupertino.dart';
import 'LoginPage/LoginPage.dart';
import 'StartPage/StartPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  bool isStartPage = false;

  @override
  Widget build(BuildContext context) {
    if (isStartPage) {
      return Start(
        onClickedGetStarted: toggleStartPage,
      );
    } else {
      return isLogin
          ? LoginPage(
              onClickedSignUp: toggle,
            )
          : RegisterPage(
              onClickedSignIn: toggle,
            );
    }
  }

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void toggleStartPage() {
    setState(() {
      isStartPage = false;
    });
  }
}
