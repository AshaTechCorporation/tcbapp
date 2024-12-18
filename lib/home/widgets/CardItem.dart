import 'package:flutter/material.dart';
import 'package:tcbapp/constants.dart';

class CardItem extends StatefulWidget {
  final String date;
  final String hospital;
  final String diagnosis;

  final Size size;

  CardItem({
    super.key,
    required this.date,
    required this.hospital,
    required this.diagnosis,
    required this.size,
  });

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
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ICD-10',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.diagnosis,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      softWrap: checktext,
                      overflow: checktext ? null : TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        checktext = !checktext;
                      });
                    },
                    child: Icon(
                      checktext ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_up_outlined,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
