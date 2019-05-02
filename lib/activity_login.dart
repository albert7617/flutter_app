import 'package:flutter/rendering.dart';
import 'package:flutter_app/theme.dart';
import 'package:flutter_app/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: colorPrimary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  Dio dio = new Dio();
  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(microseconds: 5000));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.bounceOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold is structure to define app bar and stuff
    return new Scaffold(
      backgroundColor: Colors.greenAccent,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            //mainAxisAlignment means vertical
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlutterLogo(
                size: _iconAnimation.value * 100,
              ),
              new Form(
                  child: Theme(
                    data: new ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.teal,
                        inputDecorationTheme: new InputDecorationTheme(
                            labelStyle:
                            new TextStyle(color: Colors.teal, fontSize: 20.0))),
                    child: new Container(
                      padding: const EdgeInsets.all(40.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new TextFormField(
                            decoration:
                            new InputDecoration(labelText: "Enter Email"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          new TextFormField(
                            decoration:
                            new InputDecoration(labelText: "Enter Password"),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          new Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                          ),
                          new MaterialButton(
                            height: 40.0,
                            minWidth: 100.0,
                            color: Colors.teal,
                            textColor: Colors.white,
                            child:new Icon(
                                Icons.arrow_right
                            ),
                            onPressed: ()=>{},
                            splashColor: Colors.redAccent,
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
//  @override
//  Widget build(BuildContext context) {
////    final prefs = SharedPreferences.getInstance();
//    getData();
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          title,
//          style: TextStyle(color: Colors.white),
//        ),
//        backgroundColor: colorPrimary,
//        iconTheme: IconThemeData(color: Colors.white),
//      ),
//      body: Center(child: Text("Hello login")),
//    );
//  }

  void getData() async {
    Response response;

    response = await dio.get(url_home);
    print(response.data.toString());
  }
}