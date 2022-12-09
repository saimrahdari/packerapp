import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/Models/message_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Services/constants.dart';
import '../Authentication/Login_page.dart';
import '../DashboardScreen/request.dart';
import '../Orders/my_orders.dart';
import '../ProfileScreen/my_details.dart'; //import http

class PaymentScreen extends StatefulWidget {
  String amount;
  String senderId;
  String receiverId;
  AsyncSnapshot<List<MessageModel2>> snapshot;
  int index;
  String userId1;
  String userId2;

  PaymentScreen(
      {Key? key,
      required this.amount,
      required this.senderId,
      required this.receiverId,
      required this.snapshot,
      required this.userId1,
      required this.userId2,
      required this.index})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;
  bool paymentSuccess = false;
  Map<String, dynamic> request = {};
  bool iAmBidder = false;
  Future<String>? orderRef;
  bool enabled = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        child: SafeArea(
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_sharp),
                      iconSize: 22.sp,
                    ),
                  )),
                  Expanded(
                    flex: 7,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Make Payment',
                            style: GoogleFonts.poppins(fontSize: 18.sp),
                          ),
                          Text(
                            'Payment is due to mark order complete',
                            style: GoogleFonts.poppins(
                                fontSize: 12.sp, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    paymentSuccess
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 25,
                          )
                        : const Icon(
                            Icons.credit_card,
                            color: Colors.grey,
                            size: 25,
                          ),
                    paymentSuccess
                        ? Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Go Back'),
                            ),
                          )
                        : TextButton(
                            child: const Text('Make Payment'),
                            onPressed: () async {
                              try {
                                await makePayment(
                                  widget.amount,
                                ).then((value) async {
                                  // check if order already exists for these users
                                  final order = await FirebaseFirestore.instance
                                      .collection('Orders')
                                      .where('bidderUserId',
                                          isEqualTo: widget.userId1)
                                      .where('userId',
                                          isEqualTo: widget.userId2)
                                      .get();

                                  if (order.docs.isEmpty) {
                                    // create order
                                    final String amount = widget.snapshot
                                        .data![widget.index].offerModel!.amount;

                                    final list = widget.snapshot.data!;
                                    int listIndex = list.indexOf(
                                        widget.snapshot.data![widget.index]);

                                    list[listIndex] = MessageModel2(
                                        senderId: widget.snapshot
                                            .data![widget.index].senderId,
                                        message: widget.snapshot
                                            .data![widget.index].message,
                                        timestamp: widget.snapshot
                                            .data![widget.index].timestamp,
                                        offerModel: OfferModel(
                                          title: widget
                                              .snapshot
                                              .data![widget.index]
                                              .offerModel!
                                              .title,
                                          status: 'Accepted',
                                          description: widget
                                              .snapshot
                                              .data![widget.index]
                                              .offerModel!
                                              .description,
                                          amount: widget
                                              .snapshot
                                              .data![widget.index]
                                              .offerModel!
                                              .amount,
                                          delivery: widget
                                              .snapshot
                                              .data![widget.index]
                                              .offerModel!
                                              .delivery,
                                        ));

                                    await FirebaseFirestore.instance
                                        .collection('Chats')
                                        .doc(getChatId(
                                            userId1: widget.userId1,
                                            userId2: widget.userId2))
                                        .update({
                                      'messages': [],
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('Chats')
                                        .doc(getChatId(
                                            userId1: widget.userId1,
                                            userId2: widget.userId2))
                                        .update({
                                      'messages': FieldValue.arrayUnion(list
                                          .map((e) => {
                                                'senderId': e.senderId,
                                                'message': e.message,
                                                'sentAt': e.timestamp,
                                                'offer': e.offerModel != null
                                                    ? {
                                                        'title':
                                                            e.offerModel!.title,
                                                        'description': e
                                                            .offerModel!
                                                            .description,
                                                        'amount': e
                                                            .offerModel!.amount,
                                                        'status': e
                                                            .offerModel!.status,
                                                        'delivery': e
                                                            .offerModel!
                                                            .delivery,
                                                      }
                                                    : null
                                              })
                                          .toList()),
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('Orders')
                                        .add({
                                      'id': getChatId(
                                          userId1: widget.userId1,
                                          userId2: widget.userId2),
                                      'delivery': widget
                                          .snapshot
                                          .data![widget.index]
                                          .offerModel!
                                          .delivery,
                                      'userId': widget.userId2,
                                      'email': await FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(widget.userId2)
                                          .get()
                                          .then((value) =>
                                              value.data()!['email']),
                                      'userName': await FirebaseFirestore
                                          .instance
                                          .collection('Users')
                                          .doc(widget.userId2)
                                          .get()
                                          .then((value) =>
                                              value.data()!['username']),
                                      'amount': amount,
                                      'departureCity': request['departureCity'],
                                      'arrivalCity': request['arrivalCity'],
                                      'departureCountry':
                                          request['departureCountry'],
                                      'arrivalCountry':
                                          request['arrivalCountry'],
                                      'bidderEmail': request['bidderEmail'],
                                      'bidderUserId': request['bidderUserId'],
                                      'bidderUserName':
                                          request['bidderUserName'],
                                      'description': request['description'],
                                      'flightDate': request['flightDate'],
                                      'message': request['message'],
                                      'status': request['status'],
                                      'weight': request['weight'],
                                    });
                                  } else {
                                    // remove any duplicate orders from orders collection with same userId and bidderUserId
                                    final orderDocs = await FirebaseFirestore
                                        .instance
                                        .collection('Orders')
                                        .where('bidderUserId',
                                            isEqualTo: widget.userId1)
                                        .where('userId',
                                            isEqualTo: widget.userId2)
                                        .get();

                                    if (orderDocs.docs.isNotEmpty) {
                                      orderDocs.docs.forEach((element) async {
                                        await FirebaseFirestore.instance
                                            .collection('Orders')
                                            .doc(element.id)
                                            .delete();
                                      });
                                    }

                                    // add new order to orders collection
                                    final String amount = widget.snapshot
                                        .data![widget.index].offerModel!.amount;

                                    final list = widget.snapshot.data!;
                                    int listIndex = list.indexOf(
                                        widget.snapshot.data![widget.index]);

                                    list[listIndex] = MessageModel2(
                                        senderId: widget.snapshot
                                            .data![widget.index].senderId,
                                        message: widget.snapshot
                                            .data![widget.index].message,
                                        timestamp: widget.snapshot
                                            .data![widget.index].timestamp,
                                        offerModel: OfferModel(
                                          title: widget
                                              .snapshot
                                              .data![widget.index]
                                              .offerModel!
                                              .title,
                                          status: 'Accepted',
                                          description: widget
                                              .snapshot
                                              .data![widget.index]
                                              .offerModel!
                                              .description,
                                          amount: widget
                                              .snapshot
                                              .data![widget.index]
                                              .offerModel!
                                              .amount,
                                          delivery: widget
                                              .snapshot
                                              .data![widget.index]
                                              .offerModel!
                                              .delivery,
                                        ));

                                    await FirebaseFirestore.instance
                                        .collection('Chats')
                                        .doc(getChatId(
                                            userId1: widget.userId1,
                                            userId2: widget.userId2))
                                        .update({
                                      'messages': [],
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('Chats')
                                        .doc(getChatId(
                                            userId1: widget.userId1,
                                            userId2: widget.userId2))
                                        .update({
                                      'messages': FieldValue.arrayUnion(list
                                          .map((e) => {
                                                'senderId': e.senderId,
                                                'message': e.message,
                                                'sentAt': e.timestamp,
                                                'offer': e.offerModel != null
                                                    ? {
                                                        'title':
                                                            e.offerModel!.title,
                                                        'description': e
                                                            .offerModel!
                                                            .description,
                                                        'amount': e
                                                            .offerModel!.amount,
                                                        'status': e
                                                            .offerModel!.status,
                                                        'delivery': e
                                                            .offerModel!
                                                            .delivery,
                                                      }
                                                    : null
                                              })
                                          .toList()),
                                    });

                                    orderRef = FirebaseFirestore.instance
                                        .collection('Orders')
                                        .add({
                                      'id': getChatId(
                                          userId1: widget.userId1,
                                          userId2: widget.userId2),
                                      'delivery': widget
                                          .snapshot
                                          .data![widget.index]
                                          .offerModel!
                                          .delivery,
                                      'userId': widget.userId2,
                                      'email': await FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(widget.userId2)
                                          .get()
                                          .then((value) =>
                                              value.data()!['email']),
                                      'userName': await FirebaseFirestore
                                          .instance
                                          .collection('Users')
                                          .doc(widget.userId2)
                                          .get()
                                          .then((value) =>
                                              value.data()!['username']),
                                      'amount': amount,
                                      'departureCity': request['departureCity'],
                                      'arrivalCity': request['arrivalCity'],
                                      'departureCountry':
                                          request['departureCountry'],
                                      'arrivalCountry':
                                          request['arrivalCountry'],
                                      'bidderEmail': request['bidderEmail'],
                                      'bidderUserId': request['bidderUserId'],
                                      'bidderUserName':
                                          request['bidderUserName'],
                                      'description': request['description'],
                                      'flightDate': request['flightDate'],
                                      'message': request['message'],
                                      'status': request['status'],
                                      'weight': request['weight'],
                                    }).then((value) => value.id);

                                    await FirebaseFirestore.instance
                                        .collection('Payments')
                                        .add({
                                      'orderId': await orderRef,
                                      'senderId': widget.senderId,
                                      'recieverId': widget.receiverId,
                                      'amount': widget.amount,
                                      'status': 'Accepted',
                                    }).then((value) => Fluttertoast.showToast(
                                            msg: 'Payment Successful'));
                                  }
                                });
                              } catch (e) {
                                print(
                                    "==========================================");
                                print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
                                // delete the order from the database and also reset the chat status
                                FirebaseFirestore.instance
                                    .collection('Orders')
                                    .doc(await orderRef)
                                    .delete();

                                final String amount = widget.snapshot
                                    .data![widget.index].offerModel!.amount;

                                final list = widget.snapshot.data!;
                                int listIndex = list.indexOf(
                                    widget.snapshot.data![widget.index]);

                                list[listIndex] = MessageModel2(
                                    senderId: widget
                                        .snapshot.data![widget.index].senderId,
                                    message: widget
                                        .snapshot.data![widget.index].message,
                                    timestamp: widget
                                        .snapshot.data![widget.index].timestamp,
                                    offerModel: OfferModel(
                                      title: widget.snapshot.data![widget.index]
                                          .offerModel!.title,
                                      status: 'Pending',
                                      description: widget
                                          .snapshot
                                          .data![widget.index]
                                          .offerModel!
                                          .description,
                                      amount: widget
                                          .snapshot
                                          .data![widget.index]
                                          .offerModel!
                                          .amount,
                                      delivery: widget
                                          .snapshot
                                          .data![widget.index]
                                          .offerModel!
                                          .delivery,
                                    ));

                                await FirebaseFirestore.instance
                                    .collection('Chats')
                                    .doc(getChatId(
                                        userId1: widget.userId1,
                                        userId2: widget.userId2))
                                    .update({
                                  'messages': [],
                                });

                                FirebaseFirestore.instance
                                    .collection('Chats')
                                    .doc(getChatId(
                                        userId1: widget.userId1,
                                        userId2: widget.userId2))
                                    .update({
                                  'messages': FieldValue.arrayUnion(list
                                      .map((e) => {
                                            'senderId': e.senderId,
                                            'message': e.message,
                                            'sentAt': e.timestamp,
                                            'offer': e.offerModel != null
                                                ? {
                                                    'title':
                                                        e.offerModel!.title,
                                                    'description': e.offerModel!
                                                        .description,
                                                    'amount':
                                                        e.offerModel!.amount,
                                                    'status':
                                                        e.offerModel!.status,
                                                    'delivery':
                                                        e.offerModel!.delivery,
                                                  }
                                                : null
                                          })
                                      .toList()),
                                }).then((value) => {
                                          Fluttertoast.showToast(
                                              msg: 'Payment Failed'),
                                        });
                              }
                            }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getSomeData() async {
    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(getChatId(userId1: widget.userId1, userId2: widget.userId2))
        .get()
        .then((value) {
      if (value.data() != null) {
        print('bidder: ${value.data()!['bidder']}');
      }
      if (widget.userId1 == value.data()!['bidder']) {
        setState(() {
          iAmBidder = true;
        });
      } else {
        setState(() {
          iAmBidder = false;
        });
      }
    });
    Map<String, dynamic> temp_request = await FirebaseFirestore.instance
        .collection('Requests')
        .doc(iAmBidder ? widget.userId2 : widget.userId1)
        .collection('Bids')
        .where('bidderUserId',
            isEqualTo: iAmBidder ? widget.userId1 : widget.userId2)
        .get()
        .then((value) => value.docs.map((e) => e.data()).first);

    setState(() {
      request = temp_request;
    });
  }

  String calculateAmount(String amount) {
    return amount;
  }

  Future<void> makePayment(String paymentValue) async {
    try {
      // add two zeros to the end of the amount
      // because the API requires it to be in kobo
      dynamic amount = int.parse(paymentValue) * 100;
      amount = amount.toString();

      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(amount, 'USD');

      // create some billingdetails
      final billingDetails = BillingDetails(
        name: 'Flutter Stripe',
        email: 'email@stripe.com',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      ); // mocked data for tests

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  billingDetails: billingDetails,
                  merchantDisplayName: 'Fyp'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } on StripeException catch (err) {
      print("here1");
      throw err;
    } on Exception catch (err) {
      print("here2");
      rethrow;
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      print("here3");

      throw Exception(err.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      // Fluttertoast.showToast(msg: FirebaseAuth.instance.currentUser!.uid);
      await Stripe.instance.presentPaymentSheet().then((value) {
        // store in firebase users collection
        FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(
                {'balance': FieldValue.increment(int.parse(request['amount']))},
                SetOptions(merge: true)).then((value) {
          Fluttertoast.showToast(msg: 'Payment Successful');
        });

        //Clear paymentIntent variable after successful payment
        paymentIntent = null;
      });
      // if we use onError chaining here, vscode will complain that it caught an unhandled exception
      // even when handle it in the onError callback
    } on StripeException catch (e) {
      paymentIntent = null;
      print("here4");

      Fluttertoast.showToast(msg: '${e.error.code} ${e.error.message}');
      rethrow;
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
      print("here5");

      rethrow;
    }
  }
}
