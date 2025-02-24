// service/api_service.dart
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/user_model.dart';

class ApiService {
  static const String apiUrl =
      "http://192.168.56.1:5000/connect"; // Adjust if needed

  static Future<bool> registerUser(UserModel user) async {
    //Tell Which Route the Backend we going to Use
    var request = http.MultipartRequest("POST", Uri.parse("$apiUrl/add"));

    // Add text fields
    request.fields["first_name"] = user.firstName;
    request.fields["last_name"] = user.lastName;
    request.fields["email"] = user.email;
    request.fields["password"] = user.password;

    // Attach Image (if available)~
    // if (user.image != null && user.imageName != null) {
    //   request.files.add(
    //     http.MultipartFile.fromBytes(
    //       'image',
    //       user.image!,
    //       filename: user.imageName!,
    //     ),
    //   );
    // }
    if (user.image != null && user.imageName != null) {
      final bytes = await File(user.image!.path).readAsBytes();
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          bytes,
          filename: user.imageName!,
        ),
      );
    }

    var response = await request.send();
    return response.statusCode == 201;
  }

  static Future<List<UserModel>> fetchAllUsers() async {
    //Tell Which Route the Backend we going to Use
    final response = await http.get(Uri.parse("$apiUrl/display"));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['users'];
      return data.map((userData) => UserModel.fromJson(userData)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<Map<String, dynamic>> authUser(String email, String password) async {
    try{
      var response = await http.post(
        Uri.parse("$apiUrl/login-auth"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      var data = json.decode(response.body);

      if(response.statusCode == 200){
        return {"user_id": data['user_id']};
      }else{
        return {"error": data['error'] ?? 'Authentication Failed'};
      }
    }catch(e){
      print('Error: $e');
      return {"error": "An error occured: $e"};
    }
  }

  static Future<bool> authOTP(int userId, String otp) async{
    final response = await http.post(
      Uri.parse("$apiUrl/verify-otp"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "user_id": userId,
        "otp": otp,
      }),
    );

    if(response.statusCode == 200) {
      var data = json.decode(response.body);

      return true;
    }else{
      var error = json.decode(response.body);
      print("Otp Verification Failed: ${error['error']}");
      return false;
    }
  }
}
