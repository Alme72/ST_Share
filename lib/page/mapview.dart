// ignore: unused_import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  void initState() {
    super.initState();
  }

  late KakaoMapController mapController;
  final TextEditingController _textEditingController = TextEditingController();
  late EdgeInsets safeArea;

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: TextFormField(
          controller: _textEditingController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "주소를 입력하세요",
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) {},
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _bodyWidget() {
    return SnappingSheet(
      grabbingHeight: 40,
      grabbing: Container(
        height: 56,
        color: Colors.white,
        alignment: Alignment.center,
        child: const Text('지도 리스트'),
      ),
      sheetBelow: SnappingSheetContent(
        sizeBehavior: const SheetSizeFill(),
        draggable: true,
        child: Container(
          height: 56,
          //color: Colors.grey[300],
          alignment: Alignment.center,
          child: KakaoMap(
            onMapCreated: ((controller) {
              mapController = controller;
            }),
          ),
        ),
      ),
      snappingPositions: const [
        SnappingPosition.factor(
          positionFactor: 0.0,
          snappingCurve: Curves.easeOutExpo,
          snappingDuration: Duration(seconds: 1),
          grabbingContentOffset: GrabbingContentOffset.top,
        ),
        SnappingPosition.pixels(
          positionPixels: 500,
          snappingCurve: Curves.elasticOut,
          snappingDuration: Duration(milliseconds: 1750),
        ),
        SnappingPosition.factor(
          positionFactor: 1.0,
          snappingCurve: Curves.bounceOut,
          snappingDuration: Duration(seconds: 1),
          grabbingContentOffset: GrabbingContentOffset.bottom,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    safeArea = MediaQuery.of(context).padding;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      appBar: _appbarWidget(),
      extendBodyBehindAppBar: true,
      body: KakaoMap(
        onMapCreated: ((controller) {
          mapController = controller;
        }),
      ), //_bodyWidget(),
    );
  }
}
