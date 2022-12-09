import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/Screens/Authentication/Login_page.dart';
import 'package:fyp/Screens/BottomNavigationScreens/payment_screen.dart';
import 'package:fyp/Screens/ProfileScreen/my_details.dart';
import 'package:google_fonts/google_fonts.dart';
import '../DashboardScreen/request.dart';
import '../Orders/my_orders.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        child: SafeArea(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }
                if (snapshot.hasData) {
                  var userDocument = snapshot.data!.data();
                  return ListView(
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_back_ios_sharp),
                              iconSize: 22.sp,
                            ),
                          )),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Settings',
                                style: GoogleFonts.poppins(fontSize: 18.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      userDocument!["profile_image"].toString().isEmpty
                          ? Icon(Icons.person_outline_outlined, size: 80.sp)
                          : Image.network(userDocument["profile_image"],
                              height: 100.h),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          userDocument["username"],
                          style: GoogleFonts.poppins(fontSize: 18.sp),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          userDocument["email"],
                          style: GoogleFonts.poppins(fontSize: 12.sp),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyDetailScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Expanded(
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.add_box))),
                              Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'My Details',
                                    style: GoogleFonts.poppins(fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RequestScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Expanded(
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.add_box))),
                              Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Request',
                                    style: GoogleFonts.poppins(fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyOrders()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Expanded(
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.add_box))),
                              Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Orders',
                                    style: GoogleFonts.poppins(fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.add_box))),
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Courier',
                                  style: GoogleFonts.poppins(fontSize: 14.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          // builder: (context) => PaymentHistory(
                          //       amount: "100",
                          //     )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Expanded(
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.add_box))),
                              Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Payment Method',
                                    style: GoogleFonts.poppins(fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Expanded(
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.logout))),
                              Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Sign Out',
                                    style: GoogleFonts.poppins(fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              }),
        ),
      ),
    );
  }
}
