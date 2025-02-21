import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              textAlign: TextAlign.center,
              'Welcome to NearByTask',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            ),
          ),
          Lottie.network(
              'https://lottie.host/fbaccb57-c24c-4660-8b4b-a1c534089f98/SgTD5M64sa.json',
              width: 300,
              height: 300,
              fit: BoxFit.fitWidth),
        ],
      ),
    );
  }
}
