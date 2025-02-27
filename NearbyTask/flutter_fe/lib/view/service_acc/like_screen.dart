import 'package:flutter/material.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'My Likes',
          style:
              TextStyle(color: Color(0xFF0272B1), fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
