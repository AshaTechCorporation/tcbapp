import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcbapp/WidgetHub/dialog/dialogYesNo.dart';
import 'package:tcbapp/constants.dart';
import 'package:tcbapp/home/firstPage.dart';
import 'package:tcbapp/main.dart';
import 'package:tcbapp/pin/pinPage.dart';
import 'package:tcbapp/register/registerPage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
            Text('การตั้งค่า', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Row(
              children: [
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
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/icons/1Artboard 7@4x.png',
                    scale: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            ListTile(
              title: Text(
                'เปลี่ยนรหัส PIN',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                final ok = await showDialog(
                  context: context,
                  builder: (context) => Dialogyesno(
                    title: 'แจ้งเตือน',
                    description: 'คุณต้องการเปลี่ยนรหัส Pin ใช่หรือไม่',
                    pressYes: () {
                      Navigator.pop(context, true);
                    },
                    pressNo: () {
                      Navigator.pop(context);
                    },
                    bottomNameYes: 'ตกลง',
                    bottomNameNo: 'ยกเลิก',
                  ),
                );
                if (ok == true) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => PinPage(
                        check: true,
                      ),
                    ),
                  );
                }
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Version :${version}',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: size.height * 0.52,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton(
                  onPressed: () async {
                    final ok = await showDialog(
                        context: context,
                        builder: (context) => Dialogyesno(
                              title: 'แจ้งเตือน',
                              description: 'คุณต้องการออกจากระบบใช่หรือไม่',
                              pressYes: () {
                                Navigator.pop(context, true);
                              },
                              pressNo: () {
                                Navigator.pop(context);
                              },
                              bottomNameYes: 'ตกลง',
                              bottomNameNo: 'ยกเลิก',
                            ));
                    if (ok == true) {
                      prefs = await SharedPreferences.getInstance();
                      await prefs.setString('cid', '');
                      await prefs.setString('pin', '');
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterPage()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'ออกจากระบบ',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
