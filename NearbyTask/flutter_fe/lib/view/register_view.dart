import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import '../controller/register_controller.dart';
import '../model/user_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterController _controller = RegisterController();
  Uint8List? _selectedImage; // Store the selected image bytes
  String? _imageName; // Store the selected image name
  final List<UserModel> _users =
      []; // Store fetched users, iyo yung sa display record sa baba

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchUsers();
  // }

//For Displaying the record (record functionality)
//   Future<void> _fetchUsers() async {
//     try {
//       List<UserModel> users = await ApiService.fetchAllUsers();
//       setState(() {
//         _users = users;
//       });
//     } catch (e) {
//       print("Error fetching users: $e");
//     }
//   }

//Allow us to pick a File using FilePicker Dependencies
  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Allow only images, so other file ay bawal
      allowMultiple: false,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _selectedImage = result.files.single.bytes; // Store image bytes
        _imageName = result.files.single.name; // Store file name
        _controller.setImage(
            _selectedImage! as File, _imageName!); // Pass image to controller
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Title Ang nandito
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First Name Input Field Start
            TextField(
              controller: _controller.firstNameController,
              decoration: InputDecoration(labelText: "First Name"),
            ),
            // First Name Input Field End
            // LN Input Field Start
            TextField(
              controller: _controller.lastNameController,
              decoration: InputDecoration(labelText: "Last Name"),
            ),
            // LN Input Field End
            // Email Input Field Start
            TextField(
              controller: _controller.emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            // Email Input Field End
            // Password Input Field Start
            TextField(
              controller: _controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            // Password Input Field End
            // Confirm Password Input Field Start
            TextField(
              controller: _controller.confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Confirm Password"),
            ),
            // Confirm Password Input Field End
            SizedBox(height: 10),

            // Image Picker Button Start
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Pick Image"),
            ),
            // Image Picker Button End

            // Show Selected Image Start (if any if not yung icon makikita base sa baba)
            _selectedImage != null
                ? Column(
                    children: [
                      Text("Selected Image: $_imageName"),
                      Image.memory(_selectedImage!, height: 200), // Show image
                    ],
                  )
                : Text("No Image Selected"),

            SizedBox(height: 20),
            // Show Selected Image End

            // Register Button Start
            ElevatedButton(
              onPressed: () {
                _controller.registerUser(context);
              },
              child: Text("Register"),
            ),
            // Register Button End

            // Display all records start
            SizedBox(height: 20),
            Text("All Registered Users:"),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];
                  return Card(
                    child: ListTile(
                      title: Text("${user.firstName} ${user.lastName}"),
                      subtitle: Text(user.email),
                      leading: user.image != null
                          ? user.image is String
                              ? Image.network(
                                  user.image!) // If the image is a URL (String)
                              : Image.memory(user
                                  .image!) // If the image is in binary format (Uint8List)
                          : Icon(Icons
                              .person), // Placeholder icon if no image, ito madidisplay pag walang image, ang default nya is itong profile icon
                    ),
                  );
                },
              ),
            ),
            // Display all records end
          ],
        ),
      ),
    );
  }
}
