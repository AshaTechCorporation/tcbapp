import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:tcbapp/SplashScreenPage.dart';

class CheckUpdatePage extends StatefulWidget {
  const CheckUpdatePage({super.key});

  @override
  State<CheckUpdatePage> createState() => _CheckUpdatePageState();
}

class _CheckUpdatePageState extends State<CheckUpdatePage> {
  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) {
    final newVersion = NewVersionPlus(
      iOSId: 'com.nci.tcbmobile',
      androidId: 'com.nci.erpmobile',
      // 'com.app.canceranywhere',
      androidPlayStoreCountry: 'th_TH',
      iOSAppStoreCountry: 'th_TH',
    );
    advancedStatusCheck(newVersion);
    // } else {
    //   Timer(Duration(seconds: 1), () {
    //     fristLoad();
    //   });
    // }
  }

  Future<void> fristLoad() async {
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SplashScreenPage()),
      (route) => false,
    );
  }

  advancedStatusCheck(NewVersionPlus newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      if (status.canUpdate) {
        if (!mounted) return;
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: 'ตรวจสอบการอัพเดทใหม่',
          dialogText: 'คุณต้องการอัพเดทแอพพลิเคชั่นเวอร์ชั่น ${status.localVersion} เป็น ${status.storeVersion} หรือไม่?',
          updateButtonText: 'อัพเดท',
          dismissButtonText: 'ไว้ทีหลัง',
          dismissAction: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SplashScreenPage()), (route) => false),
          launchModeVersion: LaunchModeVersion.external,
        );
      } else {
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SplashScreenPage()),
          (route) => false,
        );
      }
    } else {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashScreenPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
