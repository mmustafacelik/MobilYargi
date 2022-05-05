import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilyargi/pages/HomePage/Homepage.dart';

import 'cubit/addsubjectpage_cubit.dart';

class AddSubjectPage extends StatefulWidget {
  const AddSubjectPage({Key? key}) : super(key: key);

  @override
  State<AddSubjectPage> createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    Future<String> nickName() async {
      CollectionReference usersRef =
          FirebaseFirestore.instance.collection('Users');
      var userinfo =
          await usersRef.doc(FirebaseAuth.instance.currentUser!.email).get();
      return (userinfo['UserNickname']) ?? 'null';
    }

    CollectionReference subjectRef =
        FirebaseFirestore.instance.collection('Subjects');
    TextEditingController titlecontroller = TextEditingController();
    TextEditingController indexcontroller = TextEditingController();
    return BlocProvider(
      create: (context) => AddsubjectpageCubit(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/SubjectAdd.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width / 15,
                ),
                TextFormField(
                  controller: titlecontroller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Başlık",
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 5,
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 5,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 13,
                ),
                Flexible(
                  child: TextFormField(
                    controller: indexcontroller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "İçerik",
                      labelStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          width: 5,
                          color: Colors.red,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 5,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, left: 10),
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.amber,
                    ),
                    child: Center(
                      child: Text(
                        "Konu Ekle",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    subjectRef.doc(titlecontroller.text).set({
                      "Date": DateTime.now(),
                      "Writer": await nickName(),
                      "NumberofLike": 0,
                      "Title": titlecontroller.text,
                      "Index": indexcontroller.text,
                    });
                  },
                ),
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, left: 10),
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.amber,
                    ),
                    child: Center(
                      child: Text(
                        "Anasayfaya Git",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
