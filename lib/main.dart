import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:barbers_demo/presentation/home/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xffFF8585),
          accentColor: Color(0xffFF8585),
        ),
        home: HomeView());
  }
}
