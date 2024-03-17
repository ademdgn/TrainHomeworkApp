import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:trackinghwapp/Model/UserModel.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../Const/Fonts.dart';
import 'RegisterPage_Logic.dart';

class RegisterPage extends StatefulWidget {
  final Function() onClickedSignIn;
  const RegisterPage({Key? key, required this.onClickedSignIn})
      : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController userRoll = TextEditingController();
  Register register = Register();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  final List<String> items = [
    'Student',
    'Teacher',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
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
                margin:
                    EdgeInsets.fromLTRB(1 * fem, 20 * fem, 0 * fem, 52 * fem),
                child: Text(
                  'Sign Up',
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
                controller: nameController,
                cursorColor: Colors.white70,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Name and Surname"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white70,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Email"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? "Email a valid email"
                        : null,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                cursorColor: Colors.white70,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Password"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 8
                    ? " Enter min. 8 characters "
                    : null,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Select User Role',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: items
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                      userRoll.text = value ?? '';
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: double.infinity, // Set width to full width
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.white,
                      ),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.black,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      offset: const Offset(0, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                onPressed: () => register.signUp(
                    context,
                    Person(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        userRoll: userRoll.text),
                    formKey),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                icon: const Icon(
                  Icons.lock_open,
                  size: 32,
                ),
                label: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 24),
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
                        text: 'Already have an account?',
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
                          ..onTap = widget.onClickedSignIn,
                        text: "Sıgn In",
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
                  register.registerGoogle();
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
                          'Sign up with Google',
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
      ),
    );
  }
}
