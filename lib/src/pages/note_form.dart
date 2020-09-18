import 'package:custom_notepad/src/models/note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteForm extends StatefulWidget {
  final int noteIndex;

  NoteForm([this.noteIndex = -1]);

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notepad')
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(15),
            child: new NoteFormFieldBuilder(widget.noteIndex), //context seems to be automatically inherited/handled to a child widget)
          )
        )
      ),
    );
  }
}

class NoteFormFieldBuilder extends StatelessWidget {
  final noteIndex;
  NoteFormFieldBuilder(this.noteIndex);
  
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NoteModel>(context, listen: false).notes; 

    String title = (noteIndex != -1) ? notes[noteIndex].title : null;
    String message = (noteIndex != -1) ? notes[noteIndex].title : null;

    final titleController = TextEditingController(text: title);
    final messageController = TextEditingController(text: message);

    return 
      Column(
        children: <Widget>[
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Add a title',
              labelText: 'Title'
            ),
            validator: (value) {
              if (value.isEmpty){
                return "Please enter some text";
              }
              return "Text please";
            }
          ),
          TextFormField(
            controller: messageController,
            decoration: const InputDecoration(
              hintText: 'Talk about something!',
              labelText: 'Message'
            ),
            validator: (value) {
              if (value.isEmpty){
                return "Please enter some text";
              }
              return null;
            },
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: () {
              final notesModel = context.read<NoteModel>();

              String title = titleController.text;
              String message = messageController.text;

              if (noteIndex == -1){
                notesModel.createNewNote({
                  "title": title,
                  "message": message
                });
              } else {
                // notesModel.updateNote(
                //   noteIndex, 
                //   [{"title": title, "message": message}]
                // );
              }

              Navigator.pop(context);
            },
          ),
        ],
      );
  }
}