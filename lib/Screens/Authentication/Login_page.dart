import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/Authentication/Signup_page.dart';
import 'package:fyp/Screens/Authentication/verificationPage.dart';
import 'package:fyp/Screens/Orders/PlaceOrder.dart';
import '../../My Widgets/my_text_field.dart';
import '../../Services/constants.dart';
import '../BottomNavigationScreens/bottom_navigation_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 50
                    ),
                    child: Center(
                      child: Text('LOGO',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 1.2,
                      ),
                    ),
                  ),
                  const Text('Welcome Back',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 2,),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 50
                    ),
                    child: Text('Login to continue using',
                      style: TextStyle(color: Colors.grey,),),
                  ),
                  MyTextField(
                    prefixIcon: const Icon(Icons.mail, color: Colors.black),
                    controller: _emailController,
                    label: 'Email',
                  ),
                  MyTextField(
                    prefixIcon: const Icon(Icons.password, color: Colors.black),
                    controller: _passwordController,
                    isPasswordField: true,
                    label: 'Password',
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: const Text('Forget Password', style: TextStyle(color: Colors.black),))),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final String email = _emailController.text;
                      final String password = _passwordController.text;

                      FirebaseAuth auth = FirebaseAuth.instance;
                      FirebaseFirestore db = FirebaseFirestore.instance;
                      // showDialog(
                      //     context: context,
                      //     barrierDismissible: false,
                      //     builder: (context) {
                      //       return Center(child: CircularProgressIndicator());
                      //     });

                      try {
                        final UserCredential user = await auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        final DocumentSnapshot snapshot =
                            await db.collection("Users").doc(user.user!.uid).get();
                        final data = snapshot.data;
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => const BottomNavigationScreen()));
                        displayToastMessage("congratulations", context);
                        print("user logged in successfully");
                      } catch (e) {
                        displayToastMessage("Error" + e.toString(), context);
                        print("error");
                      }
                      //hideLoading
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Center(child: Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      ),
                    ),
                  ),
                  const SizedBox.square(
                    dimension: 5,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignUpPage()));
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Center(child: Text('Register', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(onPressed: (){}, child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(text: 'Don\'t have an account? '),
                          TextSpan(text: 'Tap on register', style: TextStyle(fontWeight: FontWeight.bold))
                        ]
                      ),
                    )),
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}
