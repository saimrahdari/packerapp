import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/Screens/Orders/add_order.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Models/message_model.dart';
import '../../Services/constants.dart';

class Chat extends StatefulWidget {
  final String otherUserId;
  final bool isFromHome;
  final Function? setBidder;

  const Chat(
      {Key? key,
      required this.otherUserId,
      required this.isFromHome,
      this.setBidder})
      : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final User? user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String otherUserName = '';
  bool iAmBidder = false;
  Map<String, dynamic> request = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<String>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(widget.otherUserId)
                        .snapshots()
                        .map((event) => event.data()!['username'].toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.toString(),
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      } else {
                        return const Text('');
                      }
                    }),
                // Text(
                //   'En ligne',
                //   style: GoogleFonts.roboto(
                //     color: const Color(0xffA7AEC1),
                //     fontSize: 14.sp,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
              ],
            ),
          ],
        ),
        actions: [
          const Icon(
            Icons.more_horiz,
            color: Colors.black,
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          StreamBuilder<List<MessageModel2>>(
              stream: FirebaseFirestore.instance
                  .collection('Chats')
                  .doc(getChatId(
                      userId1: user!.uid, userId2: widget.otherUserId))
                  .snapshots()
                  .map((event) {
                if (event.data() != null) {
                  return (event.data()!['messages'] as List)
                      .map((e) => MessageModel2(
                            senderId: e['senderId'],
                            message: e['message'],
                            timestamp: e['sentAt'],
                            offerModel: e['offer'] != null
                                ? OfferModel(
                                    title: e['offer']['title'],
                                    description: e['offer']['description'],
                                    amount: e['offer']['amount'],
                                    status: e['offer']['status'],
                                    delivery: e['offer']['delivery'],
                                  )
                                : null,
                          ))
                      .toList();
                } else {
                  return [];
                }
              }),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 75, right: 15, left: 15),
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          bool isMe =
                              snapshot.data![index].senderId == user!.uid;

                          if (snapshot.data![index].offerModel != null) {
                            return Align(
                              alignment: isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  if (isMe) ...[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              getFormattedTime(
                                                  timestamp: snapshot
                                                      .data![index].timestamp),
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              textScaleFactor: 0.8),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(isMe ? 'Me' : otherUserName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textScaleFactor: 0.8),
                                        ],
                                      ),
                                    ),
                                  ] else ...[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(isMe ? 'Me' : otherUserName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textScaleFactor: 0.8),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              getFormattedTime(
                                                  timestamp: snapshot
                                                      .data![index].timestamp),
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              textScaleFactor: 0.8),
                                        ],
                                      ),
                                    ),
                                  ],
                                  Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: isMe
                                          ? Colors.black
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12.r),
                                        bottomRight: Radius.circular(12.r),
                                        topLeft: isMe
                                            ? Radius.circular(12.r)
                                            : Radius.circular(0.r),
                                        topRight: isMe
                                            ? Radius.circular(0.r)
                                            : Radius.circular(12.r),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              snapshot.data![index].offerModel!
                                                  .title,
                                              style: TextStyle(
                                                  color: isMe
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Text(
                                                snapshot.data![index]
                                                    .offerModel!.description,
                                                style: TextStyle(
                                                    color: isMe
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Divider(
                                            color: isMe
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                    child: Text(
                                                  'Total price',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )),
                                                Text(
                                                  '\$ ${snapshot.data![index].offerModel!.amount}',
                                                  style: TextStyle(
                                                      color: isMe
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 15),
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                    child: Text(
                                                  'Deliver date',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )),
                                                Text(
                                                  snapshot.data![index]
                                                      .offerModel!.delivery,
                                                  style: TextStyle(
                                                      color: isMe
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (iAmBidder) ...[
                                            if (snapshot.data![index]
                                                    .offerModel!.status ==
                                                'Pending') ...[
                                              GestureDetector(
                                                onTap: () async {
                                                  // check if order already exists for these users
                                                  final order =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Orders')
                                                          .where(
                                                              'bidderUserId',
                                                              isEqualTo:
                                                                  user!.uid)
                                                          .where('userId',
                                                              isEqualTo: widget
                                                                  .otherUserId)
                                                          .get();

                                                  if (order.docs.isEmpty) {
                                                    // create order
                                                    final String amount =
                                                        snapshot.data![index]
                                                            .offerModel!.amount;

                                                    final list = snapshot.data!;
                                                    int listIndex =
                                                        list.indexOf(snapshot
                                                            .data![index]);

                                                    list[listIndex] =
                                                        MessageModel2(
                                                            senderId: snapshot
                                                                .data![index]
                                                                .senderId,
                                                            message: snapshot
                                                                .data![index]
                                                                .message,
                                                            timestamp: snapshot
                                                                .data![index]
                                                                .timestamp,
                                                            offerModel:
                                                                OfferModel(
                                                              title: snapshot
                                                                  .data![index]
                                                                  .offerModel!
                                                                  .title,
                                                              status:
                                                                  'Accepted',
                                                              description: snapshot
                                                                  .data![index]
                                                                  .offerModel!
                                                                  .description,
                                                              amount: snapshot
                                                                  .data![index]
                                                                  .offerModel!
                                                                  .amount,
                                                              delivery: snapshot
                                                                  .data![index]
                                                                  .offerModel!
                                                                  .delivery,
                                                            ));

                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Chats')
                                                        .doc(getChatId(
                                                            userId1: user!.uid,
                                                            userId2: widget
                                                                .otherUserId))
                                                        .update({
                                                      'messages': [],
                                                    });

                                                    FirebaseFirestore.instance
                                                        .collection('Chats')
                                                        .doc(getChatId(
                                                            userId1: user!.uid,
                                                            userId2: widget
                                                                .otherUserId))
                                                        .update({
                                                      'messages':
                                                          FieldValue.arrayUnion(
                                                              list
                                                                  .map((e) => {
                                                                        'senderId':
                                                                            e.senderId,
                                                                        'message':
                                                                            e.message,
                                                                        'sentAt':
                                                                            e.timestamp,
                                                                        'offer': e.offerModel !=
                                                                                null
                                                                            ? {
                                                                                'title': e.offerModel!.title,
                                                                                'description': e.offerModel!.description,
                                                                                'amount': e.offerModel!.amount,
                                                                                'status': e.offerModel!.status,
                                                                                'delivery': e.offerModel!.delivery,
                                                                              }
                                                                            : null
                                                                      })
                                                                  .toList()),
                                                    });

                                                    FirebaseFirestore.instance
                                                        .collection('Orders')
                                                        .add({
                                                      'id': getChatId(
                                                          userId1: user!.uid,
                                                          userId2: widget
                                                              .otherUserId),
                                                      'delivery': snapshot
                                                          .data![index]
                                                          .offerModel!
                                                          .delivery,
                                                      'userId':
                                                          widget.otherUserId,
                                                      'email':
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Users')
                                                              .doc(widget
                                                                  .otherUserId)
                                                              .get()
                                                              .then((value) =>
                                                                  value.data()![
                                                                      'email']),
                                                      'userName':
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Users')
                                                              .doc(widget
                                                                  .otherUserId)
                                                              .get()
                                                              .then((value) =>
                                                                  value.data()![
                                                                      'username']),
                                                      'amount': amount,
                                                      'departureCity': request[
                                                          'departureCity'],
                                                      'arrivalCity': request[
                                                          'arrivalCity'],
                                                      'departureCountry': request[
                                                          'departureCountry'],
                                                      'arrivalCountry': request[
                                                          'arrivalCountry'],
                                                      'bidderEmail': request[
                                                          'bidderEmail'],
                                                      'bidderUserId': request[
                                                          'bidderUserId'],
                                                      'bidderUserName': request[
                                                          'bidderUserName'],
                                                      'description': request[
                                                          'description'],
                                                      'flightDate':
                                                          request['flightDate'],
                                                      'message':
                                                          request['message'],
                                                      'status':
                                                          request['status'],
                                                      'weight':
                                                          request['weight'],
                                                    });
                                                  } else {
                                                    // remove any duplicate orders from orders collection with same userId and bidderUserId
                                                    final orderDocs =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Orders')
                                                            .where(
                                                                'bidderUserId',
                                                                isEqualTo:
                                                                    user!.uid)
                                                            .where('userId',
                                                                isEqualTo: widget
                                                                    .otherUserId)
                                                            .get();

                                                    if (orderDocs
                                                        .docs.isNotEmpty) {
                                                      orderDocs.docs.forEach(
                                                          (element) async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Orders')
                                                            .doc(element.id)
                                                            .delete();
                                                      });
                                                    }

                                                    // add new order to orders collection
                                                    final String amount =
                                                        snapshot.data![index]
                                                            .offerModel!.amount;

                                                    final list = snapshot.data!;
                                                    int listIndex =
                                                        list.indexOf(snapshot
                                                            .data![index]);

                                                    list[listIndex] =
                                                        MessageModel2(
                                                            senderId: snapshot
                                                                .data![index]
                                                                .senderId,
                                                            message: snapshot
                                                                .data![index]
                                                                .message,
                                                            timestamp: snapshot
                                                                .data![index]
                                                                .timestamp,
                                                            offerModel:
                                                                OfferModel(
                                                              title: snapshot
                                                                  .data![index]
                                                                  .offerModel!
                                                                  .title,
                                                              status:
                                                                  'Accepted',
                                                              description: snapshot
                                                                  .data![index]
                                                                  .offerModel!
                                                                  .description,
                                                              amount: snapshot
                                                                  .data![index]
                                                                  .offerModel!
                                                                  .amount,
                                                              delivery: snapshot
                                                                  .data![index]
                                                                  .offerModel!
                                                                  .delivery,
                                                            ));

                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Chats')
                                                        .doc(getChatId(
                                                            userId1: user!.uid,
                                                            userId2: widget
                                                                .otherUserId))
                                                        .update({
                                                      'messages': [],
                                                    });

                                                    FirebaseFirestore.instance
                                                        .collection('Chats')
                                                        .doc(getChatId(
                                                            userId1: user!.uid,
                                                            userId2: widget
                                                                .otherUserId))
                                                        .update({
                                                      'messages':
                                                          FieldValue.arrayUnion(
                                                              list
                                                                  .map((e) => {
                                                                        'senderId':
                                                                            e.senderId,
                                                                        'message':
                                                                            e.message,
                                                                        'sentAt':
                                                                            e.timestamp,
                                                                        'offer': e.offerModel !=
                                                                                null
                                                                            ? {
                                                                                'title': e.offerModel!.title,
                                                                                'description': e.offerModel!.description,
                                                                                'amount': e.offerModel!.amount,
                                                                                'status': e.offerModel!.status,
                                                                                'delivery': e.offerModel!.delivery,
                                                                              }
                                                                            : null
                                                                      })
                                                                  .toList()),
                                                    });

                                                    FirebaseFirestore.instance
                                                        .collection('Orders')
                                                        .add({
                                                      'id': getChatId(
                                                          userId1: user!.uid,
                                                          userId2: widget
                                                              .otherUserId),
                                                      'delivery': snapshot
                                                          .data![index]
                                                          .offerModel!
                                                          .delivery,
                                                      'userId':
                                                          widget.otherUserId,
                                                      'email':
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Users')
                                                              .doc(widget
                                                                  .otherUserId)
                                                              .get()
                                                              .then((value) =>
                                                                  value.data()![
                                                                      'email']),
                                                      'userName':
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Users')
                                                              .doc(widget
                                                                  .otherUserId)
                                                              .get()
                                                              .then((value) =>
                                                                  value.data()![
                                                                      'username']),
                                                      'amount': amount,
                                                      'departureCity': request[
                                                          'departureCity'],
                                                      'arrivalCity': request[
                                                          'arrivalCity'],
                                                      'departureCountry': request[
                                                          'departureCountry'],
                                                      'arrivalCountry': request[
                                                          'arrivalCountry'],
                                                      'bidderEmail': request[
                                                          'bidderEmail'],
                                                      'bidderUserId': request[
                                                          'bidderUserId'],
                                                      'bidderUserName': request[
                                                          'bidderUserName'],
                                                      'description': request[
                                                          'description'],
                                                      'flightDate':
                                                          request['flightDate'],
                                                      'message':
                                                          request['message'],
                                                      'status':
                                                          request['status'],
                                                      'weight':
                                                          request['weight'],
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 2)),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15),
                                                    child: Center(
                                                        child: Text(
                                                            'Accept Offer',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ))),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox.square(
                                                dimension: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  final list = snapshot.data!;
                                                  int listIndex = list.indexOf(
                                                      snapshot.data![index]);

                                                  list[listIndex] =
                                                      MessageModel2(
                                                          senderId: snapshot
                                                              .data![index]
                                                              .senderId,
                                                          message: snapshot
                                                              .data![index]
                                                              .message,
                                                          timestamp: snapshot
                                                              .data![index]
                                                              .timestamp,
                                                          offerModel:
                                                              OfferModel(
                                                            title: snapshot
                                                                .data![index]
                                                                .offerModel!
                                                                .title,
                                                            status: 'Declined',
                                                            description: snapshot
                                                                .data![index]
                                                                .offerModel!
                                                                .description,
                                                            amount: snapshot
                                                                .data![index]
                                                                .offerModel!
                                                                .amount,
                                                            delivery: snapshot
                                                                .data![index]
                                                                .offerModel!
                                                                .delivery,
                                                          ));

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Chats')
                                                      .doc(getChatId(
                                                          userId1: user!.uid,
                                                          userId2: widget
                                                              .otherUserId))
                                                      .update({
                                                    'messages': [],
                                                  });

                                                  FirebaseFirestore.instance
                                                      .collection('Chats')
                                                      .doc(getChatId(
                                                          userId1: user!.uid,
                                                          userId2: widget
                                                              .otherUserId))
                                                      .update({
                                                    'messages':
                                                        FieldValue.arrayUnion(
                                                            list
                                                                .map((e) => {
                                                                      'senderId':
                                                                          e.senderId,
                                                                      'message':
                                                                          e.message,
                                                                      'sentAt':
                                                                          e.timestamp,
                                                                      'offer': e.offerModel !=
                                                                              null
                                                                          ? {
                                                                              'title': e.offerModel!.title,
                                                                              'description': e.offerModel!.description,
                                                                              'amount': e.offerModel!.amount,
                                                                              'status': e.offerModel!.status
                                                                            }
                                                                          : null
                                                                    })
                                                                .toList()),
                                                  });
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 2)),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15),
                                                    child: Center(
                                                        child: Text(
                                                            'Withdraw Offer',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ))),
                                                  ),
                                                ),
                                              ),
                                            ] else if (snapshot.data![index]
                                                    .offerModel!.status ==
                                                'Accepted') ...[
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15),
                                                child: Center(
                                                    child: Text(
                                                        'Offer Accepted',
                                                        textScaleFactor: 1.2,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                              ),
                                            ] else if (snapshot.data![index]
                                                    .offerModel!.status ==
                                                'Declined') ...[
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15),
                                                child: Center(
                                                    child: Text(
                                                        'Offer Declined',
                                                        textScaleFactor: 1.2,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                              ),
                                            ],
                                          ]
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Text(
                                  //   '5:22 ',
                                  //   style: GoogleFonts.roboto(
                                  //     color: const Color(0xffA7A9B7),
                                  //     fontSize: 12.sp,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10..h,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Align(
                              alignment: isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  if (isMe) ...[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              getFormattedTime(
                                                  timestamp: snapshot
                                                      .data![index].timestamp),
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              textScaleFactor: 0.8),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(isMe ? 'Me' : otherUserName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textScaleFactor: 0.8),
                                        ],
                                      ),
                                    ),
                                  ] else ...[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(isMe ? 'Me' : otherUserName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textScaleFactor: 0.8),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              getFormattedTime(
                                                  timestamp: snapshot
                                                      .data![index].timestamp),
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              textScaleFactor: 0.8),
                                        ],
                                      ),
                                    ),
                                  ],
                                  Container(
                                    decoration: BoxDecoration(
                                      color: isMe
                                          ? Colors.black
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12.r),
                                        bottomRight: Radius.circular(12.r),
                                        topLeft: isMe
                                            ? Radius.circular(12.r)
                                            : Radius.circular(0.r),
                                        topRight: isMe
                                            ? Radius.circular(0.r)
                                            : Radius.circular(12.r),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        snapshot.data![index].message,
                                        style: GoogleFonts.roboto(
                                            color: isMe
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                  // Text(
                                  //   '5:22 ',
                                  //   style: GoogleFonts.roboto(
                                  //     color: const Color(0xffA7A9B7),
                                  //     fontSize: 12.sp,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10..h,
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('No Messages'),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: TextFormField(
                  controller: _controller,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: !iAmBidder
                        ? IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AddOrder(
                                            isFromHome: widget.isFromHome,
                                            setBidder: widget.setBidder,
                                            otherUserId: widget.otherUserId,
                                          )));
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ))
                        : null,
                    // prefixIcon: IconButton(
                    //     onPressed: () {
                    //       Navigator.push(context,
                    //           MaterialPageRoute(builder: (_) => AddOrder(otherUserId: widget.otherUserId,)));
                    //     },
                    //     icon: const Icon(
                    //       Icons.add,
                    //       color: Colors.white,
                    //     )),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          if (_controller.text.isNotEmpty) {
                            if (widget.isFromHome) {
                              widget.setBidder!();
                            }

                            FirebaseFirestore.instance
                                .collection('Chats')
                                .doc(getChatId(
                                    userId1: user!.uid,
                                    userId2: widget.otherUserId))
                                .set({
                              'conversationId': getChatId(
                                  userId1: user!.uid,
                                  userId2: widget.otherUserId),
                              'user1': user!.uid,
                              'user1Name': await FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(user!.uid)
                                  .get()
                                  .then((value) => value.data()!['username']),
                              'user2': widget.otherUserId,
                              'user2Name': await FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(widget.otherUserId)
                                  .get()
                                  .then((value) => value.data()!['username']),
                              'messages': FieldValue.arrayUnion([
                                {
                                  'senderId': user!.uid,
                                  'message': _controller.text,
                                  'sentAt': Timestamp.now()
                                }
                              ]),
                            }, SetOptions(merge: true));

                            Future.delayed(
                                const Duration(
                                  milliseconds: 150,
                                ), () {
                              _scrollController.position.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn,
                              );
                            });

                            _controller.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        )),
                    hintText: 'Type message here',
                    hintStyle: const TextStyle(color: Colors.white),
                    fillColor: Colors.black,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getSomeData() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.otherUserId)
        .get()
        .then((value) {
      otherUserName = value.data()!['username'];
    });

    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(getChatId(userId1: user!.uid, userId2: widget.otherUserId))
        .get()
        .then((value) {
      if (value.data() != null) {
        print('bidder: ${value.data()!['bidder']}');
      }
      if (user!.uid == value.data()!['bidder']) {
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
        .doc(iAmBidder ? widget.otherUserId : user!.uid)
        .collection('Bids')
        .where('bidderUserId',
            isEqualTo: iAmBidder ? user!.uid : widget.otherUserId)
        .get()
        .then((value) => value.docs.map((e) => e.data()).first);

    setState(() {
      request = temp_request;
    });
  }
}
