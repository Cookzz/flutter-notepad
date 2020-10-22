import 'package:custom_notepad/src/models/note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyNote extends StatelessWidget {
  MyNote();

  Widget build(BuildContext context) {
    final note = Provider.of<NoteModel>(context, listen: false).getActiveNotes;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          //note title here, 
          note.title,
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
              child: Text(
                  note.message,
                  maxLines: null,
                ),
            )
          );
        }
      )
    );
  }
}