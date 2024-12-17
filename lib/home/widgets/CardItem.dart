import 'package:flutter/material.dart';
import 'package:tcbapp/constants.dart';

class CardItem extends StatefulWidget {
  final String date;
  final String hospital;
  final String diagnosis;
  final String rectum;
  final Size size;

  CardItem({super.key, required this.date, required this.hospital, required this.diagnosis, required this.size, required this.rectum});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool checktext = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: textColor,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: SizedBox(
          width: widget.size.width * 0.90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'โรงพยาบาลที่เคยไปรับการรักษา',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Text(
                    'วันที่วินิจฉัย',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.hospital,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.date,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 5),
              // Text(
              //   'วันที่วินิจฉัย: $date',
              //   style: TextStyle(fontSize: 14),
              // ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    'ICD-10',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.diagnosis,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                widget.rectum,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
