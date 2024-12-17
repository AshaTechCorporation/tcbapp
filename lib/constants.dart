import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xff01DDBA);
const textColor = Colors.white;
const textColor2 = Colors.black;
const kBackgroundColor2 = Color(0xff03C4CB);
const avatarColor = Color(0xff115A44);
const kBackgroundColor3 = Color(0xffF2FCFB);

List<Map<String, String>> cardItems = [
  {
    'date': '18/10/2567',
    'hospital': 'สถาบันมะเร็งแห่งชาติ',
    'diagnosis':
        'C20: Malignant neoplasm of the rectum, which is a type of colorectal cancer characterized by the uncontrolled and abnormal proliferation of malignant epithelial cells in the rectal mucosa, often leading to invasive growth into adjacent tissues and potential metastasis to regional lymph nodes, the liver, lungs, or other distant organs through hematogenous or lymphatic spread.',
    'rectum':
        'rectum (เนื้องอกร้ายที่ลำไส้ใหญ่ส่วนตรง (เร็คตัม) ซึ่งเป็นความผิดปกติของเซลล์ที่แบ่งตัวอย่างควบคุมไม่ได้ ทำให้เกิดก้อนเนื้อที่อาจแพร่กระจายไปยังอวัยวะข้างเคียงหรือส่วนอื่นของร่างกาย หากไม่ได้รับการรักษาอย่างทันท่วงที)',
  },
  {
    'date': '26/07/2567',
    'hospital': 'สถาบันมะเร็งแห่งชาติ',
    'diagnosis':
        'C20:  Malignant neoplasm of the rectum, which is a type of colorectal cancer characterized by the uncontrolled and abnormal proliferation of malignant epithelial cells in the rectal mucosa, often leading to invasive growth into adjacent tissues and potential metastasis to regional lymph nodes, the liver, lungs, or other distant organs through hematogenous or lymphatic spread',
    'rectum':
        'rectum (เนื้องอกร้ายที่ลำไส้ใหญ่ส่วนตรง (เร็คตัม) ซึ่งเป็นความผิดปกติของเซลล์ที่แบ่งตัวอย่างควบคุมไม่ได้ ทำให้เกิดก้อนเนื้อที่อาจแพร่กระจายไปยังอวัยวะข้างเคียงหรือส่วนอื่นของร่างกาย หากไม่ได้รับการรักษาอย่างทันท่วงที)',
  },
  {
    'date': '09/07/2567',
    'hospital': 'สถาบันมะเร็งแห่งชาติ',
    'diagnosis': 'C20: Malignant neoplasm of rectum',
    'rectum': 'rectum (เนื้องอกร้ายที่ลำไส้ใหญ่ส่วนตรง(เร็คตัม))',
  },
  {
    'date': '09/07/2567',
    'hospital': 'สถาบันมะเร็งแห่งชาติ',
    'diagnosis': 'C20: Malignant neoplasm of rectum',
    'rectum': 'rectum (เนื้องอกร้ายที่ลำไส้ใหญ่ส่วนตรง(เร็คตัม))',
  },
  {
    'date': '09/07/2567',
    'hospital': 'สถาบันมะเร็งแห่งชาติ',
    'diagnosis': 'C20: Malignant neoplasm of rectum',
    'rectum': 'rectum (เนื้องอกร้ายที่ลำไส้ใหญ่ส่วนตรง(เร็คตัม))',
  },
  {
    'date': '09/07/2567',
    'hospital': 'สถาบันมะเร็งแห่งชาติ',
    'diagnosis': 'C20: Malignant neoplasm of rectum',
    'rectum': 'rectum (เนื้องอกร้ายที่ลำไส้ใหญ่ส่วนตรง(เร็คตัม))',
  },
  {
    'date': '09/07/2567',
    'hospital': 'สถาบันมะเร็งแห่งชาติ',
    'diagnosis': 'C20: Malignant neoplasm of rectum',
    'rectum': 'rectum (เนื้องอกร้ายที่ลำไส้ใหญ่ส่วนตรง(เร็คตัม))',
  },
  {
    'date': '09/07/2567',
    'hospital': 'สถาบันมะเร็งแห่งชาติ',
    'diagnosis': 'C20: Malignant neoplasm of rectum',
    'rectum': 'rectum (เนื้องอกร้ายที่ลำไส้ใหญ่ส่วนตรง(เร็คตัม))',
  },
  {
    'date': '09/07/2567',
    'hospital': 'สถาบันมะเร็งแห่งชาติ',
    'diagnosis': 'C20: Malignant neoplasm of rectum',
    'rectum': 'rectum (เนื้องอกร้ายที่ลำไส้ใหญ่ส่วนตรง(เร็คตัม))',
  },
  {
    'date': '09/07/2567',
    'hospital': 'สถาบันมะเร็งแห่งชาติ',
    'diagnosis': 'C20: Malignant neoplasm of rectum',
    'rectum': 'rectum (เนื้องอกร้ายที่ลำไส้ใหญ่ส่วนตรง(เร็คตัม))',
  },
];
final List<String> items = ['โรงพยาบาล', 'โรงพยาบาลมหาวิทยาลัยนวมินทราธิราช ศูนย์การแพทย์วิภาวดีรังสิต'];

List<Map<String, String>> cardNews = [
  {
    'date': '18/10/2567',
    'title': 'สถาบันมะเร็งแห่งชาติ',
    'detail':
        'C20: Malignant neoplasm of the rectum, which is a type of colorectal cancer characterized by the uncontrolled and abnormal proliferation of malignant epithelial cells in the rectal mucosa, often leading to invasive growth into adjacent tissues and potential metastasis to regional lymph nodes, the liver, lungs, or other distant organs through hematogenous or lymphatic spread.',
  },
  {
    'date': '18/10/2567',
    'title': 'สถาบันมะเร็งแห่งชาติ',
    'detail':
        'C20: Malignant neoplasm of the rectum, which is a type of colorectal cancer characterized by the uncontrolled and abnormal proliferation of malignant epithelial cells in the rectal mucosa, often leading to invasive growth into adjacent tissues and potential metastasis to regional lymph nodes, the liver, lungs, or other distant organs through hematogenous or lymphatic spread.',
  },
];


// onTap: () async {
//                 await showDialog(
//                     context: context,
//                     builder: (context) => Dialogyesno(
//                           title: 'แจ้งเตือน',
//                           description: 'Test',
//                           pressYes: () {
//                             Navigator.pop(context);
//                           },
//                           pressNo: () {
//                             Navigator.pop(context);
//                           },
//                           bottomNameYes: 'ตกลง',
//                           bottomNameNo: 'ยกเลิก',
//                         ));
//               },

