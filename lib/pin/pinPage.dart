import 'package:flutter/material.dart';

class Pinpage extends StatefulWidget {
  const Pinpage({super.key});

  @override
  State<Pinpage> createState() => _PinpageState();
}

class _PinpageState extends State<Pinpage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height * 1,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00CFCF), Color(0xFF00E0D0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
