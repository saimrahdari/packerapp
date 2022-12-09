import 'package:flutter/material.dart';
import 'package:fyp/Chatting/components/constants.dart';
import 'package:fyp/Chatting/components/models/ChatMessage.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(),
          // child: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          //   child: ListView.builder(
          //     itemCount: demeChatMessages.length,
          //     itemBuilder: (context, index) =>
          //         Message(message: demeChatMessages[index]),
          //   ),
          // ),
        ),
        ChatInputField(),
      ],
    );
  }
}
