import 'package:flutter/material.dart';
import 'package:mktrip/pages/auth/account_page.dart';
import 'package:mktrip/pages/auth/login_page.dart';
import 'package:mktrip/pages/auth/reset_password_page.dart';
import 'package:mktrip/pages/auth/services/firebase_stream.dart';
import 'package:mktrip/pages/auth/signup_page.dart';
import 'package:mktrip/pages/auth/verify_email_page.dart';
import 'package:mktrip/pages/home_page.dart';
import 'package:mktrip/pages/map_page.dart';
import 'package:mktrip/pages/places_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPages extends StatefulWidget {
  const MainPages({super.key});

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int currentPageIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MKTrip'),
        actions: [
          IconButton(
            onPressed: () {
              if ((user == null)) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountPage()),
                );
              }
            },
            icon: Icon(
              Icons.person,
              color: (user == null) ? Colors.white : Colors.yellow,
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.deepPurple,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.place, color: Colors.white),
            icon: Icon(Icons.place),
            label: 'Places',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.map, color: Colors.white ),
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
      ),
      body: <Widget>[
        const MyHomePage(),
        const PlacesPage(),
         MapPage ([]),
        const FirebaseStream(),
        const AccountPage(),
        const LoginPage(),
        const SignUpPage(),
        const ResetPasswordPage(),
        const VerifyEmailPage(),
      ][currentPageIndex],
    );
  }
}