import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/Screens/Chats/chat.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Models/bid_request_model.dart';
import '../../Services/Firestore/my_firestore.dart';
import '../../Services/constants.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
          physics: const AlwaysScrollableScrollPhysics(),
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
                      'Requests',
                      style: GoogleFonts.poppins(fontSize: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            StreamBuilder<List<BidRequestModel>>(
                stream: FirebaseFirestore.instance
                    .collection('Requests')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('Bids')
                    .snapshots()
                    .map((event) => event.docs
                        .map((e) => BidRequestModel(
                              bidRequestId: e.id,
                              arrivalCity: e.data()['arrivalCity'],
                              arrivalCountry: e.data()['arrivalCountry'],
                              departureCity: e.data()['departureCity'],
                              departureCountry: e.data()['departureCountry'],
                              flightNo: e.data()['flightNo'],
                              pricePerKg: e.data()['pricePerKg'],
                              description: e.data()['description'],
                              flightDate: e.data()['flightDate'],
                              weight: e.data()['weight'],
                              bidderUserId: e.data()['bidderUserId'],
                              bidderEmail: e.data()['bidderEmail'],
                              bidderUserName: e.data()['bidderUserName'],
                              amount: e.data()['amount'],
                              status: e.data()['status'] ?? 'Pending',
                              message: e.data()['message'],
                            ))
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
                        physics: const ClampingScrollPhysics(),
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
                                              text: snapshot
                                                  .data![index].departureCity),
                                          TextSpan(
                                            text: snapshot
                                                .data![index].departureCountry,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
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
                                              text: snapshot
                                                  .data![index].arrivalCity),
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
                                          snapshot.data![index].bidderUserName,
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
                                  snapshot.data![index].message,
                                  style: GoogleFonts.poppins(fontSize: 12.sp),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              if (snapshot.data![index].status ==
                                  'Pending') ...[
                                Row(
                                  children: [
                                    const Spacer(),
                                    Expanded(
                                        child: GestureDetector(
                                      onTap: () {
                                        declineBidRequest(
                                            userId: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            bidRequestId: snapshot
                                                .data![index].bidRequestId);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffDFDFDF),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.r))),
                                        child: Center(
                                          child: Text(
                                            'Decline',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                      ),
                                    )),
                                    SizedBox(width: 10.h),
                                    Expanded(
                                        child: GestureDetector(
                                      onTap: () {
                                        acceptBidRequest(
                                            userId: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            bidRequestId: snapshot
                                                .data![index].bidRequestId);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: const Color(0xff2A94F4),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.r))),
                                        child: Center(
                                          child: Text(
                                            'Accept',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12.sp,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                              ] else if (snapshot.data![index].status ==
                                  'Accepted') ...[
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
                                                builder: (_) => Chat(
                                                  isFromHome: true,
                                                      setBidder: (){
                                                        FirebaseFirestore.instance
                                                            .collection('Chats')
                                                            .doc(getChatId(
                                                            userId1: user!.uid,
                                                            userId2: snapshot
                                                                .data![index].bidderUserId))
                                                            .set({
                                                          'bidder': snapshot
                                                              .data![index].bidderUserId,
                                                        });
                                                      },
                                                      otherUserId: snapshot
                                                          .data![index]
                                                          .bidderUserId,
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
                                            'Message',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('No requests'),
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
