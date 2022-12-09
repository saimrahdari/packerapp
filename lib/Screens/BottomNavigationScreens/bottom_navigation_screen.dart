import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/Chatting/components/screens/chats/chats_screen.dart';
import 'package:fyp/Screens/BottomNavigationScreens/create_trip.dart';
import 'package:fyp/Screens/BottomNavigationScreens/dashboard_screen.dart';
import 'package:fyp/Screens/BottomNavigationScreens/my_trips.dart';
import 'package:fyp/Screens/BottomNavigationScreens/setting.dart';
import 'package:location/location.dart';

import '../Chats/inbox.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final PageController controller = PageController(initialPage: 0);
  int? index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          DashboardScreen(controller: controller, index: 1),
          const MyTrips(),
          const CreateTrip(),
          const Inbox(),
          const SettingScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60.sp,
        decoration: const BoxDecoration(
            border: Border.symmetric(
          vertical: BorderSide(color: Color(0xff1616160)),
        )),
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {
                  controller.jumpToPage(0);
                  index = 0;
                  if (!mounted) return;
                  setState(() {});
                },
                icon: const Icon(Icons.home_outlined),
                color: index == 0 ? const Color(0xFF161616) : Colors.grey,
                iconSize: 28.sp,
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  controller.jumpToPage(1);
                  index = 1;
                  if (!mounted) return;
                  setState(() {});
                },
                icon: const Icon(Icons.flight_takeoff),
                color: index == 1 ? const Color(0xFF161616) : Colors.grey,
                iconSize: 28.sp,
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  controller.jumpToPage(2);
                  index = 2;
                  if (!mounted) return;
                  setState(() {});
                },
                icon: const Icon(Icons.add_box),
                color: const Color(0xFF161616),
                iconSize: 35.sp,
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  controller.jumpToPage(3);
                  index = 3;
                  if (!mounted) return;
                  setState(() {});
                },
                icon: const Icon(Icons.message_rounded),
                color: index == 3 ? const Color(0xFF161616) : Colors.grey,
                iconSize: 28.sp,
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  controller.jumpToPage(4);
                  index = 4;
                  if (!mounted) return;
                  setState(() {});
                },
                icon: const Icon(Icons.dashboard_rounded),
                color: index == 4 ? const Color(0xFF161616) : Colors.grey,
                iconSize: 28.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _streamUserLocation() async {
    Location location = Location();

    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }


    location.onLocationChanged.listen((LocationData currentLocation) {
      final User? user = FirebaseAuth.instance.currentUser;
     if (user != null) {
       FirebaseFirestore.instance
          .collection('Location')
          .doc(user!.uid)
          .set({
        'location': GeoPoint(currentLocation.latitude!, currentLocation.longitude!),
        'updatedAt': DateTime.now(),
        'userName': user.displayName,
        'email': user.email,
      });
      } else {
        print('User is null');
      }
    });
  }
}
