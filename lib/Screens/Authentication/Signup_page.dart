import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/Orders/PlaceOrder.dart';
import '../../My Widgets/my_text_field.dart';
import '../../Services/constants.dart';
import 'Login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
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
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Center(
                    child: Text(
                      'LOGO',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 1.2,
                    ),
                  ),
                ),
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 2,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 50),
                  child: Text(
                    'Login to continue using',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                MyTextField(
                  prefixIcon: const Icon(Icons.person, color: Colors.black),
                  controller: _nameController,
                  label: 'Name',
                ),
                MyTextField(
                  prefixIcon: const Icon(Icons.mail, color: Colors.black),
                  controller: _emailController,
                  label: 'Email',
                ),
                MyTextField(
                  prefixIcon: const Icon(Icons.phone, color: Colors.black),
                  controller: _contactController,
                  label: 'Phone Number',
                ),
                MyTextField(
                  prefixIcon: const Icon(Icons.location_city, color: Colors.black),
                  controller: _cityController,
                  label: 'City',
                ),
                MyTextField(
                  prefixIcon: const Icon(Icons.password, color: Colors.black),
                  controller: _passwordController,
                  label: 'Password',
                  isPasswordField: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () async {
                    final String email = _emailController.text;
                    final String password = _passwordController.text;
                    final String username = _nameController.text;
                    final String phone = _contactController.text;
                    final String city = _cityController.text;

                    FirebaseAuth auth = FirebaseAuth.instance;
                    FirebaseFirestore db = FirebaseFirestore.instance;

                    try {
                      final UserCredential user =
                          await auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      user.user!.updateDisplayName(username);

                      await db.collection("Users").doc(user.user!.uid).set({
                        "username": username,
                        "email": email,
                        "contact": phone,
                        "profile_image": ""
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                      displayToastMessage("congratulations", context);
                      print("user is registered");
                    } catch (e) {
                      displayToastMessage("Error" + e.toString(), context);
                      print(e.toString());
                      print("error");
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Center(
                          child: Text('Create',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                ),
                const SizedBox.square(
                  dimension: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LoginPage()));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Center(
                          child: Text('Login',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                      onPressed: () {},
                      child: RichText(
                        text: const TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                  text: 'Login',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ]),
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
