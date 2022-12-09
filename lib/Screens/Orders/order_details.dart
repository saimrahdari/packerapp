import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/My%20Widgets/my_button.dart';
import 'package:fyp/Screens/Orders/track_order.dart';
import 'package:fyp/Services/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Models/order_model.dart';
import '../../My Widgets/my_button_2.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;

  const OrderDetails({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  File? _imageFile;
  String imagePath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: StreamBuilder<OrderModel>(
          stream: FirebaseFirestore.instance
              .collection('Orders')
              .doc(widget.orderId)
              .snapshots()
              .map((event) => OrderModel(
                    bidRequestId: event.id,
                    id: event.data()!['id'],
                    userId: event.data()!['userId'],
                    email: event.data()!['email'],
                    userName: event.data()!['userName'],
                    departureCity: event.data()!['departureCity'],
                    arrivalCity: event.data()!['arrivalCity'],
                    arrivalCountry: event.data()!['arrivalCountry'],
                    departureCountry: event.data()!['departureCountry'],
                    deliveryProof: event.data()!['deliveryProof'],
                    description: event.data()!['description'],
                    delivery: event.data()!['delivery'],
                    flightDate: event.data()!['flightDate'],
                    weight: event.data()!['weight'],
                    bidderUserId: event.data()!['bidderUserId'],
                    bidderEmail: event.data()!['bidderEmail'],
                    bidderUserName: event.data()!['bidderUserName'],
                    amount: event.data()!['amount'],
                    status: event.data()!['status'] ?? 'Pending',
                    message: event.data()!['message'],
                  )),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: horizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text('Person Details',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5),
                              ),
                              if (snapshot.data!.status != 'Completed') ...[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => TrackOrder(
                                                  userId: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid ==
                                                          snapshot.data!.userId
                                                      ? snapshot
                                                          .data!.bidderUserId
                                                      : snapshot.data!.userId,
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black, width: 2)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 15,
                                      ),
                                      child: Center(
                                          child: Text('Track Order',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ),
                                )
                              ],
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Icon(Icons.person),
                                ),
                                Text(FirebaseAuth.instance.currentUser!.uid ==
                                        snapshot.data!.userId
                                    ? snapshot.data!.bidderUserName
                                    : snapshot.data!.userName)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Icon(Icons.email),
                                ),
                                Text(FirebaseAuth.instance.currentUser!.uid ==
                                        snapshot.data!.userId
                                    ? snapshot.data!.bidderEmail
                                    : snapshot.data!.email)
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 50, bottom: 10),
                            child: Text('Flight Details',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textScaleFactor: 1.5),
                          ),
                          // space
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Icon(Icons.monitor_weight_outlined),
                                ),
                                Text(snapshot.data!.weight.toString() + ' Kg')
                              ],
                            ),
                          ),
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
                                              '${snapshot.data!.departureCity}\n'),
                                      TextSpan(
                                        text: snapshot.data!.departureCountry,
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
                                    snapshot.data!.flightDate,
                                    style: GoogleFonts.poppins(fontSize: 12.sp),
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
                                              '${snapshot.data!.arrivalCity}\n'),
                                      TextSpan(
                                        text: snapshot.data!.arrivalCountry,
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
                                        child:
                                            Image.asset('assets/a.png.png'))),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      FirebaseAuth.instance.currentUser!.uid ==
                                              snapshot.data!.userId
                                          ? snapshot.data!.bidderUserName
                                          : snapshot.data!.userName,
                                      style:
                                          GoogleFonts.poppins(fontSize: 12.sp),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '\$ ${snapshot.data!.amount}',
                                      style:
                                          GoogleFonts.poppins(fontSize: 12.sp),
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
                              snapshot.data!.description,
                              style: GoogleFonts.poppins(fontSize: 12.sp),
                            ),
                          ),
                          if (snapshot.data!.status != 'Completed') ...[
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                top: 25,
                                right: 25,
                                left: 25,
                              ),
                              child: Text(
                                  daysBetween(
                                    from: snapshot.data!.flightDate,
                                    to: snapshot.data!.delivery,
                                  ).toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  textScaleFactor: 1.5),
                            ))
                          ],
                          if (snapshot.data!.bidderUserId ==
                              FirebaseAuth.instance.currentUser!.uid) ...[
                            if (snapshot.data!.status == 'Delivered') ...[
                              snapshot.data!.deliveryProof != ""
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 25),
                                      child: Container(
                                        height: 100.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data!.deliveryProof),
                                                fit: BoxFit.cover)),
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, bottom: 25),
                                child: GestureDetector(
                                  onTap: () async {
                                    Fluttertoast.showToast(
                                        msg: 'Order Completed');

                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(snapshot.data!.userId)
                                        .get()
                                        .then((value) {
                                      FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(snapshot.data!.userId)
                                          .update({
                                        'balance': value.data()!['balance'] -
                                            snapshot.data!.amount
                                      });
                                    });

                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(snapshot.data!.bidderUserId)
                                        .get()
                                        .then((value) {
                                      FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(snapshot.data!.bidderUserId)
                                          .update({
                                        'balance': value.data()!['balance'] +
                                            snapshot.data!.amount
                                      });
                                    });

                                    FirebaseFirestore.instance
                                        .collection('Payments')
                                        .where('orderId',
                                            isEqualTo: widget.orderId)
                                        .get()
                                        .then((value) {
                                      value.docs.forEach((element) {
                                        FirebaseFirestore.instance
                                            .collection('Payments')
                                            .doc(element.id)
                                            .update({'status': 'Completed'});
                                      });
                                    });

                                    FirebaseFirestore.instance
                                        .collection('Orders')
                                        .doc(snapshot.data!.bidRequestId)
                                        .update({'status': 'Completed'});
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black, width: 2)),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 25),
                                      child: Center(
                                          child: Text('Mark Completed',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ),
                                ),
                              ),
                            ] else if (snapshot.data!.status ==
                                'Completed') ...[
                              const Center(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 25),
                                child: Text('Order is complete',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5),
                              ))
                            ],
                          ] else ...[
                            if (snapshot.data!.status == 'Accepted') ...[
                              const Padding(
                                padding: EdgeInsets.only(top: 25, bottom: 10),
                                child: Text('Delivery Proof',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5),
                              ),
                              Container(
                                width: 177.w,
                                height: 58.h,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(20.0),
                                child: InkWell(
                                  onTap: () async {
                                    await getImage();
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/gallery.svg',
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Picture Attached',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, bottom: 25),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (_imageFile!.existsSync()) {
                                      final url = await uploadFile();
                                      FirebaseFirestore.instance
                                          .collection('Orders')
                                          .doc(widget.orderId)
                                          .update({
                                        'deliveryProof': url,
                                        'status': 'Delivered',
                                      });
                                      Fluttertoast.showToast(
                                          msg: 'Order Delivered');
                                      Navigator.pop(context);
                                      FirebaseFirestore.instance
                                          .collection('Orders')
                                          .doc(snapshot.data!.bidRequestId)
                                          .update({'status': 'Delivered'});
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              'Please attach proof of delivery');
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black, width: 2)),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 25),
                                      child: Center(
                                          child: Text('Mark Delivered',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ),
                                ),
                              ),
                            ] else if (snapshot.data!.status ==
                                'Completed') ...[
                              const Center(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 25),
                                child: Text('Order is complete',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5),
                              ))
                            ],
                          ],
                        ],
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Future<String> uploadFile() async {
    String imageUrl = "";

    if (_imageFile != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference fileStorageRef =
          storage.ref("delivery_proofs").child(widget.orderId);
      await fileStorageRef.putFile(_imageFile!);
      imageUrl = await fileStorageRef.getDownloadURL();
      return imageUrl;
    }
    return imageUrl;
  }

  Future getImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path.toString());
      });
    }
  }

  String daysBetween({required String from, required String to}) {
    DateTime date1 = DateTime(
      int.parse(from.split('-')[0]),
      int.parse(from.split('-')[1]),
      int.parse(from.split('-')[2]),
      DateTime.now().hour,
      DateTime.now().minute,
    );
    DateTime date2 = DateTime(
      int.parse(to.split('-')[0]),
      int.parse(to.split('-')[1]),
      int.parse(to.split('-')[2]),
    );
    return '${(date2.difference(date1).inHours / 24).round()} days ${(date2.difference(date1).inHours % 24).round()} hours and ${(date2.difference(date1).inMinutes % 60).round()} minutes left till delivery';
  }
}
