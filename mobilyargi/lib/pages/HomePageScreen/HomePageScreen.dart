import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilyargi/pages/HomePageScreen/cubit/homepagescreen_cubit.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: getBody(context),
    );
  }

  getBody(BuildContext context) {
    CollectionReference subjeclist =
        FirebaseFirestore.instance.collection('Subjects');
    return BlocProvider(
      create: ((context) => HomepagescreenCubit()),
      child: StreamBuilder<QuerySnapshot>(
          stream: subjeclist.snapshots(),
          builder: (BuildContext context, snap) {
            if (snap.data == null) return CircularProgressIndicator();
            List<DocumentSnapshot> listofDocumets = snap.data!.docs;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                return Text(
                  listofDocumets[index]['Title'],
                  //style: TextStyle(fontSize: 24),
                );
              }),
              itemCount: listofDocumets.length,
            );

            Container(
              margin: const EdgeInsets.only(left: 20),
              color: const Color.fromRGBO(37, 204, 223, 0.5),
              child: Text("sda"),
            );
          }),
    );
  }
}

// bool _admin = false;
// void isAdmin() async {
//   CollectionReference usersRef = FirebaseFirestore.instance.collection('Users');
//   var userinfo =
//       await usersRef.doc(FirebaseAuth.instance.currentUser!.email).get();
//   _admin = userinfo['IsAdmin'];
// }

