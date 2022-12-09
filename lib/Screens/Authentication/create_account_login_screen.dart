import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login_page.dart';
import 'Signup_page.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 26, 0, 90),
        body: Container(
          height: height * 0.965,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg1.jpg"), fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 70, bottom: 28),
                child: Text(
                  "Travel With Comfort And Safety",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        letterSpacing: .5,
                        fontWeight: FontWeight.bold,
                        fontSize: 38),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 28.0, left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      width: width * 0.3,
                      height: height * 0.07,
                      child: MaterialButton(
                        color: const Color.fromARGB(255, 65, 61, 251),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const SignUpPage()));
                        },
                        child: Text(
                          "Register",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.3,
                      height: height * 0.07,
                      child: MaterialButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginPage()));
                        },
                        child: Text(
                          "Sign in",
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.bold),
                              color: const Color.fromARGB(255, 65, 61, 251)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
