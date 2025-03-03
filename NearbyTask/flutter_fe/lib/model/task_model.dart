import 'package:flutter/material.dart';

class TaskModel {
  final int? id;
  final String? title;
  final String? specialization;
  final String? description;
  final String? location;
  final String? duration;
  final int? numberOfDays;
  final String? urgency;
  final int? contactPrice;
  final String? remarks;
  final String? taskBeginDate;

  TaskModel({
    this.id,
    this.title,
    this.specialization,
    this.description,
    this.location,
    this.duration,
    this.numberOfDays,
    this.urgency,
    this.contactPrice,
    this.remarks,
    this.taskBeginDate,
  });

  // Convert to JSON (for API usage)
  Map<String, dynamic> toJson() {
    return {
      "job_post_id": id,
      "job_title": title, // Changed from task_title
      "specialization": specialization,
      "description": description, // Changed from task_description
      "location": location,
      "duration": duration,
      "num_of_days": numberOfDays, // Changed from period
      "urgency": urgency,
      "contact_price": contactPrice,
      "remarks": remarks,
      "task_begin_date": taskBeginDate
    };
  }

  // Convert from JSON (for fetching data)
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    debugPrint("Parsing JSON: $json"); // Debug print
    return TaskModel(
      id: json['job_post_id'] as int?,
      title: json['task_title'] ?? json['job_title'] as String?,
      specialization: json['specialization'] as String?,
      description: json['task_description'] ?? json['description'] as String?,
      location: json['location'] as String?,
      duration: json['duration'] as String?,
      numberOfDays: json['period'] ?? json['num_of_days'] as int?,
      urgency: json['urgency'] as String?,
      contactPrice: json['contact_price'] as int?,
      remarks: json['remarks'] as String?,
      taskBeginDate: json['task_begin_date'] as String?,
    );
  }
}
