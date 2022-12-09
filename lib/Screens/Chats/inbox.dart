import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/Screens/Chats/chat.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Models/message_model.dart';
import '../../../../Services/constants.dart';
import '../../Chatting/components/screens/messages/message_screen.dart';

class Inbox extends StatefulWidget {
  const Inbox({Key? key}) : super(key: key);

  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {

  final User? user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _controller = TextEditingController();

  bool showSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats', style: TextStyle(color: Colors.black,)),
        actions: [IconButton(onPressed: (){
          setState(() {
            showSearch = !showSearch;
          });
        }, icon: const Icon(Icons.search, color: Colors.black,))],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if(showSearch)...[
                Padding(
                  padding:
                  EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                  child: TextField(
                    controller: _controller,
                    onChanged: (v){
                      setState(() {

                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      prefixIcon: const Icon(Icons.search),
                      hintStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: const Color(0xffA7A9B7),
                      ),
                      fillColor: const Color(0xffF2F2F2),
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color(0xffF3F3F3), width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color(0xffF3F3F3), width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color(0xffF3F3F3), width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      hintText: 'Rechercher messages',
                    ),
                  ),
                ),
              ],
              SizedBox(height: 40.h),
              StreamBuilder<List<MessageModel>>(
                  stream: _controller.text.isEmpty ? FirebaseFirestore.instance
                      .collection('Chats')
                      .snapshots()
                      .map((event) => event.docs
                      .where((element) => element
                      .data()['conversationId']
                      .toString()
                      .contains(user!.uid.hashCode
                      .toString()))
                      .map((e) => MessageModel(
                    conversationId: e.data()['conversationId'],
                    user1: e.data()['user1'],
                    user2: e.data()['user2'],
                    senderId: (e.data()['messages'] as List)
                        .first['senderId'],
                    lastMessage: (e.data()['messages'] as List)
                        .first['message'],
                    timestamp: (e.data()['messages'] as List)
                        .first['sentAt'],
                  ))
                      .toList()) : FirebaseFirestore.instance
                      .collection('Chats')
                      .snapshots()
                      .map((event) => event.docs
                      .where((element) => element
                      .data()['conversationId']
                      .toString()
                      .contains(user!.uid.hashCode
                      .toString()))
                      .where((element) => element.data()['user1'] == user!.uid ? element.data()['user2Name'].toString().contains(_controller.text) : element.data()['user1Name'].toString().contains(_controller.text))
                      .map((e) => MessageModel(
                    conversationId: e.data()['conversationId'],
                    user1: e.data()['user1'],
                    user2: e.data()['user2'],
                    senderId: (e.data()['messages'] as List)
                        .first['senderId'],
                    lastMessage: (e.data()['messages'] as List)
                        .first['message'],
                    timestamp: (e.data()['messages'] as List)
                        .first['sentAt'],
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
                          itemCount: snapshot.data!.length,
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            String iAm = snapshot.data![index].user1 ==
                                user!.uid
                                ? 'user1'
                                : 'user2';

                            return InkWell(
                              onTap: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Chat(
                                              isFromHome: false,
                                              otherUserId: iAm == 'user1' ?  snapshot
                                                  .data![index].user2: snapshot
                                                  .data![index].user1,
                                            )));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 20.w, right: 20.w),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                if (iAm == 'user1') ...[
                                                  StreamBuilder<String>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                          'Users')
                                                          .doc(snapshot
                                                          .data![index]
                                                          .user2)
                                                          .snapshots()
                                                          .map((event) => event
                                                          .data()![
                                                      'username']
                                                          .toString()),
                                                      builder: (context,
                                                          snapshot) {
                                                        return Text(
                                                          snapshot.data
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .roboto(
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                            fontSize: 14.sp,
                                                            color: const Color(
                                                                0xff191D31),
                                                          ),
                                                        );
                                                      }),
                                                ] else ...[
                                                  StreamBuilder<String>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                          'Users')
                                                          .doc(snapshot
                                                          .data![index]
                                                          .user1)
                                                          .snapshots()
                                                          .map((event) => event
                                                          .data()![
                                                      'username']
                                                          .toString()),
                                                      builder: (context,
                                                          snapshot) {
                                                        return Text(
                                                          snapshot.data
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .roboto(
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                            fontSize: 14.sp,
                                                            color: const Color(
                                                                0xff191D31),
                                                          ),
                                                        );
                                                      }),
                                                ],
                                                Text(
                                                  snapshot.data![index]
                                                      .lastMessage,
                                                  style: GoogleFonts.roboto(
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 14.sp,
                                                    color: const Color(
                                                        0xffA7A9B7),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            if(snapshot.data![index].timestamp.toDate() == DateTime.now())...[
                                              Text(
                                                getFormattedDate(timestamp: snapshot.data![index].timestamp),
                                                style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.sp,
                                                  color: const Color(0xffA7A9B7),
                                                ),
                                              ),
                                            ],
                                            Text(
                                              getFormattedTime(timestamp: snapshot.data![index].timestamp),
                                              style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                                color: const Color(0xffA7A9B7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 20.h, left: 20.w, right: 20.w),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No Messages'),
                        );
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
