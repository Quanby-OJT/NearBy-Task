// In JobPostService
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_fe/model/task_model.dart';

class JobPostService {
  Future<Map<String, dynamic>> postJob(TaskModel task) async {
    final url = Uri.parse("http://localhost:5000/connect/addTask");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(task.toJson()),
      );

      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {
          'success': true,
          'message':
              responseBody['message'] ?? 'Unable  to Read Backend Response'
        };
      } else {
        return {
          'success': false,
          'message':
              responseBody['message'] ?? 'Unable  to Read Backend Response'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error Occured : $e'};
    }
  }
}
