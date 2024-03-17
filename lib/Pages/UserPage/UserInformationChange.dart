import 'package:trackinghwapp/Pages/UserPage/UserPage_Logic.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserEdit {
  UserProfile userProfile = UserProfile();

  void showDetails(BuildContext context, Map<String, dynamic> data, String text,
      String key) {
    final TextEditingController _textController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data["name"]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: TextFormField(
                      // Bill Name
                      controller: _textController,
                      cursorColor: Colors.white70,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: "$text change"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value == null
                          ? "This field cannot be left blank"
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                editInfo(key, _textController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showChangeEmail(BuildContext context, Map<String, dynamic> data,
      String text, String key) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data["name"]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                validator: (value) => value != null && data["password"] != value
                    ? "please enter the correct password"
                    : null,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                changeEmail(
                    _emailController.text, _passwordController.text, context);
                editInfo("email", _emailController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showChangePassword(BuildContext context, Map<String, dynamic> data,
      String text, String key) {
    final TextEditingController _passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey =
        GlobalKey<FormState>(); // Form anahtarını ekledik

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data["name"]),
          content: Form(
            key:
                _formKey, // Form anahtarını atanmış bir form widget'ı kullandık
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _passwordController,
                  cursorColor: Colors.white70,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: "New Password"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field cannot be left blank";
                    }
                    // İsteğe bağlı olarak şifre karmaşıklığı veya diğer gereksinimleri burada doğrulayabilirsiniz.
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  changePassword(_passwordController.text);
                  editInfo("password", _passwordController.text);

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  editInfo(String key, String value) {
    Map<String, dynamic> updatedData = {"${key}": value};
    userProfile.uploadPerson(updatedData);
    userProfile.changePassword(value);
  }

  changePassword(String newPassword) {
    userProfile.changePassword(newPassword);
  }

  changeEmail(String newEmail, String password, BuildContext context) {
    userProfile.changeEmail(newEmail, password, context);
  }
}
