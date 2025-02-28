class UserModel {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String password;
  final String role;

//This is what the controller used
  UserModel({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role
  });

  // Factory constructor to handle image as either URL or binary data, this is for the display record part
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        firstName: json['first_name'] ?? '',
        middleName: json['middle_name'] ?? '',
        lastName: json['last_name'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        role: json['user_role'] ?? ''
    );
  }

// Returns whith these datas
  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "user_role": role
      // Store the image as a URL (String) or handle binary data (Uint8List) if needed
    };
  }
}
