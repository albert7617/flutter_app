import 'package:flutter/rendering.dart';
import 'package:flutter_app/theme.dart';
import 'package:flutter_app/fragment_new_doc.dart';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("New Document", Icons.note_add),
    new DrawerItem("View Document", Icons.format_list_bulleted),
    new DrawerItem("Delete Document", Icons.delete),
    new DrawerItem("Print Document", Icons.print),
    new DrawerItem("About", Icons.info)
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;
  String _user = "Please sign in";

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new NewDocPage();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: colorPrimary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: new AppDrawer(user: _user, drawerOptions: drawerOptions),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
    @required String user,
    @required this.drawerOptions,
  }) : _user = user, super(key: key);

  final String _user;
  final List<Widget> drawerOptions;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: colorPrimaryDark),
            currentAccountPicture: SquareAvatar(),
            accountName: GestureDetector(onTap: () {Navigator.pushNamed(context, "login_activity");},child: Text(_user)),
            accountEmail: null,
          ),
          Column(children: drawerOptions)
        ],
      )
    );
  }
}

class SquareAvatar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SquareAvatarState();
  }
}

class SquareAvatarState extends State<SquareAvatar> {
  List<bool> _field = List.filled(49, false);
  int _age;
  Color _cC, _bC;

  void updateIdenticon(String s) {
    setState(() {
      _age = 0;
      String _seed = s;
      var _digest = md5.convert(utf8.encode(s)).bytes;
      _cC = _color(_digest);
      _bC = Color((0x1ff << 24) - _cC.value);
      _field = _buildField(_digest);
    });
  }

  Color _color(List<int> dig) {
    final double hue =
        _map((((dig[12] & 0xf) << 8) | dig[13]), 0, 0xfff, 0, 360);
    final double sat = (65 - _map(dig[14], 0, 0xff, 0, 20)) / 100;
    final double lig = (75 - _map(dig[15], 0, 0xff, 0, 20)) / 100;
    return HSLColor.fromAHSL(1.0, hue, sat, lig).toColor();
  }

  double _map(int value, int vmin, int vmax, int dmin, int dmax) =>
      ((value - vmin) * (dmax - dmin)) / ((vmax - vmin) + dmin);

  List<bool> _buildField(List<int> dig) {
    final f = List<bool>.filled(49, false);
    final List<bool> pt = dig
        .fold<List<int>>([], (acc, cur) => acc..add(cur ~/ 16)..add(cur & 15))
        .map<bool>((i) => (i % 2) == 0)
        .toList();
    int i = 0;
    for (int c = 3; c >= 1; c--) {
      for (int r = 1; r < 6; r++) {
        f[r * 7 + c] = pt[i];
        f[r * 7 + 6 - c] = pt[i];
        i++;
      }
    }
    _age = 0;
    return f;
  }

  @override
  Widget build(BuildContext context) {
    updateIdenticon("404415041");
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "login_activity");
      },
      child: Container(
          width: 60.0,
          height: 60.0,
          child: Container(
              padding: EdgeInsets.all(0),
              color: _bC,
              child: GridView.count(
                  crossAxisCount: 7,
                  children: List<Widget>.generate(
                      49,
                      (i) => Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Container(color: _field[i] ? _cC : _bC)))))),
    );
  }
}
