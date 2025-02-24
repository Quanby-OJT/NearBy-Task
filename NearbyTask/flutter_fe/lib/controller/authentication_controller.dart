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

  Future<void> loginAuth(BuildContext context) async{
    int? user_id = await ApiService.authUser(emailController.text, passwordController.text);

    if(user_id != null){
      //Code for redirection to OTP Page
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return OtpScreen(userId: user_id);
      }));
    }else{
      SnackBar(content: Text("Sorry. Your Password is Incorrect. Please Try Again."));
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
      SnackBar(content: Text("Your OTP is incorrect. Please check your email."));
    }
  }
}