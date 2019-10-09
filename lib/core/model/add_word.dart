import 'package:flutter/material.dart';

class WordAddView extends StatefulWidget {
  @override
  _WordAddViewState createState() => _WordAddViewState();
}

class _WordAddViewState extends State<WordAddView> {
  GlobalKey<FormState> _key = GlobalKey(debugLabel: "registerForm");
// random image key  https://source.unsplash.com/1600x900/?nature,water

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                RaisedButton(
                  shape: StadiumBorder(),
                  child: Container(
                    width: 100,
                    alignment: Alignment.center,
                    child: Text("Send Data"),
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ));
  }
}
