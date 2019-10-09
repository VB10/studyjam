class Word {
  String image;
  String name;

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
  List<Word> list;

  WordList.fromJsonList(List json) {
    list = json.map((fields) => Word.fromJson(fields)).toList();
  }
}
