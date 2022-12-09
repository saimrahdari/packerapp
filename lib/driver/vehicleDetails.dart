import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../My Widgets/my_text_field.dart';
import '../Screens/Orders/PlaceOrder.dart';
import '../Services/constants.dart';
import 'driverLogin.dart';
import 'legalDetails.dart';

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({Key? key}) : super(key: key);

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _vehicleYearController = TextEditingController();
  final TextEditingController _licensePlateController = TextEditingController();
  final TextEditingController _vehicleColorController = TextEditingController();
  var fcmToken;
  var vehicleType = [
    'SEDAN',
    'COUPE',
    'SPORTS CAR',
    'STATION WAGON',
    'HATCHBACK',
    'CONVERTIBLE',
    'SUV',
    'MINIVAN',
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      'LOGO',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 1.2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Image.asset(
                    'assets/process2.png',
                    width: 270.0,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Text(
                  'Personal and Vehicle Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 2,
                ),
                // const Padding(
                //   padding: EdgeInsets.only(top: 5, bottom: 50),
                //   child: Text(
                //     'Enter your details to proceed further',
                //     style: TextStyle(
                //       color: Colors.grey,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 30.0,
                ),
                MyTextField1(
                  prefixIcon: Image.asset(
                    'assets/car.png',
                    width: 70.0,
                    scale: 1.7,
                  ),
                  controller: _vehicleTypeController,
                  label: 'Vehicle Type',
                ),
                MyTextField1(
                  prefixIcon: Image.asset(
                    'assets/car.png',
                    width: 70.0,
                    scale: 1.7,
                  ),
                  controller: _vehicleModelController,
                  label: 'Vehicle Model',
                ),
                MyTextField1(
                  prefixIcon: Image.asset(
                    'assets/staring.png',
                    width: 70.0,
                    scale: 1.7,
                  ),
                  controller: _vehicleYearController,
                  label: 'Vehicle Year',
                ),
                MyTextField1(
                  prefixIcon: Image.asset(
                    'assets/plate.png',
                    width: 70.0,
                    scale: 1.7,
                  ),
                  controller: _licensePlateController,
                  label: 'License Plate',
                ),
                MyTextField1(
                  prefixIcon: Image.asset(
                    'assets/color.png',
                    width: 70.0,
                    scale: 1.7,
                  ),
                  controller: _vehicleColorController,
                  label: 'Car\'s Color',
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () async {
                    final String vehicleModel = _vehicleModelController.text;
                    final String vehicleColor = _vehicleColorController.text;
                    final String vehicleType = _vehicleTypeController.text;
                    final String vehicleYear = _vehicleYearController.text;
                    final String licensePlate = _licensePlateController.text;
                    var uid = FirebaseAuth.instance.currentUser!.uid;
                    FirebaseFirestore db = FirebaseFirestore.instance;
                    if (vehicleModel.isEmpty ||
                        vehicleYear.isEmpty ||
                        vehicleColor.isEmpty ||
                        vehicleType.isEmpty ||
                        licensePlate.isEmpty) {
                      displayToastMessage("Fill all information", context);
                    } else {
                      try {
                        await db
                            .collection("Driver")
                            .doc(uid)
                            .collection('vehicleDetails')
                            .doc()
                            .set({
                          "vehicleModel": vehicleModel,
                          "vehicleColor": vehicleColor,
                          "vehicleType": vehicleType,
                          "vehicleYear": vehicleYear,
                          "licensePlate": licensePlate
                        }).whenComplete(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LegalDetails()));
                        });
                      } catch (e) {
                        displayToastMessage("Error" + e.toString(), context);
                        print(e.toString());
                        print("error");
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Center(
                          child: Text('Next',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                ),
                const SizedBox.square(
                  dimension: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const DriverLogin()));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Center(
                          child: Text('Cancel',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                )
                // Center(
                //   child: TextButton(
                //       onPressed: () {},
                //       child: RichText(
                //         text: const TextSpan(
                //             style: TextStyle(color: Colors.black),
                //             children: [
                //               TextSpan(text: 'Already have an account? '),
                //               TextSpan(
                //                   text: 'Login',
                //                   style: TextStyle(fontWeight: FontWeight.bold))
                //             ]),
                //       )),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
