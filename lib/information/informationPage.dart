import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogyes.dart';
import 'package:tcbapp/WidgetHub/dialog/loadingDialog.dart';
import 'package:tcbapp/WidgetHub/textfiled/InputTextFormField.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/information/widgets/cardHospital.dart';
import 'package:tcbapp/register/registerPage.dart';
import 'package:tcbapp/service/ProjectController.dart';
import 'package:tcbapp/utils/apiException.dart';

class InformationPage extends StatefulWidget {
  InformationPage({
    super.key,
  });

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String cid = '';

  getPrefs() async {
    final SharedPreferences prefs = await _prefs;
    final cids = prefs.getString('cid');
    setState(() {
      cid = cids ?? '';
    });
  }

  Future getapi() async {
    try {
      LoadingDialog.open(context);
      await context.read<ProjectController>().getPatientHistory(cid);
      await context.read<ProjectController>().getlisTreatmenthistory(cid);
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
      LoadingDialog.close(context);
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getPrefs();
      await getapi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor3,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: Consumer<ProjectController>(
        builder: (context, controller, child) {
          final patientHistory = controller.patientHistory;
          final treatmenthistory = controller.treatmentHistorys;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                              patientHistory?.full_name ?? '-',
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
                              patientHistory?.sex_name ?? '-',
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
                              formatNationalID(
                                patientHistory?.cid ?? '-',
                              ),
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
              // Column(
              //   children: [
              //     Row(
              //       children: [
              //         SizedBox(
              //           width: size.width * 0.1,
              //         ),
              //         Text(
              //           'รายละเอียดอื่น ๆ',
              //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //         ),
              //       ],
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //         height: size.height * 0.1,
              //         width: size.width * 0.8,
              //         decoration: BoxDecoration(
              //           color: textColor,
              //           borderRadius: BorderRadius.circular(12),
              //           boxShadow: [
              //             BoxShadow(
              //               color: textColor2.withOpacity(0.2),
              //               spreadRadius: 2,
              //               blurRadius: 8,
              //               offset: Offset(0, 4),
              //             ),
              //           ],
              //         ),
              //         child: Row(
              //           children: [
              //             SizedBox(width: 10),
              //             Icon(
              //               Icons.phone_android,
              //               size: 30,
              //             ),
              //             SizedBox(width: 10),
              //             Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   'เบอร์โทรศัพท์',
              //                   style: TextStyle(fontSize: 14, color: Colors.black54),
              //                 ),
              //                 Text(
              //                   patientHistory?.telephone_1 ?? '',
              //                   style: TextStyle(
              //                     fontSize: 12,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 15,
              ),
              treatmenthistory!.isNotEmpty
                  ? Column(
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
                            itemCount: treatmenthistory?.length ?? 0,
                            itemBuilder: (context, index) {
                              return CardHospital(
                                size: size,
                                hospitalname: treatmenthistory?[index].hospital_name,
                              );
                            },
                          ),
                        )
                      ],
                    )
                  : Text(
                      'ไม่มีโรงพยาบาลที่เข้ารับการรักษา',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black45),
                    )
            ],
          );
        },
      ),
    );
  }
}
