import 'package:flutter/material.dart';
import 'package:fyp/driver/driverHome.dart';

import '../Services/constants.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen>
    with SingleTickerProviderStateMixin {
  // bool pickerIsExpanded = false;
  // int _pickerYear = DateTime.now().year;
  // DateTime _selectedMonth = DateTime(
  //   DateTime.now().year,
  //   DateTime.now().month,
  //   1,
  // );
  //
  // dynamic _pickerOpen = false;
  //
  // void switchPicker() {
  //   setState(() {
  //     _pickerOpen ^= true;
  //   });
  // }
  //
  // List<Widget> generateRowOfMonths(from, to) {
  //   List<Widget> months = [];
  //   for (int i = from; i <= to; i++) {
  //     DateTime dateTime = DateTime(_pickerYear, i, 1);
  //     final backgroundColor = dateTime.isAtSameMomentAs(_selectedMonth)
  //         ? Theme.of(context).accentColor
  //         : Colors.transparent;
  //     months.add(
  //       AnimatedSwitcher(
  //         duration: kThemeChangeDuration,
  //         transitionBuilder: (Widget child, Animation<double> animation) {
  //           return FadeTransition(
  //             opacity: animation,
  //             child: child,
  //           );
  //         },
  //         child: TextButton(
  //           key: ValueKey(backgroundColor),
  //           onPressed: () {
  //             setState(() {
  //               _selectedMonth = dateTime;
  //             });
  //           },
  //           style: TextButton.styleFrom(
  //             backgroundColor: backgroundColor,
  //             shape: CircleBorder(),
  //           ),
  //           child: Text(
  //             DateFormat('MMM').format(dateTime),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   return months;
  // }
  //
  // List<Widget> generateMonths() {
  //   return [
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: generateRowOfMonths(1, 4),
  //     ),
  //     SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: generateRowOfMonths(5, 10),
  //       ),
  //     ),
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: generateRowOfMonths(11, 12),
  //     ),
  //   ];
  // }
  final List<String> _dropdownValues = ["One", "Two", "Three", "Four", "Five"];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      'LOGO',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 1.2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Image.asset(
                    'assets/process4.png',
                    width: 270.0,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Text(
                  'Documents',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 2,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 40),
                  child: Text(
                    'We legally required to ask you for some documents to sign you up as driver.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),

                ///date
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26.0)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Driving License*',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DropdownButton(
                              items: _dropdownValues
                                  .map((value) => DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      ))
                                  .toList(),
                              onChanged: (String? value) {},
                              isExpanded: false,
                              value: _dropdownValues.first,
                            ),
                            DropdownButton(
                              items: _dropdownValues
                                  .map((value) => DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      ))
                                  .toList(),
                              onChanged: (String? value) {},
                              isExpanded: false,
                              value: _dropdownValues.first,
                            ),
                            DropdownButton(
                              items: _dropdownValues
                                  .map((value) => DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      ))
                                  .toList(),
                              onChanged: (String? value) {},
                              isExpanded: false,
                              value: _dropdownValues.first,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: 100,
                                height: 50.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.upload_outlined,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Upload',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ///take selfie
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 130.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26.0)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Take Selfie *',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: 120,
                                height: 50.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        'Take Selfie',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ///registration doc
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 130.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26.0)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Vehicle Registration Docs*',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: 100,
                                height: 50.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.upload_outlined,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Upload',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ///vehicle pic
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 130.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26.0)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Vehicle Picture*',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: 100,
                                height: 50.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.upload_outlined,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Upload',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DriverHome()));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Center(
                          child: Text('Finish',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                ),
                const SizedBox.square(
                  dimension: 5,
                ),
                const SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
