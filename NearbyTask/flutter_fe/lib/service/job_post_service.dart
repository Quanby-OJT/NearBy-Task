import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_fe/model/task_model.dart';

class JobPostService {
  Future<bool> postJob(TaskModel task) async {
    final url = Uri.parse("http://localhost:5000/connect/addTask");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(task.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        debugPrint("Error: ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return false;
    }
  }
}
