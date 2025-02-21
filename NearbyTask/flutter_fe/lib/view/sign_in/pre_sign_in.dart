import 'package:flutter/material.dart';
import 'package:flutter_fe/view/sign_in/sign_in.dart';

class PreSignIn extends StatefulWidget {
  const PreSignIn({super.key});

  @override
  State<PreSignIn> createState() => _PreSignInState();
}

class _PreSignInState extends State<PreSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0272B1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 90),
              child: const Text(
                'NearByTask',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'By tapping Create Account or Sign In, you agree to our Terms. Learn how we process your data in our Privacy Policy and Cookies Policy.',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 50),
              margin: EdgeInsets.only(bottom: 10, top: 40),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignIn();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0272B1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Colors.white))),
                  child: Text(
                    'SERVICE ACCOUNT',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 60),
              margin: EdgeInsets.only(bottom: 100),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0272B1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Colors.white))),
                  child: Text(
                    'BUSINESS ACCOUNT',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
