import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
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
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  VisitedHospitals? selectedValue;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // อย่าลืม dispose เมื่อไม่ใช้
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await getapi();
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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            nontificatione.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.5,
                            width: size.width * 0.9,
                            child: ListView.builder(
                              itemCount: nontificatione.length ?? 0,
                              itemBuilder: (context, index) {
                                return Cardnonti(
                                  size: size,
                                  title: nontificatione[index]['title'],
                                  detail: nontificatione[index]['detaile'],
                                  nonti: nontificatione[index]['time'],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Text(
                    'ไม่มีโรงพยาบาลที่เข้ารับการรักษา',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black45),
                  )
          ],
        ),
      ),
    );
  }
}
