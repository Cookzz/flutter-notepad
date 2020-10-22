/* dependencies */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* pages */
import 'src/pages/home.dart';
import 'src/pages/note_form.dart';
import 'src/pages/view_note.dart';

/* constants */
import 'src/constants/routes.dart';

/* models */
import 'src/models/note.dart';

/* components */
import 'src/components/route_builder.dart';

void main() => {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteModel(),
      child: MyApp()
    )
  )
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Notepad',
      initialRoute: '/',
      // routes: {
      //   '/': (context) => Home(),
      //   '/add': (context) => NoteForm()
      // },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name){
          case HOME:
            return SlideFromRightRoute(page: Home());
          case ADD_NOTE:
            return SlideFromRightRoute(page: NoteForm());
          case EDIT_NOTE:
            return SlideFromRightRoute(page: NoteForm());
          case VIEW_NOTE:
            return SlideFromRightRoute(page: MyNote());
          default:
            return SlideFromRightRoute(page: Home());
        }
      },
    );
  }
}