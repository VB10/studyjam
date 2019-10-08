import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:study/core/model/word.dart';

class FirebaseService {
  static FirebaseService _instance = FirebaseService._privateInit();
  FirebaseService._privateInit() {
    _baseUrl = "https://fluttertr-ead5c.firebaseio.com/";
  }

  static FirebaseService getInstance() {
    if (_instance == null) {
      _instance = FirebaseService._privateInit();
    }
    return _instance;
  }

  String _baseUrl = "";

  Future<void> getWordList() async {
    final response = await http.get(_baseUrl + "words.json");

    final jsonData = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        print(jsonData);
        var list = Word.fromJsonList(jsonData);
        return list;
      default:
        return Future.error(jsonData);
    }
  }
}
