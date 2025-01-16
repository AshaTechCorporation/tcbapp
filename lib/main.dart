import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcbapp/SplashScreenPage.dart';
import 'package:tcbapp/firebase_options.dart';
import 'package:tcbapp/home/firstPage.dart';
import 'package:tcbapp/home/homePage.dart';
import 'package:tcbapp/policy/policyPage.dart';
import 'package:tcbapp/register/registerPage.dart';
import 'package:tcbapp/service/ProjectController.dart';

String? cids;
String? pin;
late SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = await SharedPreferences.getInstance();
  cids = prefs.getString('cid');
  pin = prefs.getString('pin');
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('bf2534c7-5047-4ffb-924f-e614cae776f0');
  OneSignal.Notifications.requestPermission(true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'th';
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProjectController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cancer Anywhere 2025',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        supportedLocales: [
          // Locale('en', 'US'),
          Locale('th', 'TH'),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale('th', 'TH'),
        home: SplashScreenPage(),
      ),
    );
  }
}
