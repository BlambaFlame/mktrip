import 'package:flutter/material.dart';
import 'package:mktrip/main_pages.dart';

void main() => runApp(const MKTripApp());

class MKTripApp extends StatelessWidget {
  const MKTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MKTrip',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.deepPurple
      ),
      home: const MainPages(),
    );
  }
}



