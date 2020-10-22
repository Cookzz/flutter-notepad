import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../components/drawer.dart';
import '../models/note.dart';
/* constants */
import '../constants/routes.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<NoteModel>(context, listen: false).getAllNotesByName();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notepad')
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: new NoteListBuilder()
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Ink(
                decoration: const ShapeDecoration(
                  color: Colors.lightBlue,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 25,
                  color: Colors.white,
                  tooltip: 'Add Notes',
                  onPressed: () async {
                    await Provider.of<NoteModel>(context, listen: false).clearActiveNote();
                    Navigator.pushNamed(context, ADD_NOTE);
                  },
                )
              )
            ]
          ),
        ],
      ),
      drawer: DrawerBuilder()
    );
  }
}

class NoteListBuilder extends Consumer<NoteModel> {
  NoteListBuilder() :
    super(
      builder: (BuildContext context, NoteModel note, Widget child) =>
        note.notes.isEmpty ? 
        Center(
          child: Text("List is empty")
        ) :
        ListView.builder(
          itemCount: note.notesLength,
          itemBuilder: (BuildContext ctxt, int index) {
            var notes = note.notesList;

            return new Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              secondaryActions: [
                IconSlideAction(
                  caption: 'Edit',
                  color: Colors.grey[300],
                  icon: Icons.edit,
                  onTap: () async {
                    await note.setActiveNote(notes[index].id);
                    Navigator.pushNamed(context, EDIT_NOTE);
                  }
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () async {
                    await note.deleteNote(notes[index].id);
                  }
                )
              ],

              child: InkWell(
                onTap: () async {
                  // print("note id" + notes[index].id.toString());
                  await note.setActiveNote(notes[index].id);
                  Navigator.pushNamed(context, VIEW_NOTE);
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey
                        )
                      )
                  ),
                  constraints: const BoxConstraints(maxHeight:100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        notes[index].title,
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Opacity(
                        opacity: 0.2,
                        child: Divider(
                          color: Colors.black,
                          height: 1, 
                        )
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            notes[index].message,
                            maxLines: null,
                            overflow: TextOverflow.fade,
                          )
                        ),
                      )
                    ],
                  ),
                ),
              )
            );
          },
        ),
    );
}