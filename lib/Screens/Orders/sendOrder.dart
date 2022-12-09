import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/Screens/BottomNavigationScreens/bottom_navigation_screen.dart';
import 'package:fyp/Screens/Orders/PlaceOrder.dart';
import 'package:fyp/Screens/BottomNavigationScreens/dashboard_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

class SendOrder extends StatefulWidget {
  const SendOrder({Key? key}) : super(key: key);

  @override
  State<SendOrder> createState() => _SendOrderState();
}

TextEditingController fromController = TextEditingController();
TextEditingController toController = TextEditingController();
TextEditingController todateController = TextEditingController();
TextEditingController fromdateController = TextEditingController();
TextEditingController weightController = TextEditingController();
TextEditingController descController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();

class _SendOrderState extends State<SendOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfffD5DEEF),
      appBar: AppBar(
        backgroundColor: Color(0xff3E4685),
        elevation: 0.0,
        title: Text(
          "Send Order",
          style: GoogleFonts.lato(
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 13, right: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ORDER DETAILS",
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ))),
              SizedBox(
                height: 12,
              ),
              _formfield("Where Would You Like To Order From", "City/Country",
                  toController),
              SizedBox(
                height: 10,
              ),
              _formfield("Where Would You Like Your Order Delivered",
                  "City/Country", fromController),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Earliest Date To Recieve Your Order",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: todateController,
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
                                  colorScheme: ColorScheme.light(
                                    primary: Color(0xff3E4685), // <-- SEE HERE
                                    onPrimary: Colors.white, // <-- SEE HERE
                                    onSurface: Colors.black, // <-- SEE HERE
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      primary: Color(
                                          0xff3E4685), // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            });

                        if (pickDate != null) {
                          setState(() {
                            todateController.text =
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
                        hintText: "DD/YY/MM",
                        // ignore: prefer_const_constructors
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Earliest Date To Recieve Your Order",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: fromdateController,
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
                                  colorScheme: ColorScheme.light(
                                    primary: Color(0xff3E4685), // <-- SEE HERE
                                    onPrimary: Colors.white, // <-- SEE HERE
                                    onSurface: Colors.black, // <-- SEE HERE
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      primary: Color(
                                          0xff3E4685), // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            });

                        if (pickDate != null) {
                          setState(() {
                            fromdateController.text =
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
                        hintText: "DD/YY/MM",
                        // ignore: prefer_const_constructors
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _formfield(
                "How Much Weight Do You Need",
                "Order Weight",
                weightController,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 3,
                controller: descController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(

                        // ignore: prefer_const_constructors
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "",
                    // ignore: prefer_const_constructors

                    labelText: "Write Description Here"),
              ),
              SizedBox(
                height: 10,
              ),
              _formfield("Full Name", "Your Name Here", nameController),
              SizedBox(
                height: 10,
              ),
              _formfield("Mobile No", "+92", phoneController),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (toController.text.isNotEmpty &&
                          fromController.text.isNotEmpty &&
                          todateController.text.isNotEmpty &&
                          fromdateController.text.isNotEmpty &&
                          descController.text.isNotEmpty &&
                          weightController.text.isNotEmpty &&
                          nameController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty) {
                        addData(context);
                      } else {
                        Fluttertoast.showToast(msg: "Please fill the form");
                      }
                    },
                    child: Text(
                      "Submit",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff3E4685),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _formfield(String a, String b, TextEditingController controller) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          a,
          style: GoogleFonts.lato(
              textStyle: TextStyle(
            fontSize: 15,
          )),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                // ignore: prefer_const_constructors
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            hintText: b,
            // ignore: prefer_const_constructors
          ),
        ),
      ],
    ),
  );
}

void addData(BuildContext context) async {
  // CommanDialog.showLoading();

  Map<String, dynamic> userDataMap = {
    "to": toController.text,
    "from": fromController.text,
    "toDate": todateController.text,
    "fromDate": fromdateController.text,
    "weight": weightController.text,
    "desc": descController.text,
    "name": nameController.text,
    "phone": phoneController.text
  };
  User? currentFirebaseUser = FirebaseAuth.instance.currentUser;

  FirebaseFirestore.instance
      .collection("Users")
      .doc(currentFirebaseUser?.uid)
      .collection("SentData")
      .add(userDataMap);
  displayToastMessage("Data has been successfully added", context);
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) => BottomNavigationScreen()));
}
