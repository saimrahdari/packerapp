import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp/driver/driverProfile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../My Widgets/driverDrawer.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  final Completer<GoogleMapController> _controller = Completer();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: MyDrawerDriver(context),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: const CameraPosition(
              target: LatLng(33, 73),
              zoom: 15,
            ),
            // myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // CircleAvatar(
                //     backgroundColor: Colors.white,
                //     child: Icon(
                //       Icons.more_horiz,
                //       color: Colors.grey,
                //     )),
                GestureDetector(
                  onTap: () {
                    _key.currentState!.openDrawer();
                  },
                  child: Image.asset(
                    'assets/moreOption.png',
                    width: 50.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DriverProfile()));
                  },
                  child: Image.asset(
                    'assets/img.png',
                    width: 50.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
