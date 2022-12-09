import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/Orders/orderDetails.dart';
import 'package:fyp/main.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrders2 extends StatefulWidget {
  const MyOrders2({Key? key}) : super(key: key);

  @override
  State<MyOrders2> createState() => _MyOrders2State();
}

class _MyOrders2State extends State<MyOrders2> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> userdata = FirebaseFirestore.instance
        .collection('Users')
        .doc(currentFirebaseUser?.uid)
        .collection("OrderData")
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3E4685),
        title: Text(
          "Order Details",
          style: GoogleFonts.lato(
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userdata,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Orders Found."));
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => OrderDetails()));
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Departure",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  )),
                                ),
                                Text(
                                  "Arrival",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${data['to']}",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                                // Center(
                                //   child: Icon(
                                //     Icons.flight_takeoff,
                                //     size: 30,
                                //     color: Color(0xff3E4685),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 3,
                                // ),
                                Text(
                                  "${data['from']}",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${data['toDate']}",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  )),
                                ),
                                Text(
                                  "${data['fromDate']}",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Container(
                                height: 30,
                                width: 200,
                                color: Color(0xff3E4685),
                                child: Center(
                                  child: Text(
                                    "${data['weight']}KG Order Weight",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Raleway",
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]);
            }).toList(),
          );
        },
      ),
    );
  }
}
