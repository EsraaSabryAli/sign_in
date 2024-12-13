import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sign_in/screens/home_screen.dart';
import 'package:sign_in/screens/sign_up.dart';

// import 'package:sign_in/url.dart';
class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    final String apiUrl = "http://127.0.0.1:5000/login";

    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Check if login was successful
        if (data['message'] == "Login successful") {
          print("Navigating to HomeScreen");

          // Navigate to HomeScreen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          // Show error message from API
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Sign-in failed')),
          );
        }
      } else {
        // Handle non-200 responses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    } catch (error) {
      // Handle network or parsing errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "     Welcome",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: ""),
                  ),
                  Text(
                    "     Back...",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "BubblegumSans"),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(67, 75, 213, 100),
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 200.0)),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 33,
            ),
            Text(
              "Email",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail_outline_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Password",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline_rounded),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    signIn(); // Perform sign-in
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(67, 75, 213, 100),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account ?",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: const Text('Register Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
