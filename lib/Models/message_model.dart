import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String conversationId;
  final String user1;
  final String user2;
  final String senderId;
  final String lastMessage;
  final Timestamp timestamp;

  MessageModel(
      {required this.conversationId,
      required this.user1,
      required this.user2,
      required this.senderId,
      required this.lastMessage,
      required this.timestamp});
}

class MessageModel2 {
  final String senderId;
  final String message;
  final Timestamp timestamp;
  final OfferModel? offerModel;

  MessageModel2({required this.senderId, required this.message, required this.timestamp, this.offerModel});
}

class OfferModel {
  final String title;
  final String description;
  final String amount;
  final String status;
  final String delivery;

  OfferModel(
      {required this.title, required this.description, required this.amount, required this.status, required this.delivery});
}