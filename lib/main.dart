import 'package:flutter/material.dart';
import 'src/pages/home.dart';
import 'src/pages/noteform.dart';
import 'src/constants/routes.dart';
import 'package:provider/provider.dart';
import 'src/models/note.dart';

import 'src/components/routebuilder.dart';

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
        }
      },
    );
  }
}