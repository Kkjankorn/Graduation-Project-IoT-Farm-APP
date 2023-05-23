import 'dart:async';
import 'package:farm_iot/screen/home.dart';
import 'package:farm_iot/screen/information.dart';
import 'package:farm_iot/screen/page1.dart';
import 'package:farm_iot/screen/page2.dart';
import 'package:farm_iot/screen/page3.dart';
import 'package:farm_iot/screen/page4.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}
