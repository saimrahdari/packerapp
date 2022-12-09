import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../My Widgets/my_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Change Password',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Old Password',style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.2),
              MyTextField(
                controller: _oldPasswordController,
                isPasswordField: true,
              ),
              const SizedBox(height: 25),
              const Text('New Password',style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.2),
              MyTextField(
                controller: _newPasswordController,
                isPasswordField: true,
              ),
              const SizedBox(height: 25),
              const Text('Confirm Password',style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.2),
              MyTextField(
                controller: _confirmPasswordController,
                isPasswordField: true,
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () async {
                  if(_newPasswordController.text == _confirmPasswordController.text){
                    Fluttertoast.showToast(msg: 'Authenticating');
                    final user = FirebaseAuth.instance.currentUser;
                    FirebaseAuth.instance.signInWithEmailAndPassword(email: user!.email!, password: _oldPasswordController.text).then((value){
                      value.user!.updatePassword(_confirmPasswordController.text);
                      Fluttertoast.showToast(msg: 'Password changed');
                      Navigator.pop(context);
                    }).catchError((e){
                      Fluttertoast.showToast(msg: 'Wrong Current Password');
                    });
                  }else{
                    Fluttertoast.showToast(msg: 'New and Confirm passwords are not same');
                  }
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
                    child: Center(child: Text('Update', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
