import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp/My%20Widgets/my_button_2.dart';
import 'package:fyp/Services/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CourierService extends StatefulWidget {
  const CourierService({Key? key}) : super(key: key);

  @override
  State<CourierService> createState() => _CourierServiceState();
}

class _CourierServiceState extends State<CourierService> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final s =MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Courier Service'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: LatLng(33, 73),
            zoom: 15,
          ),
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
    ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: s.height * 0.5
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Image.asset('assets/a.png.png', height: 50, width: 50,)),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Huzayfah', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Row(
                                      children: const [
                                        Icon(Icons.star, color: Colors.yellow),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 5),
                                          child: Text('4.9'),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: const [
                                Text('Vehicle No', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('RIM583')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.circle_outlined),
                          Expanded(child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text('i5, City Road', style: TextStyle(fontWeight: FontWeight.bold),),
                          )),
                          Text('10:00 AM', style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: const [
                            Icon(Icons.circle_outlined),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text('Central Ave', style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Text('10:40 AM', style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Pick Up', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('10:05 AM', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text('Delivery', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('10:30 AM', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(25),
                                  child: Center(child: Icon(Icons.message)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(25),
                                  child: Center(child: Icon(Icons.call)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(25),
                                  child: Center(child: Text('Cancel', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      MyButton2(onTap: (){}, text: 'I\'m Coming')
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
