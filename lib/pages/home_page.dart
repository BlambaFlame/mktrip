import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mktrip/pages/auth/account_page.dart';
import 'package:mktrip/pages/auth/login_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  int currentPageIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: (user == null)
              ? const Text("Контент для НЕ зарегистрированных в системе")
              : const Text('Контент для ЗАРЕГИСТРИРОВАННЫХ в системе'),
          //child: Text('Контент для НЕ зарегистрированных в системе'),
        ),
      ),
    );
  }
}
