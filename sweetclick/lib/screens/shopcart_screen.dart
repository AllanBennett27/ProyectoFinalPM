import 'package:flutter/material.dart';

class ShopcartScreen extends StatefulWidget {
  const ShopcartScreen({super.key});

  @override
  State<ShopcartScreen> createState() => _ShopcartScreenState();
}

class _ShopcartScreenState extends State<ShopcartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
         child: Text(
                  "Shopcart screen workin progress",
                  style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                color: Colors.black,
         
                 ),
            )
         )
      );
  }
}