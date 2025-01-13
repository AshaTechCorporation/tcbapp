import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcbapp/WidgetHub/dialog/loadingDialog.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogYesNo.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogyes.dart';
import 'package:tcbapp/home/widgets/CardItem.dart';
import 'package:tcbapp/model/medicalHistory.dart';
import 'package:tcbapp/model/visitedHospitals.dart';
import 'package:tcbapp/notifications/cardnonti.dart';
import 'package:tcbapp/register/registerPage.dart';
import 'package:tcbapp/service/ProjectController.dart';
import 'package:tcbapp/utils/apiException.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    super.key,
  });

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  VisitedHospitals? selectedValue;
  final ScrollController _scrollController = ScrollController();
  String cid = '';
  getPrefs() async {
    final SharedPreferences prefs = await _prefs;
    // await prefs.setString('cid', '1-0000-00001-99-9');
    final cids = prefs.getString('cid');
    setState(() {
      cid = cids ?? '';
    });
  }

  Future getapi() async {
    try {
      LoadingDialog.open(context);
      await context.read<ProjectController>().getAppointment(cid);
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
            Navigator.pop(context);
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return RegisterPage();
            //     },
            //   ),
            // );
          },
          bottomNameYes: 'ตกลง',
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await getapi();
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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: kBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text('การแจ้งเตือน', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/icons/Cancer_AnyWhere.png',
                  scale: 10,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Consumer<ProjectController>(builder: (context, controller, child) {
        final appointments = controller.appointments;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                appointments.isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.5,
                            width: size.width * 1,
                            child: ListView.builder(
                              itemCount: appointments.length ?? 0,
                              itemBuilder: (context, index) {
                                // String formattedLastEntranceDate = '';
                                String formattedDate = '-';
                                if (appointments[index].appoint_date != null) {
                                  try {
                                    DateTime dateTime = DateTime.parse(appointments[index].appoint_date ?? '0');
                                    int buddhistYear = dateTime.year + 543;
                                    formattedDate = '${DateFormat("dd MMMM").format(dateTime)} $buddhistYear';
                                  } catch (e) {
                                    formattedDate = "รูปแบบวันที่ไม่ถูกต้อง";
                                  }
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Cardnonti(
                                    size: size,
                                    appoint_date: formattedDate,
                                    message: appointments[index].message,
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'ไม่มีโรงพยาบาลที่เข้ารับการรักษา',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black45),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        );
      }),
    );
  }
}
