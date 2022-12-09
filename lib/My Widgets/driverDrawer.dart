import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/driver/driverHome.dart';
import 'package:fyp/driver/driverLogin.dart';
import 'package:fyp/driver/settings.dart';
import 'package:google_fonts/google_fonts.dart';

import '../driver/driverProfile.dart';

Widget MyDrawerDriver(BuildContext context) {
  return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const DriverHome()));
            },
            child: myDrawer(
              'Map',
              Icons.map,
            ),
          ),
          myDrawer('History', Icons.history),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const DriverProfile()));
            },
            child: myDrawer('Profile', Icons.person_rounded),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SettingsDriver()));
            },
            child: myDrawer('Settings', Icons.settings),
          ),
          const Divider(
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut().whenComplete(() {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => DriverLogin()));
              });
            },
            child: myDrawer('Sign out', Icons.logout),
          )
        ],
      ));
}

myDrawer(
  String title,
  IconData IconLead,
) {
  return ListTile(
    leading: Icon(
      IconLead,
      color: Colors.white,
    ),
    title: Text(
      title,
      style: GoogleFonts.poppins(
          color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w400),
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios_outlined,
      color: Colors.white,
    ),
  );
}
