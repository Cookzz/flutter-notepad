import 'package:flutter/material.dart';
import 'src/components/drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Notepad',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final notes = List<String>();

  addNotes(){
    setState(() {
      notes.add('a');
    });
  }

  Widget _buildList() {
    return notes.isNotEmpty ? 
      ListView.builder(
        itemCount: notes.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Text(notes[index]);
        },
      ) :
      Center(
        child: Text('List is currently empty'),
      );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notepad')
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildList()
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.add),
                iconSize: 30,
                tooltip: 'Add Notes',
                onPressed: addNotes,
              )
            ]
          ),
        ],
      ),
      drawer: DrawerBuilder()
    );
  }
}