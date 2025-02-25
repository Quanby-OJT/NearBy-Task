class TaskModel {
  final String title;
  final String specialization;
  final String description;
  final String location;
  final String duration;
  final int numberOfDays;
  final String urgency;
  final int contactPrice;
  final String remarks;
  final String taskBeginDate;

  TaskModel({
    required this.title,
    required this.specialization,
    required this.description,
    required this.location,
    required this.duration,
    required this.numberOfDays,
    required this.urgency,
    required this.contactPrice,
    required this.remarks,
    required this.taskBeginDate,
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
      title: json['job_title'],
      specialization: json['specialization'],
      description: json['description'],
      location: json['location'],
      duration: json['duration'],
      numberOfDays: json['num_of_days'],
      urgency: json['urgency'],
      contactPrice: json['contact_price'],
      remarks: json['remarks'],
      taskBeginDate: json['task_begin_date'],
    );
  }
}
