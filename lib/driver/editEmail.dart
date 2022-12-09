import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/Screens/Orders/PlaceOrder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../My Widgets/my_text_field.dart';

class EditEmailDriver extends StatelessWidget {
  const EditEmailDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Expanded(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    iconSize: 22.sp,
                  ),
                )),
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Edit Email',
                      style: GoogleFonts.poppins(fontSize: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyTextField(
                prefixIcon: const Icon(Icons.mail, color: Colors.black),
                controller: _emailController,
                label: 'Email',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  var auth = FirebaseAuth.instance.currentUser!.uid;
                  if (_emailController.text.isNotEmpty) {
                    FirebaseAuth.instance.currentUser!
                        .updateEmail(_emailController.text);
                    FirebaseFirestore.instance
                        .collection('Driver')
                        .doc(auth)
                        .update({'email': _emailController.text}).whenComplete(
                            () {
                      displayToastMessage('Information Updated', context);
                      Navigator.pop(context);
                    });
                  } else {
                    displayToastMessage('Enter Credentials', context);
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
                        child: Text('Change Email',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditPhoneDriver extends StatelessWidget {
  const EditPhoneDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _phoneController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Expanded(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    iconSize: 22.sp,
                  ),
                )),
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Edit Phone Number',
                      style: GoogleFonts.poppins(fontSize: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyTextField(
                prefixIcon: const Icon(Icons.phone, color: Colors.black),
                controller: _phoneController,
                label: 'Phone',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  var auth = FirebaseAuth.instance.currentUser!.uid;
                  if (_phoneController.text.isNotEmpty) {
                    FirebaseFirestore.instance
                        .collection('Driver')
                        .doc(auth)
                        .update({
                      'contact': _phoneController.text
                    }).whenComplete(() {
                      displayToastMessage('Information Updated', context);
                      Navigator.pop(context);
                    });
                  } else {
                    displayToastMessage('Enter Credentials', context);
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
                        child: Text('Change Phone Number',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditPasswordDriver extends StatelessWidget {
  const EditPasswordDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _passController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Expanded(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    iconSize: 22.sp,
                  ),
                )),
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Edit Password',
                      style: GoogleFonts.poppins(fontSize: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyTextField(
                prefixIcon: const Icon(Icons.password, color: Colors.black),
                controller: _passController,
                label: 'Password',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  var auth = FirebaseAuth.instance.currentUser!.uid;
                  if (_passController.text.isNotEmpty) {
                    FirebaseAuth.instance.currentUser!
                        .updatePassword(_passController.text)
                        .whenComplete(() {
                      displayToastMessage('Information Updated', context);
                      Navigator.pop(context);
                    });
                    // FirebaseFirestore.instance
                    //     .collection('Driver')
                    //     .doc(auth)
                    //     .update({'email': _passController.text});
                  } else {
                    displayToastMessage('Enter Credentials', context);
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
                        child: Text('Change Password',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditCityDriver extends StatelessWidget {
  const EditCityDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _cityController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Expanded(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    iconSize: 22.sp,
                  ),
                )),
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Edit City',
                      style: GoogleFonts.poppins(fontSize: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyTextField(
                prefixIcon:
                    const Icon(Icons.location_city, color: Colors.black),
                controller: _cityController,
                label: 'City',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  var auth = FirebaseAuth.instance.currentUser!.uid;
                  if (_cityController.text.isNotEmpty) {
                    FirebaseFirestore.instance
                        .collection('Driver')
                        .doc(auth)
                        .update({'city': _cityController.text}).whenComplete(
                            () {
                      displayToastMessage('Information Updated', context);
                      Navigator.pop(context);
                    });
                  } else {
                    displayToastMessage('Enter Credentials', context);
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
                        child: Text('Change City',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
