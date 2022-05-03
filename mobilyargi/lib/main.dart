import 'package:flutter/material.dart';
import 'package:mobilyargi/pages/AddSubjectPage/AddSubjectPage.dart';
import 'package:mobilyargi/pages/ForgotpasswordPage/ForgotPasswordPage.dart';
import 'package:mobilyargi/pages/HomePage/Homepage.dart';
import 'package:mobilyargi/pages/LoginPage/LoginPage.dart';
import 'package:mobilyargi/pages/RegisteryPage/RegisteryPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      (() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AddSubjectPage(),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splashscreen.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
