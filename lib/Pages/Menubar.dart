import 'package:trackinghwapp/Pages/HomePage/HomePage.dart';
import 'package:trackinghwapp/Pages/HwPage/HwSends.dart';
import 'package:trackinghwapp/Pages/UserPage/UserPage.dart';
import 'package:trackinghwapp/Storage_Service/Firebase_Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'HwPage/HwAddPage.dart';
import 'HwPage/SendsAllHomework.dart';

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  Storage storage = Storage();
  int selectIndex = 0;
  late List<Widget> _widgetOptions;
  bool? showHomePage; // Change the type to bool?

  _Menu() {
    _initializeWidgetOptions();
  }

  Future<void> _initializeWidgetOptions() async {
    Map<String, dynamic> person = await storage.getPerson();
    showHomePage = shouldShowHomePage(person['userRoll']);

    setState(() {
      _widgetOptions = [
        showHomePage == true ? HomePage() : HwAddPage(),
        showHomePage == true ? HwSends() : SendsAllHomework(),
        UserPage(),
      ];
    });
  }

  bool shouldShowHomePage(userRoll) {
    return userRoll == 'Student';
  }

  @override
  Widget build(BuildContext context) {
    if (showHomePage == null) {
      // Handle the case where showHomePage is not yet initialized.
      return const Center(
          child:
              CircularProgressIndicator()); // or some other loading indicator
    }

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: GNav(
          gap: 4,
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.black,
          tabBackgroundColor: Colors.white70,
          padding: EdgeInsets.all(20),
          tabs: [
            showHomePage == true
                ? const GButton(icon: Icons.home, text: "")
                : const GButton(icon: Icons.add, text: ""),
            showHomePage == true
                ? const GButton(icon: Icons.history_outlined, text: "")
                : const GButton(icon: Icons.download, text: ""),
            const GButton(icon: Icons.person, text: ""),
          ],
          selectedIndex: selectIndex,
          onTabChange: (index) {
            setState(() {
              selectIndex = index;
            });
          },
        ),
      ),
      body: _widgetOptions.elementAt(selectIndex),
    );
  }
}
