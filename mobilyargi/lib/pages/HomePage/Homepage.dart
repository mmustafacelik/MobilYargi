// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilyargi/pages/HomePage/cubit/homepage_cubit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mobilyargi/pages/InboxPage/inboxpage.dart';
import 'package:mobilyargi/pages/LoginPage/LoginPage.dart';
import 'package:badges/badges.dart';
import 'package:mobilyargi/pages/ProfilePage/ProfilePage.dart';

import '../HomePageScreen/HomePageScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentindex = 0;
  final screens = [
    const HomePageScreen(),
    InboxPage(),
    const Center(
      child: Text(
        "Star",
        style: TextStyle(
          fontSize: 60,
        ),
      ),
    ),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color.fromARGB(101, 91, 218, 235),
        height: 45,
        backgroundColor: const Color.fromARGB(255, 253, 0, 173),
        items: const [
          Icon(Icons.home, size: 30, color: Colors.blue),
          Icon(Icons.move_to_inbox, size: 30, color: Colors.blue),
          Icon(Icons.star, size: 30, color: Colors.blue),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.blue,
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            currentindex = index;
            setState(() {});
          } else if (index == 1) {
            currentindex = index;
            setState(() {});
          } else if (index == 2) {
            currentindex = index;
            setState(() {});
          } else {
            currentindex = index;
            setState(() {});
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 150, 0, 100),
        title: Center(
          child: Text(
            "Yargı Mobil",
            style: GoogleFonts.pacifico(
              textStyle: const TextStyle(
                color: Color.fromARGB(255, 2, 165, 187),
                fontSize: 23,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            iconSize: 30,
            color: Colors.black,
            onPressed: () {
              Fluttertoast.showToast(
                  msg: "Başarıyla çıkış yapıldı.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2,
                  backgroundColor: const Color.fromARGB(255, 61, 77, 3),
                  textColor: Colors.blue,
                  fontSize: 16.0);
              Future.delayed(
                const Duration(seconds: 1),
                (() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
      body: getBody(context), //getBody(context),
    );
  }

  getBody(BuildContext context) {
    return BlocProvider(
      create: (context) => HomepageCubit(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/homepagebackground.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: IndexedStack(
              index: currentindex,
              children: screens,
            ),
          ),
        ),
      ),
    );
  }
}
