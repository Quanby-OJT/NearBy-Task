import 'package:flutter/material.dart';
import 'package:flutter_fe/view/sign_in/sign_in.dart';
import 'package:flutter_fe/view/sign_up_acc/sign_up_client.dart';
import 'package:flutter_fe/view/sign_up_acc/sign_up_tasker.dart';
import 'package:google_fonts/google_fonts.dart';

class PreSignUp extends StatefulWidget {
  const PreSignUp({super.key});

  @override
  State<PreSignUp> createState() => _PreSignUpState();
}

class _PreSignUpState extends State<PreSignUp> {
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
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'Be PAID for Tasks Done through a TASKER ACCOUNT or Find an expert to have your task completed with a CLIENT ACCOUNT. \n\n To Begin, please select one of the two accounts you want to create:',
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 170,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 60),
              margin: EdgeInsets.only(bottom: 10, top: 40),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUpTaskerAcc(role: "Tasker");
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0272B1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icons8-worker-100.png', // Replace with your actual logo path
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(height: 20), // Spacing between logo and text
                    Text(
                      'TASKER ACCOUNT',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter'
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: 170,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 60),
              margin: EdgeInsets.only(bottom: 100),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUpClientAcc(role: "Client");
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0272B1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icons8-checklist-100.png',
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'CLIENT ACCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter'
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
