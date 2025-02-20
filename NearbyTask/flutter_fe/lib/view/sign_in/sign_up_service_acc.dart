import 'package:flutter/material.dart';
import 'package:flutter_fe/view/sign_in/sign_in.dart';

class SignUpServiceAcc extends StatefulWidget {
  const SignUpServiceAcc({super.key});

  @override
  State<SignUpServiceAcc> createState() => _SignUpServiceAccState();
}

class _SignUpServiceAccState extends State<SignUpServiceAcc> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _continue() {
    if (_formKey.currentState!.validate()) {
      if (_currentStep < 2) {
        setState(() {
          _currentStep += 1;
        });
      } else {
        // Final Step Submission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Form Submitted Successfully!")),
        );
      }
    }
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Create Account',
              style: TextStyle(
                  color: const Color(0xFF0272B1),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 80, right: 80, top: 10, bottom: 10),
              child: Text(
                textAlign: TextAlign.center,
                "Provide service right away, create an account now!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            Container(
              height: 550,
              child: Form(
                key: _formKey,
                child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme:
                          ColorScheme.light(primary: Color(0xFF0272B1))),
                  child: Expanded(
                    child: Stepper(
                      currentStep: _currentStep,
                      onStepContinue: _continue,
                      onStepCancel: _back,
                      steps: [
                        Step(
                          title: Text("Step 1: Basic Information"),
                          content: Column(
                            children: [
                              // TextFormField(
                              //   controller: _nameController,
                              //   decoration: InputDecoration(
                              //       labelText: "Enter your name"),
                              //   validator: (value) =>
                              //       value!.isEmpty ? "Name is required" : null,
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  controller: _nameController,
                                  cursorColor: Color(0xFF0272B1),
                                  validator: (value) => value!.isEmpty
                                      ? "First name is required"
                                      : null,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF1F4FF),
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFF0272B1),
                                              width: 2))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  cursorColor: Color(0xFF0272B1),
                                  validator: (value) => value!.isEmpty
                                      ? "Last name is required"
                                      : null,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF1F4FF),
                                      hintText: 'Last Name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFF0272B1),
                                              width: 2))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  cursorColor: Color(0xFF0272B1),
                                  validator: (value) => value!.isEmpty
                                      ? "Contact is required"
                                      : null,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF1F4FF),
                                      hintText: 'Contact number',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFF0272B1),
                                              width: 2))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  cursorColor: Color(0xFF0272B1),
                                  validator: (value) => value!.isEmpty
                                      ? "Address is required"
                                      : null,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF1F4FF),
                                      hintText: 'Address',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFF0272B1),
                                              width: 2))),
                                ),
                              ),
                            ],
                          ),
                          isActive: _currentStep >= 0,
                        ),
                        Step(
                          title: Text("Step 2: Authentication"),
                          content: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  controller: _emailController,
                                  cursorColor: Color(0xFF0272B1),
                                  validator: (value) => value!.isEmpty
                                      ? "Email is required"
                                      : null,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF1F4FF),
                                      hintText: 'Enter email',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFF0272B1),
                                              width: 2))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  cursorColor: Color(0xFF0272B1),
                                  validator: (value) => value!.isEmpty
                                      ? "Password is required"
                                      : null,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF1F4FF),
                                      hintText: 'Enter password',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFF0272B1),
                                              width: 2))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  cursorColor: Color(0xFF0272B1),
                                  validator: (value) => value!.isEmpty
                                      ? "Password is required"
                                      : null,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF1F4FF),
                                      hintText: 'Confirm password',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFF0272B1),
                                              width: 2))),
                                ),
                              )
                            ],
                          ),
                          isActive: _currentStep >= 1,
                        ),
                        Step(
                          title: Text("Step 3: Certificates"),
                          content: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                labelText: "Enter your password"),
                            obscureText: true,
                            validator: (value) => value!.length < 6
                                ? "Password must be at least 6 characters"
                                : null,
                          ),
                          isActive: _currentStep >= 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(left: 40, right: 40, top: 60),
            //   child: TextField(
            //     cursorColor: Color(0xFF0272B1),
            //     decoration: InputDecoration(
            //         filled: true,
            //         fillColor: Color(0xFFF1F4FF),
            //         hintText: 'Email',
            //         hintStyle: TextStyle(color: Colors.grey),
            //         enabledBorder: OutlineInputBorder(
            //             borderSide:
            //                 BorderSide(color: Colors.transparent, width: 0),
            //             borderRadius: BorderRadius.circular(10)),
            //         focusedBorder: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10),
            //             borderSide:
            //                 BorderSide(color: Color(0xFF0272B1), width: 2))),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 40, right: 40, top: 20, bottom: 20),
            //   child: TextField(
            //     cursorColor: Color(0xFF0272B1),
            //     decoration: InputDecoration(
            //         filled: true,
            //         fillColor: Color(0xFFF1F4FF),
            //         hintText: 'Password',
            //         hintStyle: TextStyle(color: Colors.grey),
            //         enabledBorder: OutlineInputBorder(
            //             borderSide:
            //                 BorderSide(color: Colors.transparent, width: 0),
            //             borderRadius: BorderRadius.circular(10)),
            //         focusedBorder: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10),
            //             borderSide:
            //                 BorderSide(color: Color(0xFF0272B1), width: 2))),
            //   ),
            // ),

            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignIn();
                  }));
                },
                child: Text(
                  textAlign: TextAlign.right,
                  'Already have an account',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
