import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
// ignore: unused_import
import 'package:test_project/page/login.dart';

void main() async {
  AuthRepository.initialize(appKey: 'adeca8a5da950f64e0c27d3e89e9329b');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "STS",
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LogIn(),
    );
  }
}
