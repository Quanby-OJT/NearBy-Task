import 'package:flutter/material.dart';
import 'package:flutter_fe/service/api_service.dart';
import 'package:flutter_fe/view/sign_in/otp_screen.dart';
import 'package:flutter_fe/view/service_acc/service_acc_main_page.dart';

class AuthenticationController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  int userId;

  AuthenticationController({this.userId = 0});

  Future<void> loginAuth(BuildContext context) async {
    var response = await ApiService.authUser(
        emailController.text, passwordController.text);

    if (response.containsKey('user_id')) {
      int userId = response['user_id'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(userId: userId),
        ),
      );
    } else if (response.containsKey('validation_error')) {
      String errorMessage =
          response['validation_error'] ?? "Unknown error occurred";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } else {
      // Display the error message using SnackBar
      String errorMessage = response['error'] ?? "Unknown error occurred";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future<void> resetOTP(BuildContext context) async {
    var response = await ApiService.regenerateOTP(userId);

    if (response.containsKey('message')) {
      String messageReset = response['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(messageReset)),
      );
    } else {
      String errorMessage = response['error'] ?? "Unknown error occurred";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future<void> otpAuth(BuildContext context) async {
    var response = await ApiService.authOTP(userId, otpController.text);

    if (response.containsKey('user_id')) {
      //Code for redirection to OTP Page
      userId = response['user_id'];
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ServiceAccMain();
      }));
    } else if (response.containsKey('validation_error')) {
      String error =
          response['validation_error'] ?? "OTP Authentication Failed.";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    } else {
      String error = response['error'] ?? "OTP Authentication Failed.";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }
}
