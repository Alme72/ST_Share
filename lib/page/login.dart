import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/page/control.dart';
import 'package:http/http.dart' as http;

import '../repository/contents_repository.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController userId = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  String? jwt;
  //List<Map<String, dynamic>> temp = [];

  // 앱내에 JWT 저장
  Future<void> saveJWT(String jwt, String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt', jwt);
    prefs.setString('userId', userId);
  }

  Future<String?> getJWT() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('jwt'));
    return prefs.getString('jwt');
  }

  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId')!;
    setState(() {
      UserInfo.userId = userId;
    });
    return UserInfo.userId;
  }

  Future<String?> _sendDataToServer({
    required String userId,
    required String password,
  }) async {
    final uri = Uri.parse('https://ubuntu.i4624.tk/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'username': userId, 'password': password});
    final response = await http
        .post(
          uri,
          headers: headers,
          body: body,
        )
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final responseHeader = response.headers;
      if (responseHeader.isEmpty) {
        print("responseBody is Empty");
      }
      setState(() {
        final getToken = responseHeader['authorization']!;
        jwt = getToken.replaceFirst("Bearer ", "");
        print(jwt);
      });
      return jwt;
    } else {
      print(response.reasonPhrase);
      jwt = null;
      return throw Exception('Failed to send data');
    }
  }

  // JWT를 변수에 저장(어플 종료 후 삭제)
  Future<void> _saveJWT() async {
    jwt = await _sendDataToServer(
      userId: userId.text,
      password: userPassword.text,
    );
    if (jwt != null) {
      saveJWT(jwt!, userId.text);
      getUserId();
    } else {
      jwt = null;
    }
  }

  Future<void> _base64Test() async {
    await getJWT();
    List<String> tokenParts = jwt!.split('.');
    //List<int> decodedBytes = base64.decode(base64EncodedData);
    String decodedString = utf8.decode(base64Url.decode(tokenParts[1]));
    print(decodedString);
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: const Text('로그인'),
      elevation: 0.0,
      backgroundColor: Colors.blueAccent,
      centerTitle: true,
    );
  }

  Widget _bodyWidget() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 50)),
            const Center(
              child: Image(
                image: AssetImage("assets/images/ex1.png"),
                width: 170.0,
              ),
            ),
            Form(
              child: Theme(
                data: ThemeData(
                  primaryColor: Colors.grey,
                  inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(40.0),
                  child: Builder(
                    builder: (context) {
                      return Column(
                        children: [
                          TextField(
                            controller: userId,
                            decoration:
                                const InputDecoration(labelText: 'ID 입력'),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextField(
                            controller: userPassword,
                            decoration:
                                const InputDecoration(labelText: '비밀번호 입력'),
                            keyboardType: TextInputType.text,
                            obscureText: true, // 비밀번호 안보이도록 하는 것
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ButtonTheme(
                              minWidth: 100.0,
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await _saveJWT();
                                    if (jwt != null) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Control(),
                                        ),
                                      );
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    0, 20, 0, 5),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  "ID 또는 패스워드를 확인해주세요.",
                                                ),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              Center(
                                                child: SizedBox(
                                                  width: 250,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateColor
                                                              .resolveWith(
                                                        (states) {
                                                          if (states.contains(
                                                              MaterialState
                                                                  .disabled)) {
                                                            return Colors.grey;
                                                          } else {
                                                            return Colors.blue;
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    child: const Text("확인"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  } catch (e) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  0, 20, 0, 5),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const [
                                              Text(
                                                "서버와의 통신이 불안정합니다.",
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            Center(
                                              child: SizedBox(
                                                width: 250,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateColor
                                                            .resolveWith(
                                                      (states) {
                                                        if (states.contains(
                                                            MaterialState
                                                                .disabled)) {
                                                          return Colors.grey;
                                                        } else {
                                                          return Colors.blue;
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  child: const Text("확인"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                ),
                                child: const Text("로그인"),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _saveJWT();
                _base64Test();
              },
              child: const Text("테스트"),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}

void showSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(
    content: text,
    backgroundColor: const Color.fromARGB(255, 112, 48, 48),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
