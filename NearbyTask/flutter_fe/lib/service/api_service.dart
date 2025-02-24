// service/api_service.dart
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/user_model.dart';

class ApiService {
  static const String apiUrl =
      "http://localhost:5000/connect"; // Adjust if needed

  static Future<bool> registerUser(UserModel user) async {
    //Tell Which Route the Backend we going to Use
    var request = http.MultipartRequest("POST", Uri.parse("$apiUrl/add"));

    // Add text fields
    request.fields["first_name"] = user.firstName;
    request.fields["last_name"] = user.lastName;
    request.fields["email"] = user.email;
    request.fields["password"] = user.password;

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
}
