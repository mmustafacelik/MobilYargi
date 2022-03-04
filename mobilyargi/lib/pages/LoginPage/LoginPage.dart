import 'package:flutter/material.dart';
import 'package:mobilyargi/pages/LoginPage/cubit/loginpage_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  var emailcontroller;
  var password;
  bool _isObscure = true;
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
                SizedBox(
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
                          "Hoşgeldiniz",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
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
                            textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "E-posta Adresiniz",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: emailcontroller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: [AutofillHints.email],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          "Parola",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        controller: password,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              //ToDo:Buraya bloc listener koy
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(top: 20, left: 10),
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
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //ToDo:Backend
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(top: 20, left: 10),
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
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //ToDo:Backend
                            onTap: () {},
                          ),
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(top: 20, left: 10),
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
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //ToDo:Backend
                            onTap: () {},
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
