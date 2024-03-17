import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import '../Const/Fonts.dart';

class Start extends StatefulWidget {
  final VoidCallback onClickedGetStarted;

  const Start({Key? key, required this.onClickedGetStarted}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}





class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/welcome_image.jpg'),
              ),
              SizedBox(height: 20),
              const Text(
                'Welcome Homework Tracking App!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(left: 170),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey
                          .withOpacity(0.1), // Gölge rengi ve opaklığı
                      spreadRadius: 2, // Gölgenin yayılma miktarı
                      blurRadius: 5, // Gölgenin bulanıklık miktarı
                      offset: const Offset(
                          0, 3), // Gölgenin x ve y yönündeki ofseti
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedGetStarted,
                          text: "Skip",
                          style: const TextStyle(
                            color: Color(0xfff4C9040),
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward),
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
