// In JobPostService
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_fe/model/task_model.dart';

class JobPostService {
  final String url = "http://10.0.2.2:5000/connect";

  Future<Map<String, dynamic>> postJob(TaskModel task, int userId) async {
    try {
      final Map<String, dynamic> taskInfo = task.toJson();
      taskInfo['user_id'] = userId;

      final response = await http.post(
        Uri.parse("$url/addTask"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(taskInfo),
      );

      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {
          'success': true,
          'message':
              responseBody['message'] ?? 'Successfully Posted Your Task. Please Wait for Your Tasker to Accept the Job.'
        };
      } else {
        return {
          'success': false,
          'message':
              responseBody['message'] ?? 'Something Went Wrong while Posting Your Task.'
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
        await http.get(Uri.parse('$url/displayTask'));

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

  Future<List<TaskModel>> fetchJobToAuthenticatedClient(int userId) async{
    final response = await http.get(Uri.parse('$url/displayTask/$userId'));

    if(response.statusCode == 200){
      final Map<String, dynamic> data = json.decode(response.body);

      if(data.containsKey('tasks')){
        final List<dynamic> tasks = data['tasks'];
        return tasks.map((task) => TaskModel.fromJson(task)).toList();
      }else{
        print("Error: " + data['error']);
      }
    }else{
      print("Error: API Request failed with status ${response.statusCode}");
    }

    return [];
  }
}
