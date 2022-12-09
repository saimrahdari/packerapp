import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const Color lightBlueColor = Color(0xFF2A94F4);
const Color blackColor = Colors.black;

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle:
          TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0),
  colorScheme: ColorScheme.fromSwatch().copyWith(primary: lightBlueColor),
);

const double horizontalPadding = 15.0;

String getFormattedTime({required Timestamp timestamp}) {
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
  } else if (hour == 12) {
    isAmOrPm = 'PM';
  }

  if (minute == 0) {
    minuteZero = '0';
  }

  if (hour < 10) {
    hourZero = '0';
  }

  return '${hourZero.toString()}${hour.toString()}:${minuteZero.toString()}${minute.toString()} $isAmOrPm';
}

String getFormattedDate({required Timestamp timestamp}) {
  return '${timestamp.toDate().day}-${timestamp.toDate().month}-${timestamp.toDate().year}';
}

String getChatId({required String userId1, required String userId2}) {
  String chatId = '';
  if (userId1.hashCode < userId2.hashCode) {
    chatId = '${userId1.hashCode}_${userId2.hashCode}';
  } else {
    chatId = '${userId2.hashCode}_${userId1.hashCode}';
  }

  return chatId;
}

List<String> countries = [];

setCountries() async {
  countries = await Dio()
      .get('https://countriesnow.space/api/v0.1/countries')
      .then((value) => (value.data['data'] as List)
          .map((e) => e['country'].toString())
          .toList());
}
