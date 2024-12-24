import 'package:flutter/material.dart';
import 'package:tcbapp/constants.dart';

class Dialogyes extends StatefulWidget {
  const Dialogyes({
    super.key,
    required this.description,
    required this.pressYes,
    InkWell? onTap,
    required this.title,
    required this.bottomNameYes,
  });
  final String title, description, bottomNameYes;
  final VoidCallback? pressYes;

  @override
  State<Dialogyes> createState() => _DialogyesState();
}

class _DialogyesState extends State<Dialogyes> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(
        widget.description,
        style: TextStyle(fontSize: 15),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: widget.pressYes,
              child: Text(
                widget.bottomNameYes,
                style: TextStyle(fontSize: 18, color: kBackgroundColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
