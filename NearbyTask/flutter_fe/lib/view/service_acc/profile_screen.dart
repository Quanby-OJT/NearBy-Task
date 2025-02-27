import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //final AuthenticationController _controller = AuthenticationController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0272B1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          '',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 150,
                  color: Color(0xFF0272B1),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 30),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name',
                                    style: GoogleFonts.openSans(
                                        color: Color(0xFF0272B1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                TextField(
                                  enabled: false,
                                  cursorColor: Color(0xFF0272B1),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF1F4FF),
                                      hintText: 'John Doe',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFF0272B1),
                                              width: 2))),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Specialization',
                                    style: GoogleFonts.openSans(
                                        color: Color(0xFF0272B1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                TextField(
                                  enabled: false,
                                  cursorColor: Color(0xFF0272B1),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF1F4FF),
                                      hintText: 'Electrician',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFF0272B1),
                                              width: 2))),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Contact Number',
                                    style: GoogleFonts.openSans(
                                        color: Color(0xFF0272B1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                TextField(
                                  enabled: false,
                                  cursorColor: Color(0xFF0272B1),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF1F4FF),
                                      hintText: '099991345262',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFF0272B1),
                                              width: 2))),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email',
                                    style: GoogleFonts.openSans(
                                        color: Color(0xFF0272B1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                TextField(
                                  enabled: false,
                                  cursorColor: Color(0xFF0272B1),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF1F4FF),
                                      hintText: 'test@gmail.com',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFF0272B1),
                                              width: 2))),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Address',
                                    style: GoogleFonts.openSans(
                                        color: Color(0xFF0272B1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                TextField(
                                  enabled: false,
                                  cursorColor: Color(0xFF0272B1),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF1F4FF),
                                      hintText: 'Legazpi, Albay',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFF0272B1),
                                              width: 2))),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date of Birth',
                                    style: GoogleFonts.openSans(
                                        color: Color(0xFF0272B1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                TextField(
                                  enabled: false,
                                  cursorColor: Color(0xFF0272B1),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF1F4FF),
                                      hintText: '09/02/2000',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xFF0272B1),
                                              width: 2))),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Container(
                                height: 50,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF0272B1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  icon: Icon(Icons.logout, color: Colors.white),
                                  label: Text('Logout',
                                      style: TextStyle(color: Colors.white)),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            alignment: Alignment(0, -0.85),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/image1.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
