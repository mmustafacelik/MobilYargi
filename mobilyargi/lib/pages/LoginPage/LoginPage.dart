import 'package:flutter/material.dart';
import 'package:mobilyargi/pages/ForgotpasswordPage/ForgotPasswordPage.dart';
import 'package:mobilyargi/pages/HomePage/Homepage.dart';
import 'package:mobilyargi/pages/LoginPage/cubit/loginpage_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilyargi/pages/RegisteryPage/RegisteryPage.dart';

import '../../componenets/Text_field/Passwordtextformfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController _emailcontroller = TextEditingController();
  late String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginpageCubit(),
      child: SafeArea(
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 150,
                  height: 150,
                  child: Image.asset("assets/terazi.png"),
                ),
                Text(
                  "Mobil Yargı",
                  style: GoogleFonts.pacifico(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 2, 165, 187),
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Container(
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
                        padding: const EdgeInsets.only(top: 50, left: 20),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: Text(
                          "Lütfen bilgileriniz ile giriş yapınız",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
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
                      EmailTextField(emailcontroller: _emailcontroller),
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
                        labelText: 'Buraya parolanızı giriniz.',
                        onFieldSubmitted: (String value) {
                          {
                            _password = value;
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            child: const loginButtons(),
                            //ToDo:Backend
                            onTap: () {
                              final bool isValid = EmailValidator.validate(
                                  _emailcontroller.text);

                              if (/*isValid*/ true) {
                                //Todo:Backend servisleri
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
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
                            child: const forgotPasswordButton(),
                            //ToDo:Backend
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPasswordPage()),
                              );
                            },
                          ),
                          InkWell(
                            child: const registeryButton(),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisteryPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.emailcontroller,
  }) : super(key: key);

  final TextEditingController emailcontroller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailcontroller,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.mail),
      ),
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
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

class forgotPasswordButton extends StatelessWidget {
  const forgotPasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10),
      width: MediaQuery.of(context).size.width / 3,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.amber,
      ),
      child: Center(
        child: Text(
          "Şifremi Unuttum",
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
