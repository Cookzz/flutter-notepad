import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/drawer.dart';
import '../models/note.dart';

class Home extends StatelessWidget {

  Widget _buildList() {
    return
      Consumer<NoteModel>(
        builder: (context, note, child) => 
          ListView.builder(
            itemCount: note.totalNotes,
            itemBuilder: (BuildContext ctxt, int index) {
              return new Text(note.notes[index]);
            },
          ),
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
                onPressed: () {
                  Navigator.pushNamed(context, '/add');
                },
              )
            ]
          ),
        ],
      ),
      drawer: DrawerBuilder()
    );
  }
}