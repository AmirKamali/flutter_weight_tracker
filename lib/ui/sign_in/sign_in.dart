import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[ 
           const  Text(
                "Welcome to \r\nAwesome Weight Tracker!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold), // Adjust the font size here
              ),
            const SizedBox(height:100),
             ElevatedButton(
              child: const Text('Sign In Anonymously'),
              onPressed: () async {
               var _ = await FirebaseAuth.instance.signInAnonymously();
              },
                    ),
              const SizedBox(height:100),
            ]
        ),
      ),
    );
  }
}