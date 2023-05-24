import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/Pages/DetailsPage.dart';
import 'package:mobileapp/Pages/ListPage.dart';

/// Main method of the application
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

/// This class is responsible for the ListPage state
class _LoginPageState extends State<LoginPage> {

  /// This method is responsible for signing in the user
  @override
  void initState() {
    super.initState();
    // Initialize Firebase
    Firebase.initializeApp();
  }

  /// This method is responsible for signing in the user
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential);

    // Navigate to list page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListPage(userObj: userCredential!),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        backgroundColor: const Color.fromRGBO(37,160,162, 1),
        title: const Center(child: Text('Login')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[  ElevatedButton(
               style: ElevatedButton.styleFrom(
                 backgroundColor: const Color.fromRGBO(37,160,162, 1),
                 onPrimary: Colors.white,
                ),
                onPressed: signInWithGoogle,
                child: const Text('Sign In with Google'),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
