import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:trackinghwapp/Pages/HwPage/HwCard.dart';
import 'package:trackinghwapp/Pages/HwPage/Hw_logic.dart';

import '../Const/Fonts.dart';

class HwSends extends StatefulWidget {
  HwSends({super.key});

  @override
  State<HwSends> createState() => _HwSends();
}

class _HwSends extends State<HwSends> {
  final HwController hwController = HwController();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        width: double.infinity,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(42 * fem),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    EdgeInsets.fromLTRB(1 * fem, 30 * fem, 3 * fem, 1 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SendsPageTitle(
                        fem: fem, ffem: ffem, name: 'Sends Homework'),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<List<Map<String, dynamic>>>(
                        stream: hwController.historyHomeworkStream(),
                        builder: (BuildContext context,
                            AsyncSnapshot asyncSnapshot) {
                          if (asyncSnapshot.data != null) {
                            List<Map<String, dynamic>> hwlist =
                                asyncSnapshot.data;
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: hwlist.length,
                                itemBuilder: (context, index) {
                                  return HwCardWidget(
                                      hwlist, index, Colors.grey);
                                });
                          } else if (asyncSnapshot.hasError) {
                            return Text(
                              "An error occurred: ${asyncSnapshot.error}",
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SendsPageTitle extends StatefulWidget {
  const SendsPageTitle({
    super.key,
    required this.fem,
    required this.ffem,
    required this.name,
  });

  final double fem;
  final double ffem;
  final String name;

  @override
  State<SendsPageTitle> createState() => _SendsPageTitle();
}

class _SendsPageTitle extends State<SendsPageTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white38),
      margin: EdgeInsets.fromLTRB(
          20 * widget.fem, 20 * widget.fem, 20 * widget.fem, 5 * widget.fem),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 55 * widget.fem,
            height: 55 * widget.fem,
            child: Image.asset(
              'assets/send.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: RichText(
              text: TextSpan(
                style: SafeGoogleFont(
                  'Ubuntu',
                  fontSize: 15 * widget.ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.1490000407 * widget.ffem / widget.fem,
                  color: const Color(0xff000000),
                ),
                children: [
                  TextSpan(
                    text: widget.name,
                    style: SafeGoogleFont(
                      'Nunito',
                      fontSize: 30 * widget.ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.3625 * widget.ffem / widget.fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
