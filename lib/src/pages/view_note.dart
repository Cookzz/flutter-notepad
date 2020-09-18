import 'package:custom_notepad/src/models/note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyNote extends StatelessWidget {
  final int index;

  MyNote(this.index);

  Widget build(BuildContext context) {
    final notes = Provider.of<NoteModel>(context, listen: false).notes;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          notes[index].title, 
          maxLines: 1,
          overflow: TextOverflow.ellipsis
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: ConstrainedBox(
              constraints: new BoxConstraints(minHeight: constraints.maxHeight, minWidth: constraints.maxWidth),
              child: Flexible(
                child: Text(
                  notes[index].title,
                  maxLines: null,
                ),
              )
            )
          );
        }
      )
    );
  }
}