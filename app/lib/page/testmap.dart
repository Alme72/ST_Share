import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../design/map_function_item.dart';
import '../flutter_naver_map.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: Container(),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  late EdgeInsets safeArea;
  double drawerHeight = 0;
  late NaverMapController mapController;
  late final List<MapFunctionItem> pages = [];
  NaverMapViewOptions options = const NaverMapViewOptions();
  /* ----- Events ----- */

  void onMapReady(NaverMapController controller) {
    mapController = controller;
  }

  void onMapTapped(NPoint point, NLatLng latLng) {
    // ...
  }

  void onSymbolTapped(NSymbolInfo symbolInfo) {
    // ...
  }

  void onCameraChange(NCameraUpdateReason reason, bool isGesture) {
    // ...
  }

  void onCameraIdle() {
    // ...
  }

  void onSelectedIndoorChanged(NSelectedIndoor? selectedIndoor) {
    // ...
  }

  Widget _cameraMoveTestPage() {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: const [
          //
          // // todo
          // Text("_cameraMoveTestPage"),
          // Text("카메라 이동"),
          //
        ]));
  }

  Widget _controllerTestPage() {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: const [
          // todo
          Text("_etcControllerTestPage"),
          Text("기타 컨트롤러 기능"),
        ]));
  }

  Widget _pickTestPage() {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: const [
          // todo
          Text("_pickTestPage"),
          Text("주변 심볼 및 오버레이 가져오기"),
        ]));
  }

  Widget _mapWidget() {
    final mapPadding = EdgeInsets.only(bottom: drawerHeight - safeArea.bottom);
    return NaverMap(
      options: const NaverMapViewOptions(), // 지도 옵션을 설정할 수 있습니다.
      forceGesture: false, // 지도에 전달되는 제스처 이벤트의 우선순위를 가장 높게 설정할지 여부를 지정합니다.
      onMapReady: (controller) {},
      onMapTapped: (point, latLng) {},
      onSymbolTapped: (symbol) {},
      onCameraChange: (position, reason) {},
      onCameraIdle: () {},
      onSelectedIndoorChanged: (indoor) {},
    );
  }

  Widget _bodyWidget() {
    safeArea = MediaQuery.of(context).padding;
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    //_getMyLocation();
    return Scaffold(
      appBar: _appbarWidget(),
      extendBodyBehindAppBar: true,
      body: _mapWidget(),
    );
  }
}
