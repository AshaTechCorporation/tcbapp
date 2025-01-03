import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogyes.dart';
import 'package:tcbapp/WidgetHub/dialog/loadingDialog.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/home/widgets/CardItem.dart';
import 'package:tcbapp/notifications/notificationsPage.dart';
import 'package:tcbapp/register/registerPage.dart';
import 'package:tcbapp/service/ProjectController.dart';
import 'package:tcbapp/utils/apiException.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getPrefs();
      await getapi();
    });
  }

  String cid = '';
  getPrefs() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('cid', '1-0000-00001-99-9');
    final cids = prefs.getString('cid');
    setState(() {
      cid = cids ?? '';
    });
  }

  Future getapi() async {
    try {
      LoadingDialog.open(context);
      // await context.read<ProjectController>().getlisTreatmenthistory(cid);
      await context.read<ProjectController>().getMedicalHistorys(cid);
      print('/api/app/cancer');
      await context.read<ProjectController>().getPatientHistory(cid);
      print('/api/app/partient');

      if (!mounted) return;
      LoadingDialog.close(context);
    } on ClientException catch (e) {
      if (!mounted) return;
      LoadingDialog.close(context);
      showDialog(
        context: context,
        builder: (context) => Dialogyes(
          title: 'แจ้งเตือน',
          description: '$e',
          pressYes: () {
            Navigator.pop(context, true);
          },
          bottomNameYes: 'ตกลง',
        ),
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      // LoadingDialog.close(context);
      showDialog(
        context: context,
        builder: (context) => Dialogyes(
          title: 'แจ้งเตือน',
          description: '$e',
          pressYes: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return RegisterPage();
                },
              ),
            );
          },
          bottomNameYes: 'ตกลง',
        ),
      );
    }
  }

  String formatNationalID(String id) {
    if (id.length < 3) {
      return id;
    }
    return "${id.substring(0, 4)}******";
  }

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
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
              },
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            )
          ],
        ),
        backgroundColor: kBackgroundColor,
        elevation: 5,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Image.asset(
              'assets/icons/logo MOPH.png',
              scale: 10,
            ),
          ),
        ),
      ),
      body: Consumer<ProjectController>(
        builder: (BuildContext context, controller, child) {
          final medicalHistorys = controller.medicalHistorys;
          final patientHistory = controller.patientHistory;
          return Column(
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
                                // patientHistory?.full_name ?? '-',
                                '',
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
                                // patientHistory?.sex_name ?? '-',
                                '',
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
                                // formatNationalID(
                                //   patientHistory?.cid ?? '-',
                                // ),

                                '',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //SizedBox(height: 10),
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
                  controller: _scrollController,
                  itemCount: medicalHistorys?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = medicalHistorys?[index];

                    // ตรวจสอบและแปลง diagnosis_date เป็นวันเดือนปีแบบ พ.ศ.
                    String formattedDate = '-';
                    String formattedLastEntranceDate = '';
                    if (item?.diagnosis_date != null) {
                      try {
                        DateTime dateTime = DateTime.parse(item!.diagnosis_date!);
                        int buddhistYear = dateTime.year + 543;
                        formattedDate = '${DateFormat("d MMMM").format(dateTime)} $buddhistYear';
                      } catch (e) {
                        formattedDate = "รูปแบบวันที่ไม่ถูกต้อง";
                      }
                    }
                    if (item?.last_entrance_date != null) {
                      try {
                        DateTime dateTime = DateTime.parse(item!.last_entrance_date!);
                        int buddhistYear = dateTime.year + 543;
                        formattedLastEntranceDate = '${DateFormat("d MMMM").format(dateTime)} $buddhistYear';
                      } catch (e) {
                        formattedDate = "รูปแบบวันที่ไม่ถูกต้อง";
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: CardItem(
                        date: formattedDate, // ใช้วันที่ที่แปลงแล้ว
                        hospital: item?.hospital_name ?? '',
                        diagnosis: item?.icd10_text ?? '',
                        size: size,
                        medicalHistorys: item?.treatments, last_entrance_date: formattedLastEntranceDate ?? '',
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
