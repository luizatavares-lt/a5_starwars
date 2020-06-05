import 'package:flutter/material.dart';

import 'routes.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _addDrawerItem(
            Icons.home,
            'Home',
            () => Navigator.pushReplacementNamed(context, Routes.home),
          ),
          _addDrawerItem(
            Icons.assignment,
            'Raças',
            () => Navigator.pushReplacementNamed(context, Routes.personagensRaca),
          ),
          _addDrawerItem(
            Icons.person,
            'Personagens',
            () => Navigator.pushReplacementNamed(context, Routes.personagens),
          ),
          _addDrawerItem(
            Icons.map,
            'Planetas',
            () => Navigator.pushReplacementNamed(context, Routes.planetas),
          ),
        ],
      ),
    );
  }
}

Widget _addDrawerItem(_icon, _text, _onTap) {
  return ListTile(
    contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
    title: Row(
      children: <Widget>[
        Icon(_icon),
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(_text),
        ),
      ],
    ),
    onTap: _onTap,
  );
}
