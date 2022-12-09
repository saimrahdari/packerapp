import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/Orders/PlaceOrder.dart';

import 'Login_page.dart';
import 'Signup_page.dart';

class ResetPage extends StatefulWidget {
  ResetPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  Widget _emailField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Email Id",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail),
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email Required';
              }
              return null;
            },
            // onSaved: (value) {
            //   userLoginData['email'] = value!;
            // },
            controller: emailController,
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: resetUser,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xff3E4685),
                  Color(0xff3E4685),
                ])),
        child: Text(
          'Reset Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(5),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xff3E4685),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'PA',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Color(0xff3E4685),
          ),
          children: [
            TextSpan(
              text: 'CK',
              style: TextStyle(color: Color(0xff3E4685), fontSize: 36),
            ),
            TextSpan(
              text: 'ER',
              style: TextStyle(color: Color(0xff3E4685), fontSize: 36),
            ),
          ]),
    );
  }

  TextEditingController emailController = TextEditingController();

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _emailField(),
      ],
    );
  }

  Future<void> resetUser() async {
    final String email = emailController.text;

    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.sendPasswordResetEmail(email: email);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      displayToastMessage(
          "Password reset email has been sent to your mail", context);
      print("Passwrod reset");
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          displayToastMessage("Your email address is not valid", context);

          break;
        case "user-not-found":
          displayToastMessage("User not found for this email", context);

          break;
        default:
          displayToastMessage("Error", context);
      }
    } catch (e) {
      displayToastMessage("Error" + e.toString(), context);
      print("error");
    }
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // void loginUser() async {
  //   // CommanDialog.showLoading();

  //   final firebaseUser = (await _auth
  //           .signInWithEmailAndPassword(
  //               email: emailController.text, password: passwordController.text)
  //           .catchError((errmsg) {
  //     // Navigator.pop(context);
  //     displayToastMessage("error" + errmsg.toString(), context);
  //   }))
  //       .user;

  //   if (firebaseUser != null) {
  //     final User? user = await _auth.currentUser;
  //     final userid = user?.uid;
  //     print(userid);
  //     userRef.child(userid!).once().then((value) => (DataSnapshot snap) {
  //           if (snap.value != null) {
  //             Navigator.of(context).push(MaterialPageRoute(
  //                 builder: (BuildContext context) => Container()));

  //             displayToastMessage("Your are logged in", context);
  //           } else {
  //             _auth.signOut();
  //             displayToastMessage("no record fount", context);
  //             print("No recored");
  //           }
  //         });

  //     displayToastMessage("congratulations", context);
  //     Navigator.of(context).push(
  //         MaterialPageRoute(builder: (BuildContext context) => MenuScreen()));
  //   } else {
  //     _auth.signOut();
  //     displayToastMessage("No record exist", context);
  //   }
  // }

  // displayToastMessage(msg, BuildContext context) {
  //   Fluttertoast.showToast(msg: msg);
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xfffD5DEEF),
          body: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0xff3E4685),
                        ))
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        _title(),
                        SizedBox(height: 40),
                        _emailPasswordWidget(),
                        SizedBox(height: 20),
                        _submitButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
