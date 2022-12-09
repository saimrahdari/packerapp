import 'package:flutter/material.dart';
import 'package:fyp/Chatting/components/screens/chats/chats_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetails2 extends StatefulWidget {
  const OrderDetails2({Key? key}) : super(key: key);

  @override
  State<OrderDetails2> createState() => _OrderDetails2State();
}

class _OrderDetails2State extends State<OrderDetails2> {

  final TextEditingController _biddingController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3E4685),
        title: Text(
          "Order Details",
          style: GoogleFonts.lato(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Color(0xff3E4685),
                                size: 60,
                              ),
                              Text(
                                "Sender",
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Color(0xff3E4685),
                                size: 60,
                              ),
                              Text(
                                "Traveller",
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 19,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Pickup Location",
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text("City"),
                      const SizedBox(
                        height: 18,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Destination",
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text("City"),
                      const SizedBox(
                        height: 19,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "To Be Delivered",
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text("12-2-21 to 12-3-22"),
                      const SizedBox(
                        height: 19,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Description",
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text("Nothing"),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatsScreen()));
                            },
                            child: Text(
                              "Contact",
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white)),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff3E4685),
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
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
