import 'package:flutter/material.dart';
import 'package:tcbapp/constants.dart';

class AdvicePage extends StatefulWidget {
  const AdvicePage({super.key});

  @override
  State<AdvicePage> createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor3,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('คำแนะนำการปฏิบัติตัว', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            CircleAvatar(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.02,),
            Center(
              child: Card(
                child: Container(
                  color: Colors.red,
                  height: size.height * 0.12,
                  width: size.width * 0.95,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}