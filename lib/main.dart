import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcbapp/home/firstPage.dart';
import 'package:tcbapp/policy/policyPage.dart';
import 'package:tcbapp/register/registerPage.dart';
import 'package:tcbapp/service/ProjectController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProjectController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Policypage(),
      ),
    );
  }
}
