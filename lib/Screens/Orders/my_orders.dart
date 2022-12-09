import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/Screens/Chats/chat.dart';
import 'package:fyp/Screens/Orders/order_details.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Models/order_model.dart';
import '../../Services/Firestore/my_firestore.dart';
import '../../Services/constants.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final User? user = FirebaseAuth.instance.currentUser;
  String tab = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        actions: [
          // notification icon and search icon
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const Notification(),
              //   ),
              // );
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 25.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          tab = "All";
                        });
                      },
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: tab == "All" ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: const Center(
                          child: Text(
                            'All',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          tab = "In Progress";
                        });
                      },
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          color:
                              tab == "In Progress" ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: const Center(
                          child: Text(
                            'In Progress',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          tab = "Completed";
                        });
                      },
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: tab == "Completed" ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: const Center(
                          child: Text(
                            'Completed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<List<OrderModel>>(
                stream: FirebaseFirestore.instance
                    .collection('Orders')
                    .snapshots()
                    .map((event) => event.docs
                        .where((element) => element
                            .data()['id']
                            .toString()
                            .contains(FirebaseAuth
                                .instance.currentUser!.uid.hashCode
                                .toString()))
                        .map((e) => OrderModel(
                              bidRequestId: e.id,
                              id: e.data()['id'],
                              userName: e.data()['userName'],
                              userId: e.data()['userId'],
                              email: e.data()['email'],
                              departureCountry: e.data()['departureCountry'],
                              arrivalCountry: e.data()['arrivalCountry'],
                              arrivalCity: e.data()['arrivalCity'],
                              departureCity: e.data()['departureCity'],
                              description: e.data()['description'],
                              delivery: e.data()['delivery'],
                              flightDate: e.data()['flightDate'],
                              weight: e.data()['weight'],
                              bidderUserId: e.data()['bidderUserId'],
                              bidderEmail: e.data()['bidderEmail'],
                              bidderUserName: e.data()['bidderUserName'],
                              amount: e.data()['amount'],
                              status: e.data()['status'] ?? 'Pending',
                              message: e.data()['message'],
                            ))
                        .where((element) =>
                            tab == "All" && element.status != null
                                ? true
                                : element.status == "Accepted" &&
                                        tab == "In Progress"
                                    ? true
                                    : (element.status == "Completed" &&
                                                tab == "Completed") ||
                                            (element.status == "Rejected" &&
                                                tab == "Rejected")
                                        ? true
                                        : false)
                        .toList()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.all(8.sp),
                          margin: EdgeInsets.only(bottom: 12.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.0),
                            color: Colors.white,
                          ),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  '${snapshot.data![index].departureCity}\n'),
                                          TextSpan(
                                            text: snapshot
                                                .data![index].departureCountry,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.blue),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        snapshot.data![index].flightDate,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.centerRight,
                                    child: RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  '${snapshot.data![index].arrivalCity}\n'),
                                          TextSpan(
                                            text: snapshot
                                                .data![index].arrivalCountry,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              SizedBox(
                                height: 25.h,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Image.asset(
                                                'assets/a.png.png'))),
                                    Expanded(
                                      flex: 3,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          FirebaseAuth.instance.currentUser!
                                                      .uid ==
                                                  snapshot.data![index].userId
                                              ? snapshot
                                                  .data![index].bidderUserName
                                              : snapshot.data![index].userName,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '\$${snapshot.data![index].amount}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  snapshot.data![index].description,
                                  style: GoogleFonts.poppins(fontSize: 12.sp),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  const Spacer(),
                                  const Spacer(),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => OrderDetails(
                                                    orderId: snapshot
                                                        .data![index]
                                                        .bidRequestId,
                                                  )));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffDFDFDF),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.r))),
                                      child: Center(
                                        child: Text(
                                          'More details',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('No Orders'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
