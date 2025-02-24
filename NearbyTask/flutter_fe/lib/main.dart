import 'package:flutter/material.dart';
import 'package:flutter_fe/view/welcome_page/welcome_page_view_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePageViewMain(),
    );
  }
}
