import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_project/page/control.dart';
// ignore: unused_import
import 'package:test_project/page/login.dart';

void main() async {
  AuthRepository.initialize(appKey: 'adeca8a5da950f64e0c27d3e89e9329b');
  permission();
  runApp(const MyApp());
}

Future<bool> permission() async {
  Map<Permission, PermissionStatus> status =
      await [Permission.location].request(); // [] 권한배열에 권한을 작성

  if (await Permission.location.isGranted) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
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
      home: const Control(),
    );
  }
}
