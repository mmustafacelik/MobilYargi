// ignore: file_names
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilyargi/pages/AddSubjectPage/AddSubjectPage.dart';
import 'package:mobilyargi/pages/ForgotpasswordPage/ForgotPasswordPage.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException {
      Fluttertoast.showToast(
          msg: "Fotoğraf seçilemedi.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color.fromARGB(255, 61, 77, 3),
          textColor: Colors.blue,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<String> nickName() async {
      CollectionReference usersRef =
          FirebaseFirestore.instance.collection('Users');
      var userinfo =
          await usersRef.doc(FirebaseAuth.instance.currentUser!.email).get();
      return (userinfo['UserNickname']) ?? 'null';
    }

    String kullaniciadigetir(AsyncSnapshot<String> snapshot) {
      if (snapshot.hasData) {
        return "Kullanıcı Adınız...:" + snapshot.data!;
      } else
        return 'null';
    }

    TextEditingController? _kullaniciadi;
    Future<bool> isAdmin() async {
      CollectionReference usersRef =
          FirebaseFirestore.instance.collection('Users');
      var userinfo =
          await usersRef.doc(FirebaseAuth.instance.currentUser!.email).get();
      return (userinfo['IsAdmin']) ?? false;
    }

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 15,
        ),
        Center(
          child: SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                const CircleAvatar(
                  //Todo:backend image picker ile upload edilip network image'de gösterilecek
                  backgroundImage: NetworkImage(
                      "https://cdn1.iconfinder.com/data/icons/avatars-1-5/136/60-512.png"),
                ),
                Positioned(
                  bottom: 0,
                  right: -25,
                  child: RawMaterialButton(
                    onPressed: () {
                      //TODO:Upload edilecek resim izni
                      pickImage();
                    },
                    elevation: 2.0,
                    fillColor: const Color(0xFFF5F6F9),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.all(15.0),
                    shape: const CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              //controller: _emailcontroller,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 206, 237, 241),
                filled: true,
                hintText: FirebaseAuth.instance.currentUser!.email,
                enabled: false,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                prefixIcon: const Icon(
                  Icons.mail,
                  color: Colors.blue,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.3,
            child: FutureBuilder<String>(
                future: nickName(),
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _kullaniciadi,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 206, 237, 241),
                      filled: true,
                      hintText: kullaniciadigetir(snapshot),
                      enabled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  );
                }),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 15,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
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
                      "Bilgilerimi Güncelle",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  // FirebaseFirestore.instance
                  //     .collection("Users")
                  //     .where((uid), isEqualTo: true)
                  //     .get()
                  //     .then((value) => print(value.docs[0].data()));

                  /*if(kullanici adi alınmışsa && _kullaniciadi.text==null)
                  {
                    Fluttertoast.showToast(
                                    msg:
                                        "Girdiğiniz kullanıcı adı alınmış.Lütfen farklı bir kullanıcı adı deneyiniz.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor:
                                        const Color.fromARGB(255, 61, 77, 3),
                                    textColor: Colors.blue,
                                    fontSize: 16.0);
                  }
                  
                */
                  /*else 
                {
                  Fluttertoast.showToast(
                                    msg:
                                        "Kullanıcı adınız başarı ile değiştirildi.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor:
                                        const Color.fromARGB(255, 61, 77, 3),
                                    textColor: Colors.blue,
                                    fontSize: 16.0);
                                    Future.delayed(
                          const Duration(seconds: 2),
                          (() {
                            setState(() {
                              
                            });
                          }),
                        );
                }
                  
                */
                },
              ),
              GestureDetector(
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
                      "Şifremi Güncelle",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        GestureDetector(
          child: FutureBuilder<bool>(
            future: isAdmin(),
            builder: (context, fSnapshot) {
              if (fSnapshot.hasData) {
                return Visibility(
                  visible: fSnapshot.data!,
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
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AddSubjectPage()),
            );
          },
        ),
      ],
    );
  }
}
