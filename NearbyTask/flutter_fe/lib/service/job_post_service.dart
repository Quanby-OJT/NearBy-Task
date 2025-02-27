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

  // Future<List<TaskModel>> fetchAllJobs() async {
  //   final url = Uri.parse("http://localhost:5000/connect/displayTask");

  //   try {
  //     final response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       List<dynamic> body = jsonDecode(response.body);
  //       return body.map((dynamic item) => TaskModel.fromJson(item)).toList();
  //     } else {
  //       debugPrint("Error: ${response.body}");
  //       return [];
  //     }
  //   } catch (e) {
  //     debugPrint("Exception: $e");
  //     return [];
  //   }
  // }
  Future<List<TaskModel>> fetchAllJobs() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/connect/displayTask'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (jsonData.containsKey('tasks')) {
        final List<dynamic> taskList = jsonData['tasks']; // Extract tasks array
        return taskList.map((task) => TaskModel.fromJson(task)).toList();
      } else {
        print("Error: 'tasks' key not found in response");
      }
    } else {
      print("Error: API request failed with status ${response.statusCode}");
    }

    return [];
  }
}
