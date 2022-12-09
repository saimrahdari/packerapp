import 'package:cloud_firestore/cloud_firestore.dart';

addCity({required String city}){
  FirebaseFirestore.instance.collection('Data').doc('cities').set({
    'cities': FieldValue.arrayUnion([city]),
  }, SetOptions(merge: true));
}

postRequest({
  required String departureCity,
  required String arrivalCity,
  required String departureCountry,
  required String arrivalCountry,
  required String flightDate,
  required String weight,
  required String description,
  required String userId,
  required String userName,
  required String email,
  required String pricePerKg,
  required String flightNo,
}){
  FirebaseFirestore.instance.collection('Post Requests').add({
    'departureCity': departureCity,
    'arrivalCity': arrivalCity,
    'departureCountry': departureCountry,
    'arrivalCountry': arrivalCountry,
    'flightDate': flightDate,
    'weight': weight,
    'description': description,
    'userId': userId,
    'userName': userName,
    'email': email,
    'pricePerKg': pricePerKg,
    'flightNo': flightNo,
    'createdAt': Timestamp.now(),
  });
}

addAllTrip({
  required String departureCity,
  required String arrivalCity,
  required String departureCountry,
  required String arrivalCountry,
  required String flightDate,
  required String weight,
  required String description,
  required String userId,
  required String userName,
  required String email,
  required String pricePerKg,
  required String flightNo,
}){
  FirebaseFirestore.instance.collection('All Trips').add({
    'departureCity': departureCity,
    'arrivalCity': arrivalCity,
    'departureCountry': departureCountry,
    'arrivalCountry': arrivalCountry,
    'flightDate': flightDate,
    'weight': weight,
    'description': description,
    'userId': userId,
    'userName': userName,
    'email': email,
    'pricePerKg': pricePerKg,
    'flightNo': flightNo,
    'createdAt': Timestamp.now(),
  });
}

addMyTrip({
  required String departureCity,
  required String arrivalCity,
  required String departureCountry,
  required String arrivalCountry,
  required String flightDate,
  required String weight,
  required String description,
  required String userId,
  required String pricePerKg,
  required String flightNo,
}){
  FirebaseFirestore.instance
      .collection('Users')
      .doc(userId)
      .collection('My Trips')
      .add({
    'departureCity': departureCity,
    'arrivalCity': arrivalCity,
    'departureCountry': departureCountry,
    'arrivalCountry': arrivalCountry,
    'flightDate': flightDate,
    'weight': weight,
    'description': description,
    'pricePerKg': pricePerKg,
    'flightNo': flightNo,
    'createdAt': Timestamp.now(),
  });
}

addBidRequest({
  required String userId,
  required String arrival,
  required String departure,
  required String description,
  required String flightDate,
  required String weight,
  required String bidderUserId,
  required String bidderEmail,
  required String bidderUserName,
  required String amount,
  required String message,
}){
  FirebaseFirestore.instance
      .collection('Requests')
      .doc(userId)
      .collection('Bids')
      .add({
    'arrival': arrival,
    'departure': departure,
    'description': description,
    'flightDate': flightDate,
    'weight': weight,
    'bidderUserId': bidderUserId,
    'bidderEmail': bidderEmail,
    'bidderUserName': bidderUserName,
    'amount': amount,
    'message': message,
    'status': 'Pending',
    'createdAt': Timestamp.now(),
  });
}

acceptBidRequest({
  required String userId,
  required String bidRequestId,
}){
  FirebaseFirestore.instance
      .collection('Requests')
      .doc(userId)
      .collection('Bids')
      .doc(bidRequestId)
      .update({
    'status': 'Accepted',
  });
}

declineBidRequest({
  required String userId,
  required String bidRequestId,
}){
  FirebaseFirestore.instance
      .collection('Requests')
      .doc(userId)
      .collection('Bids')
      .doc(bidRequestId)
      .update({
    'status': 'Declined',
  });
}