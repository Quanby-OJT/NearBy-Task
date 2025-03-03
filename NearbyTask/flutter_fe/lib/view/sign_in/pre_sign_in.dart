import 'package:flutter/material.dart';
import 'package:flutter_fe/view/sign_in/sign_in.dart';
import 'package:flutter_fe/view/sign_in/sign_up.dart';
import 'package:flutter_fe/view/sign_in_business_acc/sign_in_business_acc.dart';
import 'package:flutter_fe/view/sign_in_business_acc/sign_up_business_acc.dart';
import 'package:google_fonts/google_fonts.dart';

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
              child: Text(
                'NearByTask',
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'Select the type of account you want to create, provide service with a service account or hire an expert to complete a task with a business account.',
                style: GoogleFonts.openSans(color: Colors.white),
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
                      return SignUp();
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
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignUpBusinessAcc();
                    }));
                  },
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
