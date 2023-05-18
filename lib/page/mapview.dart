// ignore: unused_import
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
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

  // 샘플 코드
  late KakaoMapController _mapController;
  late final LatLng _startPoint = LatLng(37.5666102, 126.9783881);
  late final LatLng _endPoint = LatLng(80.5666102, 150.9783881);
  List<LatLng> _routeCoordinates = [];
  String apiKey = 'adeca8a5da950f64e0c27d3e89e9329b';

  Future<void> _searchPublicTransitRoutes() async {
    final url = Uri.parse('https://dapi.kakao.com/v2/local/geo/transcoord.json'
        '?x=${_startPoint.longitude}&y=${_startPoint.latitude}&input_coord=WGS84&output_coord=TM');
    final response =
        await http.get(url, headers: {'Authorization': 'KakaoAK $apiKey'});
    final startResponse = json.decode(response.body);

    final startTmX = startResponse['documents'][0]['x'];
    final startTmY = startResponse['documents'][0]['y'];

    final url2 = Uri.parse('https://dapi.kakao.com/v2/local/geo/transcoord.json'
        '?x=${_endPoint.longitude}&y=${_endPoint.latitude}&input_coord=WGS84&output_coord=TM');
    final response2 =
        await http.get(url2, headers: {'Authorization': 'KakaoAK $apiKey'});
    final endResponse = json.decode(response2.body);

    final endTmX = endResponse['documents'][0]['x'];
    final endTmY = endResponse['documents'][0]['y'];

    final routeUrl = Uri.parse(
        'https://dapi.kakao.com/v2/local/geo/transit.json'
        '?startX=$startTmX&startY=$startTmY&endX=$endTmX&endY=$endTmY&startCoordType=TM&endCoordType=TM');
    final routeResponse =
        await http.get(routeUrl, headers: {'Authorization': 'KakaoAK $apiKey'});
    final routeData = json.decode(routeResponse.body);

    final documents = routeData['documents'] as List<dynamic>;
    final route = documents.first['route'] as Map<String, dynamic>;
    final traoptimal = route['traoptimal'] as List<dynamic>;
    final path = traoptimal.first['path'] as List<dynamic>;
    setState(() {
      _routeCoordinates = path.map<LatLng>((point) {
        final x = point['x'];
        final y = point['y'];
        return LatLng(y, x);
      }).toList();
    });
    _mapController.addPolyline();
//   _mapController.addPolyline(Polyline(
//   polylineId: const PolylineId('route'),
//   points: _routeCoordinates,
//   color: Colors.blue,
//   width: 3,
// ));
    // 수정: _mapController -> mapController
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
          color: Colors.grey[300],
          alignment: Alignment.center,
          child: Container(
            child: Column(
              children: [
                const TextField(),
                const TextField(),
                TextButton(
                  onPressed: () {
                    _searchPublicTransitRoutes();
                  },
                  child: const Text("test"),
                )
              ],
            ),
          ), //리스트 내용물
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
      child: KakaoMap(
        onMapCreated: ((controller) {
          mapController = controller;
        }),
        polylines: const <Polyline>[
          // Polyline(
          //   polylineId: ,
          //   points: _routeCoordinates, // 수정: _routeCoordinates -> routeCoordinates
          //   fillColor: Colors.blue,
          //   strokeColor: Colors.blue,
          //   strokeWidth: 3,
          // ),
        ],
      ),
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
      body: _bodyWidget(),
    );
  }
}
