import 'package:flutter/material.dart';

class MyButton2 extends StatelessWidget {

  final void Function()? onTap;
  final String text;

  const MyButton2({Key? key, required this.onTap, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Center(child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          ),
        ),
      ),
    );
  }
}
