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

    //Attach Image (if available)~
    if (user.image != null && user.imageName != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          user.image!,
          filename: user.imageName!,
        ),
      );
    }
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

  static Future<UserModel?> fetchAuthenticatedUser(String userId) async {
    try {
      final response = await http.get(Uri.parse("$apiUrl/getUserData/$userId"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Check if the 'users' key exists and contains data
        if (data.containsKey('users') && data['users'] is List && data['users'].isNotEmpty) {
          return UserModel.fromJson(data['users'][0]); // Assuming first user is the authenticated user
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
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
      } else if (response.statusCode == 400 && data.containsKey('errors')) {
        // Extract validation errors and combine them into a single string
        List<dynamic> errors = data['errors'];
        String errorMessage = errors.map((e) => e['msg']).join('\n');
        return {"validation_error": errorMessage};
      }else{
        return {"error": data['error'] ?? 'Authentication Failed'};
      }
    }catch(e){
      print('Error: $e');
      return {"error": "An error occured: $e"};
    }
  }

  static Future<Map<String, dynamic>> regenerateOTP(int userId) async {
    try{
      final response = await http.post(
        Uri.parse("$apiUrl/reset"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "user_id": userId,
        }),
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {"message": data['message']};
      }else if (response.statusCode == 400 && data.containsKey('errors')) {
        // Handle validation errors from backend
        List<dynamic> errors = data['errors'];
        String validationMessage = errors.map((e) => e['message']).join("\n");
        return {"validation_error": validationMessage};
      }
      else {
        return {"error": data['error'] ?? "OTP Generation Failed"};
      }
    }catch(e){
      print('Error: $e');
      return {"error": "An error occured: $e"};
    }
  }

  static Future<Map<String, dynamic>> authOTP(int userId, String otp) async{
    try{
      final response = await http.post(
        Uri.parse("$apiUrl/otp-auth"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "user_id": userId,
          "otp": otp,
        }),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      var data = json.decode(response.body);
      print('Decoded Data Type: ${data.runtimeType}');

      if (response.statusCode == 200) {
        return {"user_id": data['user_id']};
      } else if (response.statusCode == 400 && data.containsKey('errors')) {
        List<dynamic> errors = data['errors'];
        String validationMessage = errors.map((e) => e['msg']).join("\n");
        print(validationMessage);
        return {"validation_error": validationMessage};
      } else {
        return {"error": data.containsKey('error') ? data['error'] : "OTP Authentication Failed"};
      }
    }catch(e){
      print('Error: $e');
      return {"error": "An error occured: $e"};
    }
  }

  static Future<Map<String, dynamic>> logout(int userId) async {
    try{
      final response = await http.post(
        Uri.parse("$apiUrl/logout"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "user_id": userId,
        }),
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {"message": data['message']};
      } else {
        return {"error": data.containsKey('error') ? data['error'] : "Error while Logging Out"};
      }
    }catch(e){
      print('Error: $e');
      return {"error": "An error occured: $e"};
    }
  }
}
