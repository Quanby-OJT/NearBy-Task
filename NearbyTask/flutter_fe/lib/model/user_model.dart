class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final dynamic
      image; // Can be either a String (URL) or Uint8List (binary data)
  final String? imageName; // Store image filename if available

//This is what the controller used
  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.image,
    this.imageName,
  });

  // Factory constructor to handle image as either URL or binary data, this is for the display record part
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
      // Check if the image is a URL (String) or binary data (Uint8List)
      image: json['image'] is String
          ? json['image']
          : null, // Assuming image is a URL (String)
      imageName: json['image_name'],
    );
  }

// Returns whith these datas
  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      // Store the image as a URL (String) or handle binary data (Uint8List) if needed
    };
  }
}
