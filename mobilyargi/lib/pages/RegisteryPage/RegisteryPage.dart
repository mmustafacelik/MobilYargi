import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilyargi/componenets/Text_field/Passwordtextformfield.dart';
import 'package:mobilyargi/pages/LoginPage/LoginPage.dart';

import 'cubit/registerypage_cubit.dart';

class RegisteryPage extends StatelessWidget {
  RegisteryPage({Key? key}) : super(key: key);
  final TextEditingController _emailcontroller = TextEditingController();
  final GlobalKey _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey _againpasswordFieldKey = GlobalKey<FormFieldState<String>>();
  late String _password;
  late String _againpassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

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
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
                          fieldKey: _passwordFieldKey,
                          onFieldSubmitted: (String value) {
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
                          fieldKey: _againpasswordFieldKey,
                          labelText: 'Yukarıdaki parolayı tekrar giriniz',
                          onFieldSubmitted: (String value) {
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
                              //ToDo:Backend
                              onTap: () {
                                final bool isValid = EmailValidator.validate(
                                    _emailcontroller.text);
                                if (isValid) {
                                  if (_password == _againpassword) {
                                    //Todo:Local kontroller sonrası backend tarafı
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Parolalar eşleşmiyor.Lütfen tekrar deneyiniz",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: const Color.fromARGB(
                                            255, 61, 77, 3),
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

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.emailcontroller,
  }) : super(key: key);

  final TextEditingController emailcontroller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.mail),
      ),
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
    );
  }
}
