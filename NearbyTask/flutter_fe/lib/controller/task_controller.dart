import 'package:flutter/material.dart';
import 'package:flutter_fe/model/task_model.dart';
import 'package:flutter_fe/service/job_post_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TaskController extends GetxController {
  final JobPostService _jobPostService = JobPostService();
  final jobTitleController = TextEditingController();
  final jobSpecializationController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final jobLocationController = TextEditingController();
  final jobDurationController = TextEditingController();
  final jobDaysController = TextEditingController();
  final jobUrgencyController = TextEditingController();
  final contactPriceController = TextEditingController();
  final jobRemarksController = TextEditingController();
  final jobTaskBeginDateController = TextEditingController();
  final contactpriceController = TextEditingController();
  final storage = GetStorage();
  var specializations = <String>[].obs;
  var isLoading = false.obs;

  Future<Map<String, dynamic>> postJob() async {
    final int user_id = storage.read('user_id');
    final task = TaskModel(
      title: jobTitleController.text,
      specialization: jobSpecializationController.text,
      description: jobDescriptionController.text,
      location: jobLocationController.text,
      duration: jobDurationController.text,
      numberOfDays: int.tryParse(jobDaysController.text) ?? 0,
      urgency: jobUrgencyController.text,
      contactPrice: int.tryParse(contactPriceController.text) ?? 0,
      remarks: jobRemarksController.text,
      taskBeginDate: jobTaskBeginDateController.text,
    );

    return await _jobPostService.postJob(task, user_id);
  }
}
