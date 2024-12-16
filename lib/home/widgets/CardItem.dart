import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String date;
  final String hospital;
  final String diagnosis;
  final Size size;

  CardItem({required this.date, required this.hospital, required this.diagnosis, required this.size});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: SizedBox(
          width: size.width * 0.90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'โรงพยาบาลที่เคยไปรับการรักษา',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 5),
              Text(
                hospital,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'วันที่วินิจฉัย: $date',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5),
              Text(
                diagnosis,
                style: TextStyle(fontSize: 14, color: Colors.teal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}