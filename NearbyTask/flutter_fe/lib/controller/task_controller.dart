import 'package:flutter/material.dart';
import 'package:flutter_fe/model/task_model.dart';
import 'package:flutter_fe/service/job_post_service.dart';

class TaskController {
  final JobPostService _jobPostService = JobPostService();
  final jobIdController = TextEditingController();
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

  Future<Map<String, dynamic>> postJob() async {
    final task = TaskModel(
      id: int.tryParse(jobIdController.text) ?? 0,
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

    return await _jobPostService.postJob(task);
  }
}
