import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilyargi/componenets/Text_field/Passwordtextformfield.dart';
import 'package:mobilyargi/pages/LoginPage/LoginPage.dart';

import 'cubit/registerypage_cubit.dart';

class RegisteryPage extends StatelessWidget {
  RegisteryPage({Key? key}) : super(key: key);

  late String _password;
  late String _againpassword;
  String _email = "";
  String _nickname = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    Future<void> kayitol() async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password)
            .then((kullanici) {
          FirebaseFirestore.instance.collection("Users").doc(_email).set({
            "UserNickname": _nickname,
            "UsersEmail": _email,
            "IsAdmin": false
          });
        });
      } on FirebaseAuthException catch (e) {
        String errorMessage = e.message!;
        Fluttertoast.showToast(
          msg: "Bu sebeple kayıt olamadınız--->" + errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color.fromARGB(255, 61, 77, 3),
          textColor: Colors.blue,
          fontSize: 16.0,
        );
        return;
      }
      {
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
        }
        Fluttertoast.showToast(
            msg: "Başarı ile kayıt oldunuz emailinizi onaylayınız.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color.fromARGB(255, 61, 77, 3),
            textColor: Colors.blue,
            fontSize: 16.0);
        Future.delayed(
          const Duration(seconds: 3),
          (() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          }),
        );
      }
    }

    return BlocProvider(
      create: (context) => RegisterypageCubit(),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/loginpagebackground.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: 150,
                height: 150,
                child: Image.asset("assets/terazi.png"),
              ),
              Text(
                "Yargı Mobil",
                style: GoogleFonts.pacifico(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 2, 165, 187),
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Color.fromARGB(230, 61, 14, 205),
                  ),
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: Text(
                          "Hoş Geldiniz",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Kullanıcı Adı",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                        ),
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          _nickname = value;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "E-posta Adresiniz",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        onChanged: (value) {
                          _email = value;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          "Parola",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      PasswordField(
                        onChanged: (String value) {
                          {
                            _password = value;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          "Parola Yeniden",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      PasswordField(
                        labelText: 'Yukarıdaki parolayı tekrar giriniz',
                        onChanged: (String value) {
                          {
                            _againpassword = value;
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            child: const registeryButton(),
                            onTap: () {
                              final bool isValid =
                                  EmailValidator.validate(_email);
                              if (isValid) {
                                if (_password == _againpassword) {
                                  kayitol();
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Parolalar eşleşmiyor.Lütfen tekrar deneyiniz",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor:
                                          const Color.fromARGB(255, 61, 77, 3),
                                      textColor: Colors.blue,
                                      fontSize: 16.0);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "Girdiğiniz mail geçersiz.Lütfen yeniden deneyiniz.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor:
                                        const Color.fromARGB(255, 61, 77, 3),
                                    textColor: Colors.blue,
                                    fontSize: 16.0);
                              }
                            },
                          ),
                          GestureDetector(
                            child: const loginButtons(),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class loginButtons extends StatelessWidget {
  const loginButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10),
      width: MediaQuery.of(context).size.width / 5,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.amber,
      ),
      child: Center(
        child: Text(
          "Giriş Yap",
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class registeryButton extends StatelessWidget {
  const registeryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10),
      width: MediaQuery.of(context).size.width / 4,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.amber,
      ),
      child: Center(
        child: Text(
          "Kayıt Ol",
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
