import 'package:flutter/material.dart';
import 'package:study/ui/view/home_view.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      title: 'Material App',
      home: HomeView(),
      debugShowCheckedModeBanner: false, // Hiding debug flag
    );
  }
}
