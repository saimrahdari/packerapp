import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/Screens/DashboardScreen/bidding_screen.dart';
import 'package:fyp/Services/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Models/trip_model.dart';

class FindTrips extends StatefulWidget {
  const FindTrips({Key? key}) : super(key: key);

  @override
  State<FindTrips> createState() => _FindTripsState();
}

class _FindTripsState extends State<FindTrips> {
  final User? user = FirebaseAuth.instance.currentUser;

  String? departure;
  String? arrival;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
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
                          'Find Trips',
                          style: GoogleFonts.poppins(fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                FutureBuilder<List<String>>(
                  future: FirebaseFirestore.instance
                      .collection('Data')
                      .doc('cities')
                      .get()
                      .then((value) => (value.data()!['cities'] as List)
                          .map((e) => e.toString())
                          .toList()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Departure',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textScaleFactor: 1.2),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: DropdownButton<String>(
                                        value: departure,
                                        icon: const Icon(
                                            Icons.arrow_drop_down_outlined),
                                        iconSize: 24.sp,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        underline: const SizedBox(),
                                        isExpanded: true,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            departure = newValue!;
                                          });
                                        },
                                        items: snapshot.data!
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Arrival',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textScaleFactor: 1.2),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: DropdownButton<String>(
                                        value: arrival,
                                        icon: const Icon(
                                            Icons.arrow_drop_down_outlined),
                                        iconSize: 24.sp,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        underline: const SizedBox(),
                                        isExpanded: true,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            arrival = newValue!;
                                          });
                                        },
                                        items: snapshot.data!
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          StreamBuilder<List<TripModel>>(
                              stream: FirebaseFirestore.instance
                                  .collection('All Trips')
                                  .where('userId', isNotEqualTo: user!.uid)
                                  .where('departureCity', isEqualTo: departure)
                                  .where('arrivalCity', isEqualTo: arrival)
                                  .snapshots()
                                  .map((event) => event.docs
                                      .map((e) => TripModel(
                                            description:
                                                e.data()['description'] ?? '',
                                            flightDate:
                                                e.data()['flightDate'] ?? '',
                                            email: e.data()['email'] ?? '',
                                            userId: e.data()['userId'] ?? '',
                                            userName:
                                                e.data()['userName'] ?? '',
                                            weight: e.data()['weight'] ?? '',
                                            departureCountry:
                                                e.data()['departureCountry'] ??
                                                    '',
                                            departureCity:
                                                e.data()['departureCity'] ?? '',
                                            arrivalCountry:
                                                e.data()['arrivalCountry'] ??
                                                    '',
                                            arrivalCity:
                                                e.data()['arrivalCity'] ?? '',
                                            flightNo:
                                                e.data()['flightNo'] ?? '',
                                            pricePerKg:
                                                e.data()['pricePerKg'] ?? '',
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
                                      primary: false,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        padding: EdgeInsets.all(8.sp),
                                        margin: EdgeInsets.only(bottom: 12.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9.0),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: '${snapshot
                                                                .data![index]
                                                                .departureCity}\n'),
                                                        TextSpan(
                                                          text: snapshot
                                                              .data![index]
                                                              .departureCountry,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                                Expanded(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      snapshot.data![index]
                                                          .flightDate,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12.sp),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: '${snapshot
                                                                .data![index]
                                                                .arrivalCity}\n'),
                                                        TextSpan(
                                                          text: snapshot
                                                              .data![index]
                                                              .arrivalCountry,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                snapshot
                                                    .data![index].description,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12.sp),
                                              ),
                                            ),
                                            SizedBox(height: 15.h),
                                            SizedBox(
                                              height: 30.h,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Image.asset(
                                                              'assets/a.png.png'))),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        snapshot.data![index]
                                                            .userName,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize:
                                                                    12.sp),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        '${snapshot.data![index].weight} KG',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize:
                                                                    11.sp),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            BiddingScreen(
                                                                              tripModel: snapshot.data![index],
                                                                            ))),
                                                        child: Text(
                                                          'More Details >>',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize:
                                                                      12.sp),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: Text('No trips found'),
                                    );
                                  }
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
