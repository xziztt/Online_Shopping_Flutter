import 'package:flutter/material.dart';

class DrawerItemBuilder extends StatelessWidget {
  final Function onTapexec;
  final String title;
  DrawerItemBuilder(this.title, this.onTapexec);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 25),
      ),
      onTap: onTapexec,
    );
  }
}
