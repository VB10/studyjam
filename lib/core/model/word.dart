class Word {
  String image;
  String name;

  List<Word> list;
  Word({this.image, this.name});

  Word.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
  }

  Word.fromJsonList(List json) {
    list = json.map((fields) => Word.fromJson(fields)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}

// class WordList {
//   List<Word> list;

//   List<Word> fromJsonList(List json) {
//     return json.map((fields) => Word.fromJson(fields)).toList();
//   }
// }
