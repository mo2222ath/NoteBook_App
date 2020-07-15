import 'package:flutter/material.dart';
import 'package:notebook_task_flutter_mhr/db_helpers/note_helper.dart';
import 'package:notebook_task_flutter_mhr/models/note.dart';
import 'package:notebook_task_flutter_mhr/screens/screenDetails.dart';
import 'package:sqflite/sqflite.dart';

// ignore: camel_case_types
class screenListNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return screenListNoteState();
  }
}

// ignore: camel_case_types
class screenListNoteState extends State<screenListNote> {
  NoteHelper noteHelper = NoteHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: _createListView(count, textStyle),
      floatingActionButton: _createFloatingActionButton(),
    );
  }

  Widget _createListView(int count, TextStyle textStyle) {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
            color: Colors.teal,
            elevation: 2.0,
            child: ListTile(
              leading: Icon(Icons.keyboard_arrow_up),
              title: Text(this.noteList[position].titleNote, style: textStyle),
              subtitle:
                  Text(this.noteList[position].dateNote, style: textStyle),
              trailing: GestureDetector(
                child: Icon(Icons.delete),
                onTap: () {
                  _deleteNote(context, this.noteList[position]);
                },
              ),
              onTap: () {
                debugPrint("List Tapped !! $position");
                navigateToScreenDetails(this.noteList[position], "Edit Note");
              },
            ));
      },
    );
  }

  Widget _createFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        debugPrint('clicked');
        navigateToScreenDetails(Note('', '', 2), "Add Note");
      },
      tooltip: 'Add Note !',
      backgroundColor: Colors.tealAccent,
      foregroundColor: Colors.black45,
      child: Icon(Icons.note_add),
    );
  }

  void navigateToScreenDetails(Note note, String title) async {
    var res = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return screenDetails(note, title);
    }));

    setState(() {
      if (res == true) {
        updateListView();
      }
    });
  }

  updateListView() {
    final Future<Database> dbFuture = noteHelper.initializeDB();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = noteHelper.getNotesAsList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void _deleteNote(BuildContext context, Note note) async {
    int result = await noteHelper.deleteNote(note.idNote);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully !!');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
