import 'dart:io';

import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../service/api_service.dart';

class ProfileController {
  // Fetched user inputs Start
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  File? imageData; // Store image bytes
  String? imageName; // Store image name
  // Fetched user inputs End

  // Byte for the image start
  void setImage(File image, String name) {
    imageData = image;
    imageName = name;
  }
  // Byte for the image end

// Validation if password not matched start
  Future<void> registerUser(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match!")),
      );
      return;
    }
// Validation if password not matched end

// Store the inputs Start
    UserModel user = UserModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
      image: imageData,
      imageName: imageName,
    );
      bool success = await ApiService.registerUser(user);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration Successful!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration Failed!")),
        );
      }
  }

  Future<UserModel?> getAuthenticatedUser(BuildContext context, String userId) async {
    try {
      UserModel? user = await ApiService.fetchAuthenticatedUser(userId);
      if (user != null) {
        return user;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to retrieve user data!")),
        );
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return null;
    }
  }
}
