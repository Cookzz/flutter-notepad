import 'package:custom_notepad/src/models/note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteForm extends StatefulWidget {
  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notepad')
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: textController,
              validator: (value) {
                if (value.isEmpty){
                  return "Please enter some text";
                }
                return null;
              }
            ),
            RaisedButton(
              child: Text('Submit'),
              onPressed: () {
                final notesModel = context.read<NoteModel>();
                String value = textController.text;

                notesModel.addNote(value);

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}