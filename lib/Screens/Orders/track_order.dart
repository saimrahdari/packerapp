import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Models/track_order_model.dart';

class TrackOrder extends StatefulWidget {

  final String userId;

  const TrackOrder({Key? key, required this.userId}) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  final Completer<GoogleMapController> _controller = Completer();
  List<Marker> marker = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
      ),
      body: StreamBuilder<TrackOrderModel?>(
        stream: FirebaseFirestore.instance
          .collection('Location')
          .doc(widget.userId)
          .snapshots()
          .map((event) => event.data() != null ? TrackOrderModel(
            userName: (event.data() ?? {})['userName'],
            email: (event.data() ?? {})['email'],
            geoPoint: (event.data() ?? {})['location'],
            updatedAt: (event.data() ?? {})['updatedAt'],
        ) : null),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }else if(snapshot.hasData){
            if(snapshot.data != null){
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(snapshot.data!.geoPoint.latitude, snapshot.data!.geoPoint.longitude),
                  zoom: 15,
                ),
                markers: Set<Marker>.of(marker),
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  setState(() {
                    marker.add(Marker(
                        markerId: MarkerId(snapshot.data!.email),
                        icon: BitmapDescriptor.defaultMarker,
                        position: LatLng(snapshot.data!.geoPoint.latitude, snapshot.data!.geoPoint.longitude),
                        visible: true,
                        infoWindow: InfoWindow(
                          title: snapshot.data!.userName,
                            snippet: getFormattedTimeStamp(timestamp: snapshot.data!.updatedAt)
                        )
                    ));
                  });
                },
              );
            }else{
              return const Center(child: Text('User location not available'),);
            }
          }else{
            return const Center(child: Text('User location not available', textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold)),);
            // return const Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }

  getFormattedTimeStamp({required Timestamp timestamp}) {
    int hour = timestamp.toDate().hour;
    String hourZero = '';

    int minute = timestamp.toDate().minute;
    String minuteZero = '';

    String isAmOrPm = 'AM';

    if (hour > 12) {
      hour = hour - 12;
      isAmOrPm = 'PM';
    } else if (hour == 00) {
      hour = 12;
    } else if(hour == 12){
      isAmOrPm = 'PM';
    }

    if(minute < 10){
      minuteZero = '0';
    }

    if (hour < 10) {
      hourZero = '0';
    }

    return 'Date: '+timestamp.toDate().day.toString()+'-'+timestamp.toDate().month.toString()+'-'+timestamp.toDate().year.toString()+'   Time: ${hourZero.toString()}${hour.toString()}:$minuteZero${minute.toString()} $isAmOrPm';
  }
}
