class Word {
  String image;
  String name;
  String key;

  Word({this.image, this.name});

  Word.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}

class WordList {
  List<Word> list = [];

  WordList.fromJsonList(Map json) {
    json.forEach((key, value) {
      var data = Word.fromJson(value);
      data.key = key;
      list.add(data);
    });
  }
}
