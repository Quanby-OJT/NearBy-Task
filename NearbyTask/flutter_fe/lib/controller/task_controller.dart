import 'package:flutter/material.dart';
import 'package:flutter_fe/service/job_post_service.dart';

class TaskController {
  final JobPostService _jobPostService = JobPostService();

  final jobTitleController = TextEditingController();
  final jobSpecializationController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final jobLocationController = TextEditingController();
  final jobDurationController = TextEditingController();
  final jobDaysController = TextEditingController();
  final jobUrgencyController = TextEditingController();
  final contactpriceController = TextEditingController();
  final jobRemarksController = TextEditingController();
  final jobTaskBeginDateController = TextEditingController();

  Future<void> postJob() async {
    // Kinuha ang values mula sa controllers
    final jobData = {
      "job_title": jobTitleController.text,
      "specialization": jobSpecializationController.text,
      "description": jobDescriptionController.text,
      "location": jobLocationController.text,
      "duration": jobDurationController.text,
      "num_of_days": int.tryParse(jobDaysController.text) ?? 0,
      "urgency": jobUrgencyController.text,
      "contact_price": int.tryParse(contactpriceController.text) ?? 0,
      "remarks": jobRemarksController.text,
      "task_begin_date": jobTaskBeginDateController.text,
    };

    // Tatawagin ang service para mag-post ng job
    bool success = await _jobPostService.postJob(jobData);

    if (success) {
      print("Job posted successfully!");
    } else {
      print("Failed to post job.");
    }
  }
}
