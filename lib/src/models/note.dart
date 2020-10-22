import 'package:custom_notepad/src/constants/name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:random_string/random_string.dart' as random_string;

import '../database/app_database.dart';
import 'notes_dao.dart';

/* Old Model with only change notifier */
// class NoteModel extends ChangeNotifier {
//   /*
//     List is an array = []
//     Map is an object = {}

//     List< Map<String, String> > means an array of Objects of String key and String value = [ {"":""} ]
//   */
//   List< Map<String, String> > notes = [];

//   int get totalNotes => notes.length;

//   bool get hasNotes => notes.isNotEmpty;

//   void addNote(Map<String, String> input){
//     notes.add(input);

//     notifyListeners();
//   }

//   void removeNote(int index){
//     notes.removeAt(index);

//     notifyListeners();
//   }

//   void updateNote(int index, List< Map<String, String> > value){
//     notes.replaceRange(index, index+1, value);

//     notifyListeners();
//   }
// }
/* Old Model with only change notifier */

/* New model with sembast implementation */
class NoteModel extends ChangeNotifier {
  final _noteStore = intMapStoreFactory.store(NOTE_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  List<Notes> notes = [];

  Notes activeNotes;

  Future<int> createNewNote(Map<String, String> note) async {
    // Generate a random ID based on the date and a random string for virtual zero chance of duplicates
    int _id = DateTime.now().millisecondsSinceEpoch +
        int.parse(random_string.randomNumeric(2));

    // Create the new note object with an id (makes saving in the future easier)
    Notes newNote = Notes(id: _id, title: note['title'], message: note['message']);

    // Add the note to the database with the specified id
    await _noteStore.record(_id).put(await _db, newNote.toMap());

    // Update the UI by fetching a list of notes from the DB and setting to our provider List
    notes = await getAllNotesByName();

    // Return the ID
    return _id;
  }

  /// Get all notes
  Future<List<Notes>> getAllNotesByName() async {
    // Finder allows for filtering / sorting
    final finder = Finder(sortOrders: [SortOrder('title')]);
    

    // Get the data using our finder for sorting
    final noteSnapshots = await _noteStore.find(
      await _db,
      finder: finder,
    );

    // print("Notes: " + noteSnapshots.toString()); // json of note object

    List<Notes> allNotes = noteSnapshots.map((snapshot) {
      final note = Notes.fromMap(snapshot.value);
      return note;
    }).toList();

    // print("note list: " + noteSnapshots.toString());

    // Update UI
    notes = allNotes;
    notifyListeners();

    return notes;
  }

  /// Get All Notes
  Future<List<Notes>> getAllNotes() async {
    // Finder allows for filtering / sorting
    final finder = Finder();

    // Get the data using our finder for sorting
    final noteSnapshots = await _noteStore.find(
      await _db,
      finder: finder,
    );

    List<Notes> allNotes = noteSnapshots.map((snapshot) {
      final note = Notes.fromMap(snapshot.value);
      return note;
    }).toList();

    // Update UI
    notes = allNotes;
    notifyListeners();

    return notes;
  }

  /// Get A note
  Future<Notes> getNote(int id) async {
    // Get the note JSON from the sembast DB
    var record = await _noteStore.record(id).get(await _db);
    //    print("Record: " + record.toString()); // json of note object

    // Convert to a note Object using the fromMap function
    Notes note = Notes.fromMap(record);
    //    print(
    //        "note id: " + note.id.toString()); // instance of a note object

    return note;
  }

  /// Save Active note Edits
  /// When we edit the activenote object, we can save it to persistent storage in the sembast store
  Future<void> saveActiveNoteEdits() async {
    //    print("Saving Active note, id: " + activeNotes.id.toString());
    //    print("Saving Active note, name: " + activeNotes.name.toString());

    // Create a finder to isolate this note for update, by key (id).
    final finder = Finder(filter: Filter.byKey(activeNotes.id));

    // Perform the update converting, converting the note to map, and updating the value at key identified by the finder
    await _noteStore.update(await _db, activeNotes.toMap(),
        finder: finder);

    // Refresh notes list for UI
    await getAllNotesByName();

    return;
  }

  /// Set Active note
  Future<void> setActiveNote(int id) async {
    activeNotes = await getNote(id);
    //    print("Active note Set, ID: " + activeNotes.id.toString());

    notifyListeners();
    return;
  }

  Future<void> clearActiveNote() async {
    activeNotes = null;

    notifyListeners();
    return;
  }

  /// Delete note
  /// Deletes note from Sembast persistent storage, as well as the UI via a provider update
  Future<void> deleteNote(int id) async {
    // Delete this note from the db
    await _noteStore.record(id).delete(await _db);

    // Refresh notes list for UI
    await getAllNotesByName();

    return;
  }

  /// Get notes Count
  int get notesLength {
    return notes.length;
  }

  /// Get Current Provider List of notes
  List<Notes> get notesList {
    return notes;
  }

  /// Get Active note
  Notes get getActiveNotes {
    return activeNotes;
  }
}