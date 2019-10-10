import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
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

  Future<List<Word>> getWordList() async {
    final response = await http.get(_baseUrl + "words.json");

    final jsonData = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        print(jsonData);
        var words = WordList.fromJsonList(jsonData).list;
        return words;
      default:
        return Future.error(jsonData);
    }
  }

  Future<bool> postWord({Word data}) async {
    data.image = "https://source.unsplash.com/1600x900/?${data.image},water";
    var jsonData = json.encode(data.toJson());
    final response =
        await http.post(_baseUrl + "words.json", body: jsonData);

    switch (response.statusCode) {
      case HttpStatus.ok:
        Logger().i(response.body);
        return true;
      default:
        Logger().e(response.body);
        return false;
      // return Future.error(jsonData);
    }
  }

  Future<bool> removeWord({String key}) async {
    final response = await http.delete(_baseUrl + "words/$key.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
        Logger().i(response.body);
        return true;
      default:
        Logger().e(response.body);
        return false;
      // return Future.error(jsonData);
    }
  }
}
