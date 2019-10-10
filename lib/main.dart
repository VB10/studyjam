import 'package:flutter/material.dart';
import 'package:study/ui/view/home_view.dart';
import 'package:flutter/services.dart';
import 'package:study/ui/view/splash_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      title: 'Flutter Study Jam',
      home: SplashView(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/splash': (BuildContext context) => new SplashView(),
        '/home': (BuildContext context) => new HomeView(),
      }, // Hiding debug flag
    );
  }
}
