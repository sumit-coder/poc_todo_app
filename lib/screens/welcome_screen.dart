// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homeScreen.dart';
import 'video_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Text(
                      'POC',
                      style: TextStyle(
                        fontSize: 57,
                        color: Color.fromARGB(255, 153, 209, 255),
                        // height: 68,
                      ),
                    ),
                    Text(
                      'Flutter Technology Demo',
                      style: TextStyle(
                        fontSize: 14,
                        height: 0.4,
                        letterSpacing: 0.25,
                        color: Color.fromARGB(255, 153, 209, 255),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 100),
                child: Column(
                  children: [
                    SimpleButton(
                      title: 'Todo Section',
                      iconData: Icons.circle,
                      onTapFunctin: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                    ),
                    SimpleButton(
                      title: 'Video Section',
                      iconData: Icons.circle,
                      onTapFunctin: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    Key? key,
    required this.title,
    required this.iconData,
    required this.onTapFunctin,
  }) : super(key: key);

  final String title;
  final IconData iconData;
  final VoidCallback onTapFunctin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 56,
      width: 280,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          primary: Color.fromARGB(255, 191, 226, 255),
        ),
        onPressed: () {
          onTapFunctin();
        },
        // onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                height: 0.4,
                letterSpacing: 0.1,
                color: Color.fromARGB(255, 69, 76, 79),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
