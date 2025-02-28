// In JobPostService
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_fe/model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobPostService {
  Future<Map<String, dynamic>> postJob(TaskModel task) async {
    final url = Uri.parse("http://192.168.110.145:5000/connect/addTask");

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

  Future<List<TaskModel>> fetchAllJobs() async {
    final response = await http
        .get(Uri.parse('http://192.168.110.145:5000/connect/displayTask'));

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

  Future<Map<String, dynamic>> saveLikedJob(int jobId) async {
    try {
      final url = Uri.parse('http://192.168.110.145:5000/connect/likeJob');
      String? userId = await getUserId();

      if (userId == null || userId.isEmpty) {
        return {'success': false, 'message': 'User not logged in'};
      }

      debugPrint("Sending like request with userId: $userId, jobId: $jobId");

      // Updated request body with exact field names
      final requestBody = {
        'user_id': int.parse(userId), // Changed from user_id
        'job_post_id': jobId, // Changed from task_id
        //'status': 1, // Changed from liked:true to status:1
        'created_at':
            DateTime.now().toIso8601String(), // Changed from created_at
      };

      debugPrint("Request body: ${jsonEncode(requestBody)}");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(requestBody),
      );

      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        return {
          'success': true,
          'message': responseBody['message'] ?? 'Job liked successfully'
        };
      } else {
        var responseBody = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Failed to like job'
        };
      }
    } catch (e) {
      debugPrint("Exception in saveLikedJob: $e");
      return {'success': false, 'message': 'Error occurred: $e'};
    }
  }

  // Get user ID from SharedPreferences
  Future<String?> getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');
      debugPrint("Current user ID from prefs: $userId");
      return userId;
    } catch (e) {
      debugPrint("Error getting user ID: $e");
      return null;
    }
  }

  // Get auth token from SharedPreferences if needed
  Future<String?> getAuthToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('authToken');
    } catch (e) {
      debugPrint("Error getting auth token: $e");
      return null;
    }
  }

  // Method to fetch liked jobs for a user
  Future<List<TaskModel>> fetchUserLikedJobs() async {
    try {
      final url = Uri.parse("http://192.168.110.145:5000/connect/likeJob");
      String? userId = await getUserId();

      if (userId == null || userId.isEmpty) {
        return [];
      }

      final response = await http.get(
        Uri.parse('$url/$userId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('likedJobs')) {
          final List<dynamic> jobList = jsonData['likedJobs'];
          return jobList.map((job) => TaskModel.fromJson(job)).toList();
        } else {
          debugPrint("Error: 'likedJobs' key not found in response");
        }
      } else {
        debugPrint("Error fetching liked jobs: ${response.statusCode}");
      }

      return [];
    } catch (e) {
      debugPrint("Exception in fetchUserLikedJobs: $e");
      return [];
    }
  }
}
