import 'package:flutter/material.dart';
import 'package:flutter_app/activity_login.dart';
import 'activity_home.dart';

void main() {
//  debugPaintSizeEnabled=true;
//  debugPaintLayerBordersEnabled = true;
//  debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: HomePage(),
      routes: <String, WidgetBuilder> {
        'login_activity': (BuildContext context) => new LoginActivity(),
      },
    );
  }
}

