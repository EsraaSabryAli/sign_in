import 'package:flutter/material.dart';
import 'package:sign_in/screens/sign_in_screen.dart';
import 'package:sign_in/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
