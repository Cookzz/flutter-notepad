import 'package:flutter/material.dart';

class DrawerBuilder extends StatelessWidget {
  // final list;

  //provide a default drawer items
  // DrawerBuilder({this.list: const [
  //   {'type': 'header', 'label': '<Maybe some kind of username?>'},
  //   {'type': 'item', 'label': 'Item 1'},
  //   {'type': 'item', 'label': 'Item 2'},
  //   {'type': 'item', 'label': 'Item 3'},
  //   {'type': 'item', 'label': 'Item 4'},
  //   {'type': 'item', 'label': 'Item 5'}
  // ]});
  
  // @override
  // Widget build(BuildContext context){
  //   return Drawer(
  //     child: ListView.builder(
  //       padding: EdgeInsets.zero,
  //       itemCount: list.length,
  //       itemBuilder: (BuildContext ctxt, int index) {
  //         if (list[index]['type'] == 'header'){
  //           return DrawerHeader(
  //             child: Text(list[index]['label']),
  //             decoration: BoxDecoration(
  //               color: Colors.blue
  //             ),
  //           );
  //         } else {
  //           return ListTile(
  //             title: Text(list[index]['label'])
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  final int selectedIndex;

  DrawerBuilder({this.selectedIndex});

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("Some header content here"),
            decoration: BoxDecoration(color: Colors.blue),
          )
        ],
      ),
    );
  }
}