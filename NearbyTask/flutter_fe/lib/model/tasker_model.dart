class TaskerModel{
  final String bio;
  final String specialization;
  final String skills;
  final bool? availability;
  final int wagePerHour;
  final String? taskerDocuments;
  final String? socialMediaLinks;
  final String taskerAddress;

  TaskerModel({
    required this.bio,
    required this.specialization,
    required this.skills,
    required this.taskerAddress,
    this.availability,
    required this.wagePerHour,
    this.taskerDocuments,
    this.socialMediaLinks
  });

  //Factory to manage tasker data.
  factory TaskerModel.fromJson(Map<String, dynamic> json) {
    return TaskerModel(
      bio: json['bio'] ?? '',
      skills: json['skills'] ?? '',
      availability: json['availability'] ?? false,
      wagePerHour: json['wage_per_hour'] ?? 0,
      socialMediaLinks: json['social_media_links'] ?? '',
      taskerAddress: json['address'] ?? '',
      specialization: json['tasker_specialization'] != null
          ? json['tasker_specialization']['specialization']
          : '',
      taskerDocuments: json['tasker_documents'] ?? '', // Allow empty string for null values
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "bio": bio,
      "specialization": specialization,
      "skills": skills,
      "address": taskerAddress,
      "availability": availability,
      "wage_per_hour": wagePerHour,
      "tesda_documents_link": taskerDocuments,
      "social_media_links": socialMediaLinks
    };
  }
}