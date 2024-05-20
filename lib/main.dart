import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mktrip/main_pages.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MKTripApp());
}

class MKTripApp extends StatelessWidget {
  const MKTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MKTrip',
      theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.deepPurple),
      home: const MainPages(),
    );
  }
}
