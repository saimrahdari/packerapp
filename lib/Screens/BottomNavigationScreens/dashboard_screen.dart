import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/Screens/DashboardScreen/courier_service.dart';
import 'package:fyp/Screens/DashboardScreen/find_trips.dart';
import 'package:fyp/Screens/DashboardScreen/history.dart';
import 'package:fyp/Screens/DashboardScreen/post_request.dart';
import 'package:fyp/Screens/DashboardScreen/request.dart';
import 'package:fyp/Screens/Orders/PlaceOrder.dart';
import 'package:fyp/Screens/Orders/sendOrder.dart';
import 'package:fyp/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../Services/constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen(
      {Key? key, required this.controller, required this.index})
      : super(key: key);

  final PageController? controller;
  final int? index;

  // final String value;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    // Future<bool?> showWarning(BuildContext context) async {
    //   showDialog<bool>(
    //       context: context,
    //       builder: (context) {
    //         return const AlertDialog(
    //             title: Text('Are you sure you want to quit?'),
    //             actions: <Widget>[
    //               // RaisedButton(
    //               //     child: Text('Yes'),
    //               //     onPressed: () => Navigator.pop(context, true)),
    //               // RaisedButton(
    //               //     child: Text('No'),
    //               //     onPressed: () => Navigator.pop(context, false)),
    //             ]);
    //       });
    //   return null;
    // }

    // return SafeArea(
    //   child: Scaffold(
    //     // key: scaffoldKey,
    //     appBar: AppBar(
    //       actions: [const Icon(Icons.notifications)],
    //       backgroundColor: const lightBlueColor,
    //       elevation: 0.0,
    //       title: Text(
    //         "PACKER",
    //         style: GoogleFonts.lato(
    //             textStyle: const TextStyle(
    //                 fontWeight: FontWeight.bold, color: Colors.white)),
    //       ),
    //       centerTitle: true,
    //     ),
    //     drawer: SafeArea(
    //       child: Container(
    //         width: width * 0.7,
    //         // color: Color(0xffFF593C),
    //         child: Drawer(
    //           child: ListView(
    //             // Important: Remove any padding from the ListView.
    //             padding: EdgeInsets.zero,
    //             children: <Widget>[
    //               DrawerHeader(
    //                 decoration: const BoxDecoration(
    //                   color: lightBlueColor,
    //                 ),
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Container(
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         const CircleAvatar(
    //                           // backgroundColor: Color(0xffFF593C),
    //                           radius: 50.0,
    //                         ),
    //                         const SizedBox(
    //                           width: 30.0,
    //                         ),
    //                         Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //
    //               const DrawerList(
    //                 iconName: Icons.location_on,
    //                 texxt: 'Address',
    //               ),
    //               // Divider(height: 1.0, color: Colors.grey.shade600, indent: 40.0, endIndent: 40.0,),
    //               const DrawerList(
    //                 iconName: Icons.star,
    //                 texxt: 'Rate',
    //               ),
    //               const DrawerList(
    //                 iconName: Icons.share,
    //                 texxt: 'Share',
    //               ),
    //               const DrawerList(
    //                 iconName: Icons.feedback,
    //                 texxt: 'Feedback',
    //               ),
    //               GestureDetector(
    //                 onTap: () {
    //                   FirebaseAuth.instance.signOut();
    //                   Navigator.of(context).push(MaterialPageRoute(
    //                       builder: (BuildContext context) => LoginPage()));
    //                 },
    //                 child: const ListTile(
    //                   leading: Icon(
    //                     Icons.logout,
    //                   ),
    //                   title: Text(
    //                     'Logout',
    //                     style: TextStyle(color: Colors.red),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //     body: SafeArea(
    //       child: Stack(
    //         fit: StackFit.loose,
    //         children: [
    //           Container(
    //             width: double.infinity,
    //             height: height * 0.3,
    //             decoration: const BoxDecoration(
    //               color: lightBlueColor,
    //             ),
    //             child: Padding(
    //               padding:
    //                   const EdgeInsets.only(top: 16.0, left: 18, right: 150),
    //               child: Text(
    //                 "Welcome to Dashboard.",
    //                 style: GoogleFonts.lato(
    //                     textStyle: const TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 35,
    //                         color: Colors.white)),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             color: const Color(0xfffD5DEEF),
    //             margin: const EdgeInsets.fromLTRB(0.0, 180.0, 0.0, 0.0),
    //             child: GridView.count(
    //               // crossAxisSpacing: 0,
    //               // mainAxisSpacing: 2,
    //               crossAxisCount: 2,
    //               scrollDirection: Axis.vertical,
    //               children: [
    //                 GestureDetector(
    //                   onTap: () {
    //                     Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) => const MyOrders()));
    //                   },
    //                   child: const ExpandedInsideContainer(
    //                     icon: Icon(Icons.location_on,
    //                         size: 40, color: lightBlueColor),
    //                     secondName: "My Orders",
    //                   ),
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {
    //                     Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) => const MyTrips()));
    //                   },
    //                   child: const ExpandedInsideContainer(
    //                     icon: Icon(Icons.edit,
    //                         size: 40, color: lightBlueColor),
    //                     secondName: "All Trips",
    //                   ),
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {
    //                     showBottomSheet(context);
    //                   },
    //                   child: const ExpandedInsideContainer(
    //                     icon: Icon(Icons.share_location_rounded,
    //                         size: 40, color: lightBlueColor),
    //                     secondName: "New Order",
    //                   ),
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {
    //                     Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) => const CreateTrip()));
    //                   },
    //                   child: const ExpandedInsideContainer(
    //                     icon: Icon(Icons.settings,
    //                         size: 40, color: lightBlueColor),
    //                     secondName: "New Trip",
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 17.w),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(currentFirebaseUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var userDocument = snapshot.data!.data();
                return SizedBox(
                  height: 50.sp,
                  width: 1.sw,
                  child: Row(
                    children: [
                      Expanded(
                          child: Align(
                        alignment: Alignment.center,
                        child: userDocument!["profile_image"].toString().isEmpty
                            ? Icon(Icons.person_outline_outlined)
                            : Image.network(userDocument!["profile_image"]),
                      )),
                      SizedBox(width: 8.w),
                      Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Hi, ${userDocument["username"]}',
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                              ),
                            ),
                          )),
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.search))),
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.notifications))),
                    ],
                  ),
                );
              }),
          SizedBox(height: 20.h),
          Text(
            'Dashboard',
            style: GoogleFonts.poppins(
              fontSize: 22.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FindTrips())),
                  child: Container(
                    width: 165.0.w,
                    height: 150.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(Icons.language,
                              size: 50.sp, color: lightBlueColor),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Find Trips',
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RequestScreen())),
                  child: Container(
                    width: 165.0.w,
                    height: 150.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(Icons.request_page,
                              size: 50.sp, color: lightBlueColor),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Requests',
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostRequestScreen())),
                  child: Container(
                    width: 165.0.w,
                    height: 150.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(Icons.flight_takeoff,
                              size: 50.sp, color: lightBlueColor),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Post Request',
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.controller!.jumpToPage(1);
                  },
                  child: Container(
                    width: 165.0.w,
                    height: 150.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(Icons.flight,
                              size: 50.sp, color: lightBlueColor),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'My Trips',
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CourierService())),
                  child: Container(
                    width: 165.0.w,
                    height: 150.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(Icons.car_crash,
                              size: 50.sp, color: lightBlueColor),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Courier Service',
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryService())),
                  child: Container(
                    width: 165.0.w,
                    height: 150.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(Icons.history,
                              size: 50.sp, color: lightBlueColor),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'History',
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class DrawerList extends StatelessWidget {
  const DrawerList({
    // required Key key,
    required this.iconName,
    required this.texxt,
    // required this.stylee,
  });

  final IconData iconName;
  final String texxt;

  // final TextStyle stylee;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconName,
      ),
      title: Text(
        texxt,
        style: GoogleFonts.lato(textStyle: const TextStyle()),
      ),
      onTap: () {},
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////

class ExpandedInsideContainer extends StatelessWidget {
  const ExpandedInsideContainer({
    required this.icon,
    required this.secondName,
  });

  final Icon icon;
  final String secondName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0, left: 20, right: 20),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(
                height: 8,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: secondName,
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: lightBlueColor,
                  )),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}

Future showBottomSheet(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  return showMaterialModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), topLeft: Radius.circular(20)),
    ),
    backgroundColor: const Color(0xfffD5DEEF),
    context: context,
    builder: (context) => Container(
      child: Container(
        padding: const EdgeInsets.all(22.0),
        width: double.infinity,
        height: height * 0.25,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 250,
                  height: height * 0.09,
                  color: Colors.black12,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PlaceOrder()));
                    },
                    child: const Text(
                      "I WANT TO ORDER",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: lightBlueColor)),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(lightBlueColor),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(2)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250,
                  height: height * 0.09,
                  color: Colors.black12,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SendOrder()));
                    },
                    child: const Text(
                      "I WANT TO SEND",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: lightBlueColor)),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(lightBlueColor),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(2)),
                    ),
                  ),
                ),
                // Container(
                //     width: 250,
                //     color: Colors.black12,
                //     child: IconButton(
                //         icon: Icon(
                //           Icons.cancel_outlined,
                //           color: Colors.grey.shade200,
                //         ),
                //         onPressed: () {
                //           Navigator.pop(context);
                //         })),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
