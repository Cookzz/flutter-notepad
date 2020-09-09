import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class NoteModel extends ChangeNotifier {
  List<String> notes = [];
  String test = "Test";

  int get totalNotes => notes.length;

  bool get hasNotes => notes.isNotEmpty;

  void addNote(String input){
    notes.add(input);

    notifyListeners();
  }
}