import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_page.dart';
import 'sign_in.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(),
      initialData: null,
      child: Consumer<User?>(
        builder: (context, user, _) {
          if (user == null) {
            return const SignInPage();
          }
          return HomePage();
        },
      ),
    );
  }
}
