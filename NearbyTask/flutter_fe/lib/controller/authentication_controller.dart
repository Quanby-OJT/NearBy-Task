import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fe/service/api_service.dart';

class AuthenticationController{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginAuth(BuildContext context) async{
    bool success = await ApiService.authUser(emailController.text, passwordController.text);

    if(success){
      //Code for redirection to OTP Page
    }else{
      SnackBar(content: Text("Sorry. Your Password is Incorrect. Please Try Again."));
    }
  }
}