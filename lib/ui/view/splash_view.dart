import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashView extends StatefulWidget {
  SplashView({Key key}) : super(key: key);

  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  startTimeout() async {
    var duration = const Duration(seconds: 3);
    return new Timer(duration, () {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (r) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimeout();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          /*   crossAxisAlignment: CrossAxisAlignment.center, */
          children: <Widget>[
            SvgPicture.asset('assets/flutter.svg',
                semanticsLabel: 'Flutter Logo',
                placeholderBuilder: (BuildContext context) => Container(child: const CircularProgressIndicator())),
            SizedBox(height: 30),
            Text(
              'TODO APP',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
