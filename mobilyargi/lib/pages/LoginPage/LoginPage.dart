import 'package:flutter/material.dart';
import 'package:mobilyargi/pages/LoginPage/cubit/loginpage_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final LoginpageCubit _cubit = LoginpageCubit();
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50, left: 20),
                          child: Text(
                            "Hoş Geldiniz",
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
                        EmailTextField(emailcontroller: emailcontroller),
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
                        passwordField(passwordcontroller: passwordcontroller),
                        Row(
                          children: [
                            GestureDetector(
                              child: loginButtons(),
                              //ToDo:Backend
                              onTap: () {},
                            ),
                            GestureDetector(
                              child: forgotPasswordButton(),
                              //ToDo:Backend
                              onTap: () {},
                            ),
                            InkWell(
                              child: registeryButton(),
                              //ToDo:Backend
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
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
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
      ),
      keyboardType: TextInputType.emailAddress,
      autofillHints: [AutofillHints.email],
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
    );
  }
}

class passwordField extends StatelessWidget {
  const passwordField({
    Key? key,
    required this.passwordcontroller,
  }) : super(key: key);

  final TextEditingController passwordcontroller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      style: TextStyle(color: Colors.white),
      controller: passwordcontroller,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.password),
        suffixIcon: IconButton(
          icon: Icon(
              //!Buraya visibility off yapılacak
              Icons.visibility
              // : Icons.visibility_off,
              ),
          onPressed: () {},
        ),
      ),
    );
  }
}
