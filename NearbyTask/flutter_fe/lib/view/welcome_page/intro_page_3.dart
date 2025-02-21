import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              textAlign: TextAlign.center,
              'Tesda graduate? Now you can look for available jobs and showcase your skills in your profile. Sign up using service account now!',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            ),
          ),
          Lottie.network(
              'https://lottie.host/77dc7069-71b7-48fd-be36-a6e3018429c9/Gu3IONNkvo.json',
              width: 300,
              height: 300,
              fit: BoxFit.contain),
        ],
      ),
    );
  }
}
