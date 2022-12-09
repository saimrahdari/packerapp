import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/Services/constants.dart';
import 'package:intl/src/intl/date_format.dart';
import '../../My Widgets/my_text_field.dart';

class AddOrder extends StatefulWidget {
  final String otherUserId;
  final bool isFromHome;
  final Function? setBidder;

  const AddOrder({Key? key, required this.otherUserId, required this.isFromHome, this.setBidder}) : super(key: key);

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {

  final User? user = FirebaseAuth.instance.currentUser!;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _deliveryDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Order')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Offer title',style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.2),
              MyTextField(
                controller: _titleController,
              ),
              const SizedBox(height: 25),
              const Text('Describe your offer',style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.2),
              MyTextField(
                controller: _descriptionController,
                hintText: 'Enter your description',
                maxLines: 5,
              ),
              const SizedBox(height: 25),
              const Text('Choose rate',style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.2),
              MyTextField(
                controller: _rateController,
              ),
              const SizedBox(height: 25),
              const Text('Choose delivery date',style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.2),
              GestureDetector(
                onTap: () async {
                  DateTime? pickDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      );

                  if (pickDate != null) {
                    setState(() {
                      _deliveryDateController.text =
                          DateFormat('yyyy-MM-dd').format(pickDate);
                    });
                  }
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: MyTextField(
                    controller: _deliveryDateController,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () async {
                  if(_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty && _rateController.text.isNotEmpty && _deliveryDateController.text.isNotEmpty){
                    Navigator.pop(context);

                    if(widget.isFromHome){
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
                          'message': '',
                          'sentAt': Timestamp.now(),
                          'offer': {
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                            'amount': _rateController.text,
                            'status': 'Pending',
                            'delivery': _deliveryDateController.text,
                          }
                        }
                      ]),
                    }, SetOptions(merge: true));

                    Fluttertoast.showToast(msg: 'Plan Offered');
                  }else{
                    Fluttertoast.showToast(msg: 'All fields are required');
                  }
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2)
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: Center(child: Text('Create', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
