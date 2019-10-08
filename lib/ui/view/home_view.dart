import 'package:flutter/material.dart';
import 'package:study/core/services/firebase_service.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final service = FirebaseService.getInstance();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service.getWordList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Text("$index");
        },
      ),
    );
  }
}
