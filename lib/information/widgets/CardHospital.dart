import 'package:flutter/material.dart';
import 'package:tcbapp/constants.dart';

class CardHospital extends StatefulWidget {
  final Size size;
  final String? hospitalname;

  CardHospital({super.key, required this.size, required this.hospitalname});

  @override
  State<CardHospital> createState() => _CardHospitalState();
}

class _CardHospitalState extends State<CardHospital> {
  bool checktext = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: widget.size.height * 0.1,
        width: widget.size.width * 0.5,
        decoration: BoxDecoration(
          color: textColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: textColor2.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.add_location,
                color: kBackgroundColor2,
                size: 30,
              ),
              Expanded(child: Text('${widget.hospitalname}'))
            ],
          ),
        ),
      ),
    );
  }
}
