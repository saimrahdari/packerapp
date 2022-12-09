import 'package:flutter/material.dart';
import 'package:fyp/Chatting/components/constants.dart';
import 'package:fyp/Chatting/components/filled_outline_button.dart';
import 'package:fyp/Chatting/components/models/Chat.dart';
import 'package:fyp/Chatting/components/screens/messages/message_screen.dart';

import 'chat_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   padding: EdgeInsets.fromLTRB(
        //       kDefaultPadding, 1, kDefaultPadding, kDefaultPadding),
        //   // color: Color(0xff3E4685),
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 8.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         FillOutlineButton(press: () {}, text: "Recent Message"),
        //         SizedBox(width: kDefaultPadding),
        //         FillOutlineButton(
        //           press: () {},
        //           text: "Active",
        //           // isFilled: false,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagesScreen(otherUserId: ''),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
