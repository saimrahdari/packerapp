import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/main.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTrips extends StatefulWidget {
  const MyTrips({Key? key}) : super(key: key);

  @override
  State<MyTrips> createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  @override
  Widget build(BuildContext context) {
    // CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    final Stream<QuerySnapshot> userdata = FirebaseFirestore.instance
        .collection('Users')
        .doc(currentFirebaseUser?.uid)
        .collection("My Trips")
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Trips',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: userdata,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                                      textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                  )),
                                ),
                                Text(
                                  "Arrival",
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                  )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${data['departure']}",
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
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
                                  "${data['arrival']}",
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${data['date']}",
                                    style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 200,
                                    color: const Color(0xff3E4685),
                                    child: Center(
                                      child: Text(
                                        "${data['weight']}KG Order Weight",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Raleway",
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // ListTile(
                  //   title: Text(data['email']),
                  //   subtitle: Text(data['username']),
                  // ),
                ]);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
