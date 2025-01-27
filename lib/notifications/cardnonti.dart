import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tcbapp/constants.dart';

class Cardnonti extends StatefulWidget {
  final Size size;
  final String? appoint_date;
  final String? message;

  Cardnonti({
    super.key,
    required this.size,
    required this.appoint_date,
    required this.message,
  });

  @override
  State<Cardnonti> createState() => _CardnontiState();
}

class _CardnontiState extends State<Cardnonti> {
  bool checktext = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width * 0.5,
      decoration: BoxDecoration(
        color: textColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: textColor2.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.appoint_date ?? '',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                // Text(
                //   '${widget.nonti}',
                //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Html(
                    data: widget.message ?? '',
                    // style: TextStyle(
                    //   fontSize: 16,
                    // ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
