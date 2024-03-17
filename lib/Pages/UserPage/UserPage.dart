import 'package:trackinghwapp/Pages/UserPage/UserInformationChange.dart';
import 'package:trackinghwapp/Pages/UserPage/UserPage_Logic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserProfile userProfile = UserProfile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: Container(
          width: 40,
          height: 40,
          child: Image.asset(
            'assets/profil.jpg',
            width: 30,
            height: 30,
          ),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
          future: userProfile.getPerson(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.data != null && snapshot.data!.containsKey('name')) {
                Map<String, dynamic> data = snapshot.data!;
                var username = data['name'];
                return UserEditWidget(
                  data: data,
                );
              } else {
                return const Text('Name not found in the data');
              }
            }
          },
        ),
      ),
    );
  }
}

class UserEditWidget extends StatefulWidget {
  const UserEditWidget({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  State<UserEditWidget> createState() => _UserEditWidgetState();
}

class _UserEditWidgetState extends State<UserEditWidget> {
  UserProfile userProfile = UserProfile();
  UserEdit userEdit = UserEdit();
  String? photoURL;

  Future<void> uploadPhoto() async {
    if (FirebaseAuth.instance.currentUser != null) {
      String? url = await userProfile.userProfilePhoto();
      if (url != null) {
        setState(() {
          photoURL = url;
        });
      } else {}
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Column(
                    children: [
                      if (widget.data["photoUrl"]?.isNotEmpty == true)
                        Image.network(widget.data["photoUrl"]),
                      if (widget.data["photoUrl"]?.isEmpty == true)
                        Image.asset("assets/profil.jpg"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(widget.data["name"],
              style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: uploadPhoto,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  side: BorderSide.none,
                  shape: const StadiumBorder()),
              child: const Text("Change Profil Photo",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 10),
          ProfileMenuWidget(
              title: widget.data["name"],
              icon: Icons.change_circle_outlined,
              onPress: () {
                userEdit.showDetails(context, widget.data, "Name", "name");
              }),
          const Divider(),
          ProfileMenuWidget(
              title: widget.data["email"],
              icon: Icons.email,
              onPress: () {
                userEdit.showChangeEmail(
                    context, widget.data, "Email ", "email");
              }),
          const Divider(),
          ProfileMenuWidget(
              title: "Password",
              icon: Icons.password_outlined,
              onPress: () {
                userEdit.showChangePassword(
                    context, widget.data, "Password ", "password");
              }),
          const Divider(),
          const SizedBox(height: 10),
          ProfileMenuWidget(
              title: "Logout",
              icon: Icons.logout,
              textColor: Colors.red,
              endIcon: false,
              onPress: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Are you sure"),
                        content: const Text("Are you sure logout?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(); // İletişim kutusunu kapat
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              userProfile.logout();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      );
                    });
              }),
        ],
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white70,
        ),
        child: Icon(icon, color: Colors.black),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(Icons.edit, size: 18.0, color: Colors.grey))
          : null,
    );
  }
}
