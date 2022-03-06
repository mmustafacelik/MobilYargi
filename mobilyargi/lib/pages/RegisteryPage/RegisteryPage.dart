import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cubit/registerypage_cubit.dart';

class RegisteryPage extends StatelessWidget {
  const RegisteryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
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
            ],
          ),
        ),
      ),
    );
  }
}
