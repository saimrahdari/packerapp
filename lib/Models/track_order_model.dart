import 'package:cloud_firestore/cloud_firestore.dart';

class TrackOrderModel {
  final String userName;
  final String email;
  final GeoPoint geoPoint;
  final Timestamp updatedAt;

  TrackOrderModel({required this.userName, required this.email, required this.geoPoint, required this.updatedAt});
}