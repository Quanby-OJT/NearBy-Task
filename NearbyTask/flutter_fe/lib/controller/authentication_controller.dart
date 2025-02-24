import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fe/service/api_service.dart';
import 'package:flutter_fe/view/sign_in/otp_screen.dart';
import 'package:flutter_fe/view/service_acc/service_acc_main_page.dart';

class AuthenticationController{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final int userId = 0;

  Future<void> loginAuth(BuildContext context) async {
    var response = await ApiService.authUser(emailController.text, passwordController.text);

    if (response.containsKey('user_id')) {
      int userId = response['user_id'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(userId: userId),
        ),
      );
    } else {
      // Display the error message using SnackBar
      String errorMessage = response['error'] ?? "Unknown error occurred";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future<void> otpAuth(BuildContext context) async{
    bool success = await ApiService.authOTP(userId, otpController.text);

    if(success){
      //Code for redirection to OTP Page
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return ServiceAccMain();
      }));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sorry. Your OTP is Incorrect. Please check your email.")),
      );
    }
  }
}