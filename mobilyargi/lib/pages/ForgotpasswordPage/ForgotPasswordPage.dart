import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilyargi/pages/ForgotpasswordPage/cubit/forgotpasswordpage_cubit.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);
  final TextEditingController _emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotpasswordpageCubit(),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Mobil Yargı",
                    style: GoogleFonts.pacifico(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 2, 165, 187),
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                FloatingActionButton(
                    mini: true,
                    child: const Icon(Icons.arrow_back),
                    backgroundColor: const Color.fromARGB(255, 16, 181, 223),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    "Parolanızı Yenileyin",
                    style: GoogleFonts.pacifico(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 114, 245),
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ClipOval(
                    child: Image.asset(
                      "assets/forgotpassword.jpg",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      controller: _emailcontroller,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 206, 237, 241),
                        filled: true,
                        hintText: "Mailinizi Giriniz",
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: (() {
                      final bool isValid =
                          EmailValidator.validate(_emailcontroller.text);
                      if (isValid) {
                        resetPassword();
                        Fluttertoast.showToast(
                            msg: "İsteğiniz Gönderilmiştir.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor:
                                const Color.fromARGB(255, 61, 77, 3),
                            textColor: Colors.blue,
                            fontSize: 16.0);
                        //Başarılı ise 2 saniye sonra giriş yap sayfasına gidecek
                        Future.delayed(
                          const Duration(seconds: 2),
                          (() {
                            Navigator.pop(context);
                          }),
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Emailiniz geçersiz.Lütfen geçerli bir e-mail giriniz",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor:
                                const Color.fromARGB(255, 61, 77, 3),
                            textColor: Colors.blue,
                            fontSize: 16.0);
                      }
                    }),
                    child: const Center(child: loginButtons())),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailcontroller.text);
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
          "Gönder",
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
