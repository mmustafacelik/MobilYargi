import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilyargi/pages/HomePageScreen/cubit/homepagescreen_cubit.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

// bool _admin = isAdmin();

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    isAdmin();
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return BlocProvider(
      create: ((context) => HomepagescreenCubit()),
      child: SingleChildScrollView(
        child: Column(
        children: const <Widget>[
          
        ],
        ),
      ),
    );
  }
}

Future<bool> isAdmin() async {
  CollectionReference usersRef = FirebaseFirestore.instance.collection('Users');
  var isAdmin =
      await usersRef.doc(FirebaseAuth.instance.currentUser!.email).get();
  print(isAdmin['isAdmin'] + "salak");
  return isAdmin['isAdmin'];
}
