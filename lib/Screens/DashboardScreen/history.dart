import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/main.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryService extends StatefulWidget {
  const HistoryService({Key? key}) : super(key: key);

  @override
  State<HistoryService> createState() => _HistoryServiceState();
}

class _HistoryServiceState extends State<HistoryService> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> userdata = FirebaseFirestore.instance
        .collection('Users')
        .doc(currentFirebaseUser?.uid)
        .collection("My Trips")
        .snapshots();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            Row(
              children: [
                Expanded(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios_sharp),
                    iconSize: 22.sp,
                  ),
                )),
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'History',
                      style: GoogleFonts.poppins(fontSize: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            StreamBuilder<QuerySnapshot>(
              stream: userdata,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  children: [
                    Text(
                      "All Trips",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18.sp)),
                    ),
                    Container(
                      height: 200.h,
                      margin: EdgeInsets.only(left: 5.w, top: 15.h),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return Container(
                            height: 140.h,
                            width: 230.w,
                            padding: EdgeInsets.all(8.sp),
                            margin: EdgeInsets.only(right: 12.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.0),
                              color: Colors.white,
                            ),
                            child: Column(children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                    child: data["image"].toString().isEmpty
                                        ? SizedBox(
                                            height: 100,
                                            child: Center(
                                                child: Text("No Image Found")))
                                        : Center(
                                            child:
                                                Image.network('https://images.unsplash.com/photo-1507812984078-917a274065be?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YWlycGxhbmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60', fit: BoxFit.cover,)),
                                  )),
                              SizedBox(height: 5.h),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${data['departure']}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${data['flightDate']}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${data['arrival']}",
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${data['weight']} Weight",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "More Details >>",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      "Recent Trips",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18.sp)),
                    ),
                    Container(
                      height: 200.h,
                      margin: EdgeInsets.only(left: 5.w, top: 15.h),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return Container(
                            height: 140.h,
                            width: 230.w,
                            padding: EdgeInsets.all(8.sp),
                            margin: EdgeInsets.only(right: 12.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.0),
                              color: Colors.white,
                            ),
                            child: Column(children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                    child: data["image"].toString().isEmpty
                                        ? SizedBox(
                                            height: 100,
                                            child: Center(
                                                child: Text("No Image Found")))
                                        : Center(
                                            child:
                                                Image.network('https://images.unsplash.com/photo-1507812984078-917a274065be?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YWlycGxhbmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60')),
                                  )),
                              SizedBox(height: 5.h),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${data['departure']}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${data['flightDate']}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${data['arrival']}",
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${data['weight']} Weight",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "More Details >>",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
