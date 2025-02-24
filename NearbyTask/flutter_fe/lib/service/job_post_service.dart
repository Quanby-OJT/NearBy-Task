import 'dart:convert';
import 'package:http/http.dart' as http;

class JobPostService {
  Future<bool> postJob(Map<String, dynamic> jobData) async {
    final url = Uri.parse("http://localhost:5000/connect/addTask");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(jobData),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print("Error: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}
