class UserModel {
  final String userName;
  final String email;
  final String password;

//This is what the controller used
  UserModel({
    required this.userName,
    required this.email,
    required this.password,
  });

  // Factory constructor to handle image as either URL or binary data, this is for the display record part
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

// Returns whith these datas
  Map<String, dynamic> toJson() {
    return {
      "username": userName,
      "email": email,
      "password": password,
      // Store the image as a URL (String) or handle binary data (Uint8List) if needed
    };
  }
}
