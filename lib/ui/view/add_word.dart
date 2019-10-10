import 'package:flutter/material.dart';
import 'package:study/core/model/word.dart';
import 'package:study/core/services/firebase_service.dart';

class WordAddView extends StatefulWidget {
  @override
  _WordAddViewState createState() => _WordAddViewState();
}

class _WordAddViewState extends State<WordAddView> {
  GlobalKey<FormState> _key = GlobalKey(debugLabel: "registerForm");
  GlobalKey<ScaffoldState> _statekey = GlobalKey(debugLabel: "state");
  final service = FirebaseService.getInstance();

// random image key
  TextEditingController controllerWord = TextEditingController();
  TextEditingController controllerImage = TextEditingController();

  bool isLoading = false;
  int lastIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    lastIndex = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        key: _statekey,
        appBar: AppBar(),
        body: Form(
          key: _key,
          autovalidate: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: controllerWord,
                  decoration: InputDecoration(
                    helperText: "Add",
                    labelText: "Word",
                    enabledBorder: OutlineInputBorder(),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Bu alan bos gecilemez";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: controllerImage,
                  decoration: InputDecoration(
                    helperText: "Add",
                    labelText: "Image",
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  shape: StadiumBorder(),
                  child: AnimatedContainer(
                    width:isLoading ? 50 : 100,
                    height: isLoading ? 50 :75,
                    curve: Curves.easeInCubic,
                    alignment: Alignment.center,
                    duration: Duration(milliseconds: 100),
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text("Send data"),
                  ),
                  onPressed: isLoading ? null : saveWordData,
                )
              ],
            ),
          ),
        ));
  }

  Future<void> saveWordData() async {
    print(lastIndex);
    if (_key.currentState.validate()) {
      final word = Word(name: controllerWord.text, image: controllerImage.text);
      setState(() {
        isLoading = true;
      });
      bool isPostOkey = await service.postWord(data: word);
      setState(() {
        isLoading = false;
      });
      if (isPostOkey) {
        Navigator.of(context).pop();
      } else {
        _statekey.currentState.showSnackBar(SnackBar(
          content: Text("Bir hata ile karsilasildi."),
        ));
      }
    }
  }
}
