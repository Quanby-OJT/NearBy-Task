import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_fe/model/specialization.dart';
import 'package:flutter_fe/model/task_model.dart';
import 'package:flutter_fe/service/auth_service.dart'; // Ensure session token retrieval

class JobPostService {
  final String url = "http://10.0.2.2:5000/connect";

  // Method to get headers with Authorization token
  Future<Map<String, String>> getHeaders() async {
    String? token = await AuthService.getSessionToken(); // Retrieve token from storage

    if (token == null) {
      throw Exception("Session expired. Please log in again.");
    }

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
      "Access-Control-Allow-Credentials": "true",
    };
  }

  // Generalized HTTP Request Method
  Future<http.Response> makeRequest({
    required String endpoint,
    String method = 'GET',
    Map<String, dynamic>? body,
  }) async {
    try {
      final headers = await getHeaders();
      final uri = Uri.parse('$url/$endpoint');

      switch (method) {
        case 'POST':
          return await http.post(uri, headers: headers, body: jsonEncode(body));
        case 'PUT':
          return await http.put(uri, headers: headers, body: jsonEncode(body));
        case 'DELETE':
          return await http.delete(uri, headers: headers);
        default:
          return await http.get(uri, headers: headers);
      }
    } catch (e) {
      throw Exception("Network request error: $e");
    }
  }

  // Fetch specializations
  Future<List<SpecializationModel>> getSpecializations() async {
    print("Fetching SPecializations...");
    final response = await makeRequest(endpoint: "get-all-specializations");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('tasks')) {
        return (data['tasks'] as List)
            .map((spec) => SpecializationModel.fromJson(spec))
            .toList();
      }
    }
    throw Exception("Error retrieving specializations.");
  }

  // Post a new job
  Future<Map<String, dynamic>> postJob(TaskModel task, int userId) async {
    final response = await makeRequest(
      endpoint: "addTask",
      method: "POST",
      body: {...task.toJson(), 'user_id': userId},
    );


    final responseBody = jsonDecode(response.body);
    // print(response.statusCode);
    // print(responseBody);
    if (response.statusCode == 201) {
      return {'success': true, 'message': responseBody['message'] ?? 'Job posted successfully.'};
    } else if(response.statusCode == 400){
      return {'success': false, 'message': responseBody['errors']};
    }
    return {'success': false, 'message': responseBody['error'] ?? 'Job posting failed.'};
  }

  // Fetch all available jobs
  Future<List<TaskModel>> fetchAllJobs() async {
    final response = await makeRequest(endpoint: "displayTask");

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.containsKey('tasks')) {
        return (jsonData['tasks'] as List).map((task) => TaskModel.fromJson(task)).toList();
      }
    }
    throw Exception("Error retrieving jobs.");
  }

  // Fetch jobs specific to an authenticated client
  Future<List<TaskModel>> fetchJobToAuthenticatedClient(int userId) async {
    final response = await makeRequest(endpoint: "displayTask/$userId");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('tasks')) {
        return (data['tasks'] as List).map((task) => TaskModel.fromJson(task)).toList();
      }
    }
    throw Exception("Error fetching jobs for user.");
  }
}
