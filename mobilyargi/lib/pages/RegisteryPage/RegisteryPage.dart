import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cubit/registerypage_cubit.dart';

class RegisteryPage extends StatelessWidget {
  RegisteryPage({Key? key}) : super(key: key);
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _secondpasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

//TODO:Sayfa Yönlendirilmeleri Yapılacak
  getBody(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
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
                "Mobil Yargı",
                style: GoogleFonts.pacifico(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 2, 165, 187),
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
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
                  height: 600,
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
                        SizedBox(
                          height: 20,
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
                        EmailTextField(emailcontroller: _emailcontroller),
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
                        passwordField(passwordcontroller: _passwordcontroller),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Text(
                            "Parola Yeniden",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        passwordField(
                            passwordcontroller: _secondpasswordcontroller),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              child: registeryButton(),
                              //ToDo:Backend
                              onTap: () {},
                            ),
                            GestureDetector(
                              child: loginButtons(),
                              //ToDo:Backend
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
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
            Icons.visibility,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
