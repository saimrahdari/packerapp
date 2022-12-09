import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/Models/trip_model.dart';
import 'package:fyp/My%20Widgets/my_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../My Widgets/my_button_2.dart';

class BiddingScreen extends StatefulWidget {
  final TripModel tripModel;

  const BiddingScreen({Key? key, required this.tripModel}) : super(key: key);

  @override
  State<BiddingScreen> createState() => _BiddingScreenState();
}

class _BiddingScreenState extends State<BiddingScreen> {

  final TextEditingController _biddingController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.0),
                  color: Colors.white,
                ),
                child: ListView(
                  shrinkWrap: true,
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
                                      fontWeight:
                                      FontWeight.w600),
                                  children: <TextSpan>[
                                    TextSpan(text: '${widget.tripModel.departureCity}\n'),
                                    TextSpan(
                                      text: widget.tripModel.departureCountry,
                                      style:
                                          GoogleFonts.poppins(
                                              fontSize: 12.sp,
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
                              widget.tripModel.flightDate,
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
                                      fontWeight:
                                      FontWeight.w600),
                                  children: <TextSpan>[
                                    TextSpan(text: '${widget.tripModel.arrivalCity}\n'),
                                    TextSpan(
                                      text: widget.tripModel.arrivalCountry,
                                      style:
                                          GoogleFonts.poppins(
                                              fontSize: 12.sp,
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
                        widget.tripModel.description,
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      height: 30.h,
                      child: Row(
                        children: [
                          Align(
                              alignment:
                              Alignment.centerLeft,
                              child: Image.asset(
                                  'assets/a.png.png')),
                          const SizedBox(width: 5,),
                          Expanded(
                            child: Align(
                              alignment:
                              Alignment.centerLeft,
                              child: Text(
                                widget.tripModel.userName,
                                style: GoogleFonts.poppins(
                                    fontSize: 12.sp),
                              ),
                            ),
                          ),
                          Align(
                            alignment:
                            Alignment.centerLeft,
                            child: Text(
                              '${widget.tripModel.weight} KG',
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Bidding',
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      controller: _biddingController,
                      hintText: 'Enter amount',
                    ),
                  ],
                ),
              ),
              MyTextField(
                controller: _messageController,
                hintText: 'Enter your message here',
              ),
              MyButton2(
                onTap: (){
                  Navigator.pop(context);

                  User? user = FirebaseAuth.instance.currentUser;

                  FirebaseFirestore.instance
                      .collection('Requests')
                      .doc(widget.tripModel.userId)
                      .collection('Bids')
                      .add({
                    'departureCity': widget.tripModel.departureCity,
                    'arrivalCity': widget.tripModel.arrivalCity,
                    'departureCountry': widget.tripModel.departureCountry,
                    'arrivalCountry': widget.tripModel.arrivalCountry,
                    'description': widget.tripModel.description,
                    'flightDate': widget.tripModel.flightDate,
                    'weight': widget.tripModel.weight,
                    'pricePerKg': widget.tripModel.pricePerKg,
                    'flightNo': widget.tripModel.flightNo,
                    'bidderUserId': user!.uid,
                    'bidderEmail': user.email,
                    'bidderUserName': user.displayName,
                    'amount': _biddingController.text,
                    'message': _messageController.text,
                    'status': 'Pending',
                  });

                  Fluttertoast.showToast(msg: 'Bid Successfully');
                },
                text: 'Bid Now',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
