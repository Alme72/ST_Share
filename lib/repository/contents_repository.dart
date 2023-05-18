import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  static late String userId;
  late String name = "홍길동";
  late String password;
  static late String jwt;

  Map<String, dynamic> toJson() {
    return {
      'username': userId,
      //'name': name,
    };
  }
}

class ContentsRepository {
  List<Map<String, dynamic>> data = [];
  Map<String, dynamic> datas = {
    "sell": [
      {
        "id": 14,
        "image": [
          "https://ubuntu.i4624.tk/image/imageid/100042",
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Coke-300x300.jpg",
          "https://www.tylenolprofessional.com/sites/tylenol_hcp_us/files/sample-display-image/tylenol-product-samples600x600.jpg",
        ],
        "boardWriter": "22",
        "boardTitle": "22",
        "boardContents": "22",
        "location": "서울",
        "price": 20000,
        "boardHits": 2,
        "boardCreatedTime": "2023-03-24T18:31:47.576233",
        "boardUpdatedTime": "2023-03-31T09:25:00",
      },
      {
        "id": 15,
        "image": [
          "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
          "https://images.pexels.com/photos/4158/apple-iphone-smartphone-desk.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
          "https://images.pexels.com/photos/1738641/pexels-photo-1738641.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        ],
        "boardWriter": "test123",
        "boardTitle": "안녕하세요",
        "boardContents": "ㅇㅇㅇ",
        "location": "강남",
        "price": 25000,
        "boardHits": 7,
        "boardCreatedTime": "2023-03-28T19:32:48.417641",
        "boardUpdatedTime": "2023-03-31T09:25:00",
      },
      {
        "id": 16,
        "image": [
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Pepsi-300x300.jpg",
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Coke-300x300.jpg",
          "https://www.tylenolprofessional.com/sites/tylenol_hcp_us/files/sample-display-image/tylenol-product-samples600x600.jpg",
        ],
        "boardWriter": "input",
        "boardTitle": "test",
        "boardContents": "슈퍼 해머드릴",
        "location": "부천시 경인로",
        "price": 120000,
        "boardHits": 10,
        "boardCreatedTime": "2023-03-28T10:59:10.492566",
        "boardUpdatedTime": "2023-03-31T09:25:00",
      },
      {
        "id": 16,
        "image": [
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Pepsi-300x300.jpg",
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Coke-300x300.jpg",
          "https://www.tylenolprofessional.com/sites/tylenol_hcp_us/files/sample-display-image/tylenol-product-samples600x600.jpg",
        ],
        "boardWriter": "input",
        "boardTitle": "test",
        "boardContents": "슈퍼 해머드릴",
        "location": "부천시 경인로",
        "price": 120000,
        "boardHits": 10,
        "boardCreatedTime": "2023-03-28T10:59:10.492566",
        "boardUpdatedTime": "2023-03-31T09:25:00",
      },
      {
        "id": 16,
        "image": [
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Pepsi-300x300.jpg",
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Coke-300x300.jpg",
          "https://www.tylenolprofessional.com/sites/tylenol_hcp_us/files/sample-display-image/tylenol-product-samples600x600.jpg",
        ],
        "boardWriter": "input",
        "boardTitle": "test",
        "boardContents": "슈퍼 해머드릴",
        "location": "부천시 경인로",
        "price": 120000,
        "boardHits": 10,
        "boardCreatedTime": "2023-03-28T10:59:10.492566",
        "boardUpdatedTime": "2023-03-31T09:25:00",
      },
      {
        "id": 16,
        "image": [
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Pepsi-300x300.jpg",
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Coke-300x300.jpg",
          "https://www.tylenolprofessional.com/sites/tylenol_hcp_us/files/sample-display-image/tylenol-product-samples600x600.jpg",
        ],
        "boardWriter": "input",
        "boardTitle": "test",
        "boardContents": "슈퍼 해머드릴",
        "location": "부천시 경인로",
        "price": 120000,
        "boardHits": 10,
        "boardCreatedTime": "2023-03-28T10:59:10.492566",
        "boardUpdatedTime": "2023-03-31T09:25:00",
      },
    ],
    "buy": [
      {
        "id": 14,
        "image": [
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Pepsi-300x300.jpg",
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Coke-300x300.jpg",
          "https://www.tylenolprofessional.com/sites/tylenol_hcp_us/files/sample-display-image/tylenol-product-samples600x600.jpg",
        ],
        "boardWriter": "22",
        "boardTitle": "22",
        "boardContents": "22",
        "location": "서울",
        "price": 20000,
        "boardHits": 2,
        "boardCreatedTime": "2023-03-24T18:31:47.576233",
        "boardUpdatedTime": "2023-03-31T09:25:00",
      },
      {
        "id": 15,
        "image": [
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Pepsi-300x300.jpg",
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Coke-300x300.jpg",
          "https://www.tylenolprofessional.com/sites/tylenol_hcp_us/files/sample-display-image/tylenol-product-samples600x600.jpg",
        ],
        "boardWriter": "test123",
        "boardTitle": "안녕하세요",
        "boardContents": "ㅇㅇㅇ",
        "location": "강남",
        "price": 25000,
        "boardHits": 7,
        "boardCreatedTime": "2023-03-28T19:32:48.417641",
        "boardUpdatedTime": "2023-03-31T09:25:00",
      },
      {
        "id": 16,
        "image": [
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Pepsi-300x300.jpg",
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Coke-300x300.jpg",
          "https://www.tylenolprofessional.com/sites/tylenol_hcp_us/files/sample-display-image/tylenol-product-samples600x600.jpg",
        ],
        "boardWriter": "input",
        "boardTitle": "test",
        "boardContents": "슈퍼 해머드릴",
        "location": "부천시 경인로",
        "price": 120000,
        "boardHits": 10,
        "boardCreatedTime": "2023-03-28T10:59:10.492566",
        "boardUpdatedTime": "2023-03-31T09:25:00",
      }
    ],
    "rental": [
      {
        "id": 14,
        "image": [
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Pepsi-300x300.jpg",
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Coke-300x300.jpg",
          "https://www.tylenolprofessional.com/sites/tylenol_hcp_us/files/sample-display-image/tylenol-product-samples600x600.jpg",
        ],
        "boardWriter": "22",
        "boardTitle": "22",
        "boardContents": "22",
        "location": "서울",
        "price": 20000,
        "boardHits": 2,
        "boardCreatedTime": "2023-03-24T18:31:47.576233",
        "boardUpdatedTime": "2023-03-31T09:25:00",
      },
      {
        "id": 15,
        "image": [
          //{imageSererURL}+"/"+"100022",
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Coke-300x300.jpg",
          "https://www.tylenolprofessional.com/sites/tylenol_hcp_us/files/sample-display-image/tylenol-product-samples600x600.jpg",
        ],
        "boardWriter": "test123",
        "boardTitle": "안녕하세요",
        "boardContents": "ㅇㅇㅇ",
        "location": "강남",
        "price": 25000,
        "boardHits": 7,
        "boardCreatedTime": "2023-03-28T19:32:48.417641",
        "boardUpdatedTime": "2023-03-31T09:25:00",
      },
      {
        "id": 16,
        "image": [
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Pepsi-300x300.jpg",
          "https://greendroprecycling.com/wp-content/uploads/2017/04/GreenDrop_Station_Aluminum_Can_Coke-300x300.jpg",
          "https://www.tylenolprofessional.com/sites/tylenol_hcp_us/files/sample-display-image/tylenol-product-samples600x600.jpg",
        ],
        "boardWriter": "input",
        "boardTitle": "test",
        "boardContents": "슈퍼 해머드릴",
        "location": "부천시 경인로",
        "price": 120000,
        "boardHits": 10,
        "boardCreatedTime": "2023-03-28T10:59:10.492566",
        "boardUpdatedTime": "2023-03-31T09:25:00",
      }
    ],
  };
  //String serverURL = "https://ubuntu.i4624.tk/image/imageid/";

  List<Map<String, dynamic>> tempData = [
    {
      "id": 14,
      "image": [100085, 100086, 100087],
      "boardWriter": "22",
      "boardTitle": "22",
      "boardContents": "22",
      "location": "서울",
      "price": 20000,
      "boardHits": 2,
      "boardCreatedTime": "2023-03-24T18:31:47.576233",
      "boardUpdatedTime": "2023-03-31T09:25:00",
      "boardCategory": "sell",
      "productCategory": "",
    },
    {
      "id": 15,
      "image": [100085, 100086, 100087],
      "boardWriter": "test123",
      "boardTitle": "안녕하세요",
      "boardContents": "ㅇㅇㅇ",
      "location": "강남",
      "price": 25000,
      "boardHits": 7,
      "boardCreatedTime": "2023-03-28T19:32:48.417641",
      "boardUpdatedTime": "2023-03-31T09:25:00",
      "boardCategory": "sell",
    },
    {
      "id": 16,
      "image": [100085, 100086, 100087],
      "boardWriter": "input",
      "boardTitle": "test",
      "boardContents": "슈퍼 해머드릴",
      "location": "부천시 경인로",
      "price": 120000,
      "boardHits": 10,
      "boardCreatedTime": "2023-03-28T10:59:10.492566",
      "boardUpdatedTime": "2023-03-31T09:25:00",
      "boardCategory": "sell",
    },
    {
      "id": 14,
      "image": [100085, 100086, 100087],
      "boardWriter": "22",
      "boardTitle": "22",
      "boardContents": "22",
      "location": "서울",
      "price": 20000,
      "boardHits": 2,
      "boardCreatedTime": "2023-03-24T18:31:47.576233",
      "boardUpdatedTime": "2023-03-31T09:25:00",
      "boardCategory": "buy",
    },
    {
      "id": 15,
      "image": [100085, 100086, 100087],
      "boardWriter": "test123",
      "boardTitle": "안녕하세요",
      "boardContents": "ㅇㅇㅇ",
      "location": "강남",
      "price": 25000,
      "boardHits": 7,
      "boardCreatedTime": "2023-03-28T19:32:48.417641",
      "boardUpdatedTime": "2023-03-31T09:25:00",
      "boardCategory": "buy",
    },
    {
      "id": 16,
      "image": [100085, 100086, 100087],
      "boardWriter": "input",
      "boardTitle": "test",
      "boardContents": "슈퍼 해머드릴",
      "location": "부천시 경인로",
      "price": 120000,
      "boardHits": 10,
      "boardCreatedTime": "2023-03-28T10:59:10.492566",
      "boardUpdatedTime": "2023-03-31T09:25:00",
      "boardCategory": "buy",
    },
    {
      "id": 14,
      "image": [100085, 100086, 100087],
      "boardWriter": "22",
      "boardTitle": "22",
      "boardContents": "22",
      "location": "서울",
      "price": 20000,
      "boardHits": 2,
      "boardCreatedTime": "2023-03-24T18:31:47.576233",
      "boardUpdatedTime": "2023-03-31T09:25:00",
      "boardCategory": "rental",
    },
    {
      "id": 15,
      "image": [100085, 100086, 100087],
      "boardWriter": "test123",
      "boardTitle": "안녕하세요",
      "boardContents": "ㅇㅇㅇ",
      "location": "강남",
      "price": 25000,
      "boardHits": 7,
      "boardCreatedTime": "2023-03-28T19:32:48.417641",
      "boardUpdatedTime": "2023-03-31T09:25:00",
      "boardCategory": "rental",
    },
    {
      "id": 16,
      "image": [100085, 100086, 100087],
      "boardWriter": "input",
      "boardTitle": "test",
      "boardContents": "슈퍼 해머드릴",
      "location": "부천시 경인로",
      "price": 120000,
      "boardHits": 10,
      "boardCreatedTime": "2023-03-28T10:59:10.492566",
      "boardUpdatedTime": "2023-03-31T09:25:00",
      "boardCategory": "rental",
    }
  ];

  void jsonToData() {
    for (var i = 0; i < data.length; i++) {
      var item = data[i];
      //datas[item['image']] = serverURL + item['image'];
      if (datas[item['boardCategory']] == null) {
        datas[item['boardCategory']] = [item];
      } else {
        datas[item['boardCategory']]!.add(item);
      }
    }
  }

  Future<String?> getJWT() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }

  Future<List<Map<String, dynamic>>> loadData() async {
    var uri = Uri.parse('https://ubuntu.i4624.tk/api/v1/post/list');
    final headers = {'Authorization': 'Bearer ${getJWT()}'};
    final response = await http
        .post(
          uri,
          headers: headers,
        )
        .timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      final List<dynamic> responseData =
          jsonDecode(utf8.decode(response.bodyBytes));
      data = responseData
          .map((dynamic item) => Map<String, dynamic>.from(item))
          .toList();
      jsonToData();
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Map<String, dynamic>>> loadContentsFromLocation(
      String location) async {
    //await loadData();
    //jsonToData();
    return datas[location]!;
  }
}
