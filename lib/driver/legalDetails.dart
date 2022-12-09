import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../My Widgets/my_text_field.dart';
import '../Screens/Orders/PlaceOrder.dart';
import '../Services/constants.dart';
import 'documentScreen.dart';
import 'driverLogin.dart';

class LegalDetails extends StatefulWidget {
  const LegalDetails({Key? key}) : super(key: key);

  @override
  State<LegalDetails> createState() => _LegalDetailsState();
}

class _LegalDetailsState extends State<LegalDetails> {
  final TextEditingController _idCardController = TextEditingController();
  final TextEditingController _vehicleLicenseController =
      TextEditingController();
  // var fcmToken;
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
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
                    'assets/process3.png',
                    width: 270.0,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Text(
                  'Legal Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 2,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 50),
                  child: Text(
                    'Your national id and license details will be kept private',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 30.0,
                // ),
                MyTextField1(
                  textInputType: TextInputType.number,
                  prefixIcon: Image.asset(
                    'assets/idCard.png',
                    width: 70.0,
                    scale: 1.7,
                  ),
                  controller: _idCardController,
                  label: 'Nation ID Card No',
                ),
                MyTextField1(
                  textInputType: TextInputType.number,
                  prefixIcon: Image.asset(
                    'assets/license.png',
                    width: 70.0,
                    scale: 1.7,
                  ),
                  controller: _vehicleLicenseController,
                  label: 'Driver\'s License',
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () async {
                    final String vehicleLicense =
                        _vehicleLicenseController.text;
                    final String idCard = _idCardController.text;
                    var uid = FirebaseAuth.instance.currentUser!.uid;
                    FirebaseFirestore db = FirebaseFirestore.instance;
                    if (idCard.isEmpty || vehicleLicense.isEmpty) {
                      displayToastMessage("Fill all information", context);
                    } else {
                      try {
                        await db
                            .collection("Driver")
                            .doc(uid)
                            .collection('legalDetails')
                            .doc()
                            .set({
                          "vehicleLicense": vehicleLicense,
                          "idCard": idCard,
                        }).whenComplete(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DocumentScreen()));
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
                const SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
