import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/Screens/BottomNavigationScreens/bottom_navigation_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../My Widgets/my_button_2.dart';
import '../../Services/Firestore/my_firestore.dart';
import '../../Services/constants.dart';

class PostRequestScreen extends StatefulWidget {
  const PostRequestScreen({Key? key}) : super(key: key);

  @override
  State<PostRequestScreen> createState() => _PostRequestScreenState();
}

class _PostRequestScreenState extends State<PostRequestScreen> {
  final TextEditingController departureController = TextEditingController();
  final TextEditingController arrivalController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  TextEditingController pricePerKGController = TextEditingController();
  TextEditingController flightNoController = TextEditingController();

  String? departureCountry;
  String? arrivalCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(12.sp),
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Row(
              children: [
                Expanded(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    iconSize: 22.sp,
                  ),
                )),
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Post Request',
                      style: GoogleFonts.poppins(fontSize: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: _formField("Where Are You Travelling From", "City",
                      departureController),
                ),
                const SizedBox(width: 5,),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Container(
                      padding:
                      const EdgeInsets.only(
                        left: 5,
                        right: 5,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton(items: countries
                          .map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: departureCountry,
                          hint: const Text('Country'),
                          underline: const SizedBox(),
                          isExpanded: true,
                          onChanged: (v){
                            setState(() {
                              departureCountry = v.toString();
                            });
                          }),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: _formField(
                      "When Are You Travelling To", "City", arrivalController),
                ),
                const SizedBox(width: 5,),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Container(
                      padding:
                      const EdgeInsets.only(
                        left: 5,
                        right: 5,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton(items: countries
                          .map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: arrivalCountry,
                          hint: const Text('Country'),
                          underline: const SizedBox(),
                          isExpanded: true,
                          onChanged: (v){
                            setState(() {
                              arrivalCountry = v.toString();
                            });
                          }),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            _formField("Your Flight No", "Flight No", flightNoController),
            const SizedBox(
              height: 10,
            ),
            _formField("Price Per KG", "Price Per KG", pricePerKGController),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "When Are You Travelling",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: dateController,
                    keyboardType: TextInputType.none,
                    onTap: () async {
                      DateTime? pickDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: Color(0xff3E4685), // <-- SEE HERE
                                  onPrimary: Colors.white, // <-- SEE HERE
                                  onSurface: Colors.black, // <-- SEE HERE
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: const Color(
                                        0xff3E4685), // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          });

                      if (pickDate != null) {
                        setState(() {
                          dateController.text =
                              DateFormat('yyyy-MM-dd').format(pickDate);
                        });
                      }
                    },
                    // controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        // ignore: prefer_const_constructors
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "DD/MM//YY",
                      // ignore: prefer_const_constructors
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _formField(
              "How Much Space Do You Have",
              "Order Weight",
              weightController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              maxLines: 4,
              controller: descriptionController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(

                    // ignore: prefer_const_constructors
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "",
                  // ignore: prefer_const_constructors

                  labelText: "Write Description Here"),
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton2(
              text: 'Submit',
              onTap: (){
                if (departureController.text.isNotEmpty &&
                    arrivalController.text.isNotEmpty &&
                    dateController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    weightController.text.isNotEmpty) {
                  addData(context);
                } else {
                  Fluttertoast.showToast(msg: "Please fill the form");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _formField(
      String text, String hintText, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: GoogleFonts.lato(
                textStyle: const TextStyle(
              fontSize: 15,
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  // ignore: prefer_const_constructors
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              hintText: hintText,
              // ignore: prefer_const_constructors
            ),
          ),
        ],
      ),
    );
  }

  void addData(BuildContext context) async {
    Navigator.pop(context);

    User? currentFirebaseUser = FirebaseAuth.instance.currentUser;

    postRequest(
      pricePerKg: pricePerKGController.text,
      flightNo: flightNoController.text,
      flightDate: dateController.text,
      weight: weightController.text,
      description: descriptionController.text,
      userId: currentFirebaseUser!.uid,
      userName: currentFirebaseUser.displayName.toString(),
      email: currentFirebaseUser.email.toString(),
      arrivalCity: arrivalController.text.trim(),
      arrivalCountry: arrivalCountry.toString(),
      departureCity: departureController.text.trim(),
      departureCountry: departureCountry.toString(),
    );

    addAllTrip(
      pricePerKg: pricePerKGController.text,
      flightNo: flightNoController.text,
      flightDate: dateController.text,
      weight: weightController.text,
      description: descriptionController.text,
      userId: currentFirebaseUser.uid,
      userName: currentFirebaseUser.displayName.toString(),
      email: currentFirebaseUser.email.toString(),
      arrivalCity: arrivalController.text.trim(),
      arrivalCountry: arrivalCountry.toString(),
      departureCity: departureController.text.trim(),
      departureCountry: departureCountry.toString(),
    );

    addCity(city: departureController.text.trim());
    addCity(city: arrivalController.text.trim());

    Fluttertoast.showToast(msg: 'Post Requested');
  }
}
