class TaskModel {
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

  // Convert to JSON (para gamitin sa API)
  Map<String, dynamic> toJson() {
    return {
      "job_title": title,
      "specialization": specialization,
      "description": description,
      "location": location,
      "duration": duration,
      "num_of_days": numberOfDays,
      "urgency": urgency,
      "contact_price": contactPrice,
      "remarks": remarks,
      "task_begin_date": taskBeginDate,
    };
  }

  // Convert from JSON (kung may fetch feature later)
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['task_title'] as String?,
      specialization: json['specialization'] as String?,
      description: json['task_description'] as String?,
      location: json['location'] as String?,
      duration: json['duration'] as String?,
      numberOfDays: json['period'] as int?,
      urgency: json['urgency'] as String?,
      contactPrice: json['contact_price'] as int?,
      remarks: json['remarks'] as String?,
      taskBeginDate: json['task_begin_date'] as String?,
    );
  }
}
