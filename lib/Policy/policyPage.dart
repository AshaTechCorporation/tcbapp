import 'package:flutter/material.dart';
import 'package:tcbapp/constants.dart';

class Policypage extends StatefulWidget {
  const Policypage({super.key});

  @override
  State<Policypage> createState() => _PolicypageState();
}

class _PolicypageState extends State<Policypage> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ข้อกำหนดและเงื่อนไขในการใช้บริการ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Column(),
      bottomSheet: Container(
        height: size.height * 0.2,
        decoration: BoxDecoration(
          color: textColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(children: [
          Row(
            children: [
              Checkbox(
                activeColor: kBackgroundColor2,
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              SizedBox(width: 10), // กำหนดระยะห่างระหว่าง Checkbox กับ Text
              Text(
                'ข้าพเจ้ายอมรับข้อกำหนดเเละเงื่อนไขการให้บริการนี้',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: textColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  height: size.height * 0.05,
                  width: size.width * 0.1,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: textColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  height: size.height * 0.05,
                  width: size.width * 0.1,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
