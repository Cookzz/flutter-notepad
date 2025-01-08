import 'package:flutter/material.dart';

import '../constants/routes.dart';

class DrawerBuilder extends StatefulWidget {
  final list;

  //provide a default drawer items
  DrawerBuilder(
      {this.list = const [
        {'type': 'header', 'label': 'Home'},
        {'type': 'item', 'label': 'Home', 'route': HOME},
        {'type': 'item', 'label': 'Settings', 'route': SETTINGS},
        {'type': 'item', 'label': 'About', 'route': ABOUT},
        // {'type': 'item', 'label': 'Item 3'},
        // {'type': 'item', 'label': 'Item 4'},
        // {'type': 'item', 'label': 'Item 5'}
      ]});

  @override
  State<DrawerBuilder> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerBuilder> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final list = widget.list;

    return Drawer(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: list.length,
        itemBuilder: (BuildContext ctxt, int index) {
          if (list[index]['type'] == 'header') {
            return DrawerHeader(
              child: Text(list[index]['label']),
              decoration: BoxDecoration(color: Colors.blue),
            );
          } else {
            return ListTile(
              title: Text(list[index]['label']),
              selectedColor: Colors.blue,
              selected: index == _selectedIndex,
              onTap: () => {
                setState(() {
                  _selectedIndex = index;
                }),
                Navigator.pushNamed(context, list[index]['route'])
              },
            );
          }
        },
      ),
    );
  }
}
