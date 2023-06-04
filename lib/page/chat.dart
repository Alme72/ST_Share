import 'package:flutter/material.dart';

import '../repository/contents_repository.dart';
import 'keyboardKey.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late String amount = '';
  late String currentLocation;

  //앱 내에서 좌측 상단바 출력을 위한 데이터
  final Map<String, String> optionsTypeToString = {
    "setting": "PIN 설정",
    "unlock": "PIN 해제",
  };
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    currentLocation = "setting";
    isLoading = false;
    amount = '';
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          ContentsRepository().loadData();
        },
        child: PopupMenuButton<String>(
          offset: const Offset(0, 30),
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              1),
          onSelected: (String value) {
            setState(() {
              currentLocation = value;
            });
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: "setting",
                child: Text("PIN 설정"),
              ),
              const PopupMenuItem(
                value: "unlock",
                child: Text("PIN 해제"),
              ),
            ];
          },
          //좌측 상단 판매, 구매, 대여 선택바
          child: Row(
            children: [
              //앱 내에서 좌측 상단바 출력을 위한 데이터
              Text(
                optionsTypeToString[currentLocation]!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white, //const Color.fromARGB(255, 184, 210, 255),
      elevation: 1.5, // 그림자를 표현되는 높이 3d 측면의 높이를 뜻함.
      actions: [
        // IconButton(
        //   onPressed: () {},
        //   icon: const Icon(
        //     Icons.search,
        //     color: Colors.black,
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final keys = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['', '0', const Icon(Icons.keyboard_backspace)],
  ];

  onNumberPress(val) {
    setState(() {
      amount = amount + val;
    });
  }

  onBackspacePress(val) {
    setState(() {
      amount = amount.substring(0, amount.length - 1);
    });
  }

  renderKeyboard() {
    return keys
        .map(
          (x) => Row(
            children: x.map((y) {
              return Expanded(
                child: KeyboardKey(
                  label: y,
                  onTap: y is Widget ? onBackspacePress : onNumberPress,
                  value: y,
                ),
              );
            }).toList(),
          ),
        )
        .toList();
  }

  renderConfirmButton() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              padding: const EdgeInsets.only(top: 3, left: 3),
              decoration: const BoxDecoration(
                //borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 132, 204, 252),
              ),
              child: MaterialButton(
                onPressed: () {},
                minWidth: double.infinity,
                height: 55,
                child: const Text(
                  "확인",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                // child: const Padding(
                //   padding: EdgeInsets.symmetric(vertical: 16.0),
                //   child: Text(
                //     '확인',
                //     style: TextStyle(
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  renderText() {
    String display = 'PIN 번호';
    TextStyle style = const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 50.0,
        letterSpacing: 15);

    if (amount.isNotEmpty) {
      display = amount;
      style = style.copyWith(
        color: Colors.black,
      );
    } else {
      style = const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
          letterSpacing: 5);
    }

    return Expanded(
      child: Center(
        child: Text(
          display,
          style: style,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            children: [
              renderText(),
              ...renderKeyboard(),
              Container(height: 16.0),
              renderConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }
}
