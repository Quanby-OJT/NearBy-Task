// In JobPostService
import 'dart:convert';
import 'package:flutter_fe/model/specialization.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_fe/model/task_model.dart';

class JobPostService {
  final String url = "http://10.0.2.2:5000/connect";
  
  Future<List<SpecializationModel>> getSpecializations() async {
    try{
      final response =
          await http.get(Uri.parse('$url/get-all-specializations'));
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data.containsKey('tasks')) {
          final List<dynamic> specList = data['tasks'];
          print(specList);
          return specList
              .map((specList) => SpecializationModel.fromJson(specList))
              .toList();
        } else {
          throw Exception("An Error Occurred while retrieving specializations.");
        }
      } else {
        throw Exception(
            "Error: API request failed with status ${response.statusCode}");
      }
    }catch(e){
      throw Exception("Error: $e");
    }
  }

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
      } else if(response.statusCode == 401){
        return{
          'success': false,
          'message': responseBody['errors'] ?? 'Please Check your inputs and try again.'
        };
      }else{
        return {
          'success': false,
          'message':
              responseBody['error'] ?? 'Something Went Wrong while Posting Your Task.'
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
    try {
      final response = await http.get(Uri.parse('$url/displayTask'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('tasks')) {
          final List<dynamic> taskList = jsonData['tasks']; // Extract tasks array
          return taskList.map((task) => TaskModel.fromJson(task)).toList();
        } else {
          throw Exception("Error: 'tasks' key not found in response");
        }
      } else {
        throw Exception("Error: API request failed with status ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error fetching jobs: $error");
    }
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
