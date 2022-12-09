import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../My Widgets/driverDrawer.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({Key? key}) : super(key: key);

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerDriver(context),
      appBar: AppBar(
        key: _key,
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(fontSize: 18.sp),
        ),
        leading: IconButton(
            onPressed: () {
              _key.currentState!.openDrawer();
            },
            icon: const Icon(Icons.view_headline_outlined)),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/profile.png',
                      fit: BoxFit.cover,
                    )),
                // Container(
                //   alignment: Alignment.center,
                //   child: SizedBox(
                //     height: 140.0,
                //     width: MediaQuery.of(context).size.width / 3 + 10,
                //     child: Center(
                //       child: AspectRatio(
                //         aspectRatio: 4 / 3,
                //         child: Container(
                //           decoration: BoxDecoration(
                //             border: Border.all(color: Colors.white, width: 2.0),
                //             borderRadius: BorderRadius.circular(15.0),
                //           ),
                //           child: ClipRRect(
                //               borderRadius: BorderRadius.circular(15.0),
                //               child: Image.asset(
                //                 'assets/profile.png',
                //                 width: 40,
                //                 height: 40.0,
                //                 fit: BoxFit.cover,
                //               )),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Details',
                      style: GoogleFonts.poppins(fontSize: 16.sp),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Image.asset(
                      'assets/edit.png',
                      width: 30.0,
                    )
                  ],
                ),
              ),
            ),
            const Divider(thickness: 1),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 30.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(8.r))),
                      child: const Icon(
                        Icons.person,
                        // color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Email Address',
                        //   style: GoogleFonts.poppins(fontSize: 16.sp),
                        // ),
                        StreamBuilder<String>(
                            stream: FirebaseFirestore.instance
                                .collection('Driver')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots()
                                .map(
                                    (event) => event.data()!['username'] ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                );
                              } else {
                                return const Text('');
                              }
                            })
                      ],
                    ),
                  ),
                  // const Expanded(
                  //   child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Icon(Icons.arrow_forward_ios),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 30.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(8.r))),
                      child: const Icon(
                        Icons.email_outlined,
                        // color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Email Address',
                        //   style: GoogleFonts.poppins(fontSize: 16.sp),
                        // ),
                        StreamBuilder<String>(
                            stream: FirebaseFirestore.instance
                                .collection('Driver')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots()
                                .map((event) => event.data()!['email'] ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data.toString());
                              } else {
                                return const Text('');
                              }
                            })
                      ],
                    ),
                  ),
                  // const Expanded(
                  //   child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Icon(Icons.arrow_forward_ios),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 30.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(8.r))),
                      child: const Icon(
                        Icons.phone,
                        // color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Phone no',
                        //   style: GoogleFonts.poppins(fontSize: 16.sp),
                        // ),
                        StreamBuilder<String>(
                            stream: FirebaseFirestore.instance
                                .collection('Driver')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots()
                                .map((event) => event.data()!['contact'] ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data.toString());
                              } else {
                                return const Text('');
                              }
                            })
                      ],
                    ),
                  ),
                  // const Expanded(
                  //   child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Icon(Icons.arrow_forward_ios),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 30.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(8.r))),
                      child: const Icon(
                        Icons.location_city,
                        // color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Phone no',
                        //   style: GoogleFonts.poppins(fontSize: 16.sp),
                        // ),
                        StreamBuilder<String>(
                            stream: FirebaseFirestore.instance
                                .collection('Driver')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots()
                                .map((event) => event.data()!['city'] ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data.toString());
                              } else {
                                return const Text('');
                              }
                            })
                      ],
                    ),
                  ),
                  // const Expanded(
                  //   child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Icon(Icons.arrow_forward_ios),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Vehicle Details',
                  style: GoogleFonts.poppins(fontSize: 16.sp),
                ),
              ),
            ),
            const Divider(thickness: 1),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 30.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(8.r))),
                      child: Image.asset(
                        'assets/car.png',
                        scale: 3.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Phone no',
                        //   style: GoogleFonts.poppins(fontSize: 16.sp),
                        // ),
                        StreamBuilder<String>(
                            stream: FirebaseFirestore.instance
                                .collection('Driver')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                // .collection('vehicleDetails')
                                // .doc('Zbwb6pw2XwVjIxai4F3R')
                                .snapshots()
                                .map((event) =>
                                    event.data()!['vehicleModel'] ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return const Text('CHR');
                              } else {
                                return const Text('');
                              }
                            })
                      ],
                    ),
                  ),
                  // const Expanded(
                  //   child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Icon(Icons.arrow_forward_ios),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 30.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(8.r))),
                      child: Image.asset(
                        'assets/staring.png',
                        scale: 3.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Phone no',
                        //   style: GoogleFonts.poppins(fontSize: 16.sp),
                        // ),
                        StreamBuilder<String>(
                            stream: FirebaseFirestore.instance
                                .collection('Driver')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots()
                                .map((event) => event.data()!['contact'] ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return const Text('1234');
                              } else {
                                return const Text('');
                              }
                            })
                      ],
                    ),
                  ),
                  // const Expanded(
                  //   child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Icon(Icons.arrow_forward_ios),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 30.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(8.r))),
                      child: Image.asset(
                        'assets/plate.png',
                        scale: 3.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Phone no',
                        //   style: GoogleFonts.poppins(fontSize: 16.sp),
                        // ),
                        StreamBuilder<String>(
                            stream: FirebaseFirestore.instance
                                .collection('Driver')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots()
                                .map((event) => event.data()!['contact'] ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return const Text('4314');
                              } else {
                                return const Text('');
                              }
                            })
                      ],
                    ),
                  ),
                  // const Expanded(
                  //   child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Icon(Icons.arrow_forward_ios),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 30.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(8.r))),
                      child: Image.asset(
                        'assets/color.png',
                        scale: 3.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Phone no',
                        //   style: GoogleFonts.poppins(fontSize: 16.sp),
                        // ),
                        StreamBuilder<String>(
                            stream: FirebaseFirestore.instance
                                .collection('Driver')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots()
                                .map((event) => event.data()!['contact'] ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return const Text('Grey');
                              } else {
                                return const Text('');
                              }
                            })
                      ],
                    ),
                  ),
                  // const Expanded(
                  //   child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Icon(Icons.arrow_forward_ios),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
