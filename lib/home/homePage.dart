import 'package:flutter/material.dart';
import 'package:tcbapp/constants.dart';
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
      backgroundColor: kBackgroundColor3,
      appBar: AppBar(
        shadowColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ยินดีต้อนรับ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Image.asset(
              'assets/icons/logo MOPH.png',
              scale: 10,
            ),
          ],
        ),
        backgroundColor: kBackgroundColor,
        elevation: 5,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.12,
            width: double.infinity,
            color: kBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 15),
                          Text(
                            'ชื่อ : ',
                            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '***** *****',
                            style: TextStyle(color: textColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          SizedBox(width: 15),
                          Text(
                            'เพศ : ',
                            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'ชาย',
                            style: TextStyle(color: textColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          SizedBox(width: 15),
                          Text(
                            'เลข ID : ',
                            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '3-1021-00144-94-8',
                            style: TextStyle(color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: avatarColor,
                        width: 3.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: textColor,
                      child: Icon(
                        Icons.person_outline,
                        color: avatarColor,
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: size.height * 0.07,
            width: double.infinity,
            color: kBackgroundColor2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'รายการนัดหมาย : ',
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ไม่มี',
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: size.height * 0.07,
            width: double.infinity,
            color: kBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'ประวัติการรักษา : ',
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cardItems.length,
              itemBuilder: (context, index) {
                final item = cardItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: CardItem(
                    date: item['date'] ?? '',
                    hospital: item['hospital'] ?? '',
                    diagnosis: item['diagnosis'] ?? '',
                    size: size,
                    rectum: item['rectum'] ?? '',
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
