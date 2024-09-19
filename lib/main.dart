import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('assets/background.png'), // Add your image path
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color:
                    Colors.black.withOpacity(0.5), // Adds transparent overlay
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                // Logo or Icon
                Icon(
                  Icons.attach_money, // App icon related to money
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                // App Name
                Text(
                  'Money Manager',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                // Login Form Container
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Email Input
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Password Input
                      TextField(
                        controller: passwordController,
                        obscureText: true, // Hide the password
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Login Button
                      ElevatedButton(
                        onPressed: () {
                          // Call login function
                          emailPasswordLogin(
                              emailController.text, passwordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF5A877D),
                          padding: EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Google Sign-In Button
                      ElevatedButton.icon(
                        onPressed: () {
                          signInWithGoogle();
                        },
                        icon: Icon(Icons.login, color: Colors.white),
                        label: Text('Login with Google'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function for Email/Password login
  Future<void> emailPasswordLogin(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("Logged in as: ${userCredential.user!.email}");
    } catch (e) {
      print("Error: $e");
    }
  }

  // Function for Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("Logged in with Google: ${googleUser.email}");
    } catch (e) {
      print("Error: $e");
    }
  }
}
