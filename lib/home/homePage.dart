import 'package:flutter/material.dart';
import 'package:tcbapp/home/widgets/CardItem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('ยินดีต้อนรับ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        elevation: 5,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.12,
              width: size.width,
              color: Colors.teal,
            ),
            CardItem(
              date: '18/10/2567',
              hospital: 'สถาบันมะเร็งแห่งชาติ',
              diagnosis: 'C20: Malignant neoplasm of rectum',
              size: size,
            ),
            CardItem(
              date: '26/07/2567',
              hospital: 'สถาบันมะเร็งแห่งชาติ',
              diagnosis: 'C20: Malignant neoplasm of rectum',
              size: size,
            ),
            CardItem(
              date: '09/07/2567',
              hospital: 'สถาบันมะเร็งแห่งชาติ',
              diagnosis: 'C20: Malignant neoplasm of rectum',
              size: size,
            ),
          ],
        ),
      ),
    );
  }
}
