import 'package:flutter/material.dart';
import 'package:tcbapp/WidgetHub/textfiled/InputTextFormField.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/information/widgets/cardHospital.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
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
            Text('ข้อมูลของฉัน', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/icons/logo MOPH.png',
                  scale: 10,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Container(
                //   padding: EdgeInsets.all(2),
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     border: Border.all(
                //       color: avatarColor,
                //       width: 3.0,
                //     ),
                //   ),
                //   child: CircleAvatar(
                //     radius: 30,
                //     backgroundColor: textColor,
                //     child: Icon(
                //       Icons.person_outline,
                //       color: avatarColor,
                //       size: 40,
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 15),
                        Text(
                          'ชื่อ : ',
                          style: TextStyle(color: textColor2, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '***** *****',
                          style: TextStyle(color: textColor2),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        SizedBox(width: 15),
                        Text(
                          'เพศ : ',
                          style: TextStyle(color: textColor2, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'ชาย',
                          style: TextStyle(color: textColor2),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        SizedBox(width: 15),
                        Text(
                          'เลข ID : ',
                          style: TextStyle(color: textColor2, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '3-1021-00144-94-8',
                          style: TextStyle(color: textColor2),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Text(
                    'รายละเอียดอื่น ๆ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: size.height * 0.1,
                  width: size.width * 0.8,
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
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(
                        Icons.phone_android,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'เบอร์โทรศัพท์',
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          Text(
                            '098*******',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Text(
                    'โรงพยาบาลที่เคยเข้าการรักษา',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.4,
                width: size.width * 0.85,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return CardHospital(
                      size: size,
                      hospitalname: items[index],
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
