import 'package:flutter/material.dart';
import 'package:notebook_task_flutter_mhr/Dialog/confirmation_dialog.dart';
import 'package:notebook_task_flutter_mhr/Dialog/dialog_about.dart';
import 'package:notebook_task_flutter_mhr/db_helpers/note_helper.dart';
import 'package:notebook_task_flutter_mhr/localization/demo_localization.dart';
import 'package:notebook_task_flutter_mhr/models/language.dart';
import 'package:notebook_task_flutter_mhr/models/note.dart';
import 'package:notebook_task_flutter_mhr/screens/screenDetails.dart';
import 'package:notebook_task_flutter_mhr/screens/search_note.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

// ignore: camel_case_types
class screenListNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
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
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    // final TextTheme = TextStyle()

    // TextStyle textStyle = Theme.of(context).textTheme.headline6;
    TextStyle textStyle = TextStyle(
      fontSize: 30,
      // fontFamily: "Orbitron",
      fontFamily: "Caveat",
      letterSpacing: 1.5,
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            DemoLocalizations.of(context).getTranslateValue("title"),
            style: TextStyle(fontSize: 50, fontFamily: "Caveat"),
          ),
        ),
        actions: <Widget>[
          // * Language Button
          Padding(
              padding: EdgeInsets.only(top: 8),
              child: DropdownButton(
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                underline: SizedBox(),
                items: Language.listLanguage()
                    .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                          value: lang,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                lang.flag,
                                style: TextStyle(
                                    fontSize: 25,
                                    // fontFamily: "Orbitron",
                                    fontFamily: "Caveat"),
                              ),
                              Text(lang.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      // fontFamily: "Orbitron",
                                      fontFamily: "Caveat")),
                            ],
                          ),
                        ))
                    .toList(),
//                onTap: () {},
                onChanged: (Language language) {
                  changeLanguage(language);
                },
              )),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: IconButton(
              tooltip: "About",
              icon: const Icon(Icons.info),
              onPressed: () async {
                await showDialog(
                    context: context, builder: (context) => ShowAbout());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: IconButton(
              tooltip: DemoLocalizations.of(context)
                  .getTranslateValue("tooltipSearch"),
              icon: const Icon(Icons.search),
              onPressed: () async {
                await showSearch(
                    context: context, delegate: SearchNote(noteList));
              },
            ),
          ),
        ],
      ),
      body: _createListView(count, textStyle),
      //* Add Button
      floatingActionButton: _createFloatingActionButton(),
      //* Drawer Button
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset(
                'images/NoteImg.png',
                height: 120,
                width: 120,
              ),
              decoration: BoxDecoration(
                color: Colors.white12,
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                title: Text(
                  DemoLocalizations.of(context).getTranslateValue("about"),
                  style: TextStyle(
                      fontSize: 30,
                      // fontFamily: "Orbitron",
                      fontFamily: "Caveat"),
                ),
                onTap: () {
                  showDialog(
                      context: context, builder: (context) => ShowAbout());
//                  res.then((value) =>  print("Id that was loaded: $value"));
                }),
          ],
        ),
      ),
    );
  }

  void changeLanguage(Language language) {
    Locale temp;
    switch (language.langCode) {
      case 'en':
        temp = Locale(language.langCode, "US");
        break;
      case 'ar':
        temp = Locale(language.langCode, "YE");
        break;
      default:
        temp = Locale(language.langCode, "US");
    }
    MyApp.setLocale(context, temp);
  }

  Widget _createListView(int count, TextStyle textStyle) {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
            color: getCardColor(noteList[position].colorNote),
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    getPriorityColor(this.noteList[position].priorityNote),
                child: getPriorityIcon(this.noteList[position].priorityNote),
              ),
              title: Text(this.noteList[position].titleNote, style: textStyle),
              subtitle: Text(
                this.noteList[position].dateNote,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Caveat",
                  letterSpacing: 1.5,
                ),
              ),
              trailing: GestureDetector(
                child: Icon(Icons.delete),
                onTap: () {
                  var res = showDialog(
                      context: context,
                      builder: (context) => ConfirmationDialog(
                          DemoLocalizations.of(context)
                              .getTranslateValue("ConfirmationDialog")));
//                  res.then((value) =>  print("Id that was loaded: $value"));
                  setState(() {
                    res.then((value) {
                      if (value == true) {
                        _deleteNote(context, this.noteList[position]);
                      }
                    });
                  });
                },
              ),
              onTap: () {
//                debugPrint("List Tapped !! $position");
                navigateToScreenDetails(
                    this.noteList[position],
                    DemoLocalizations.of(context)
                        .getTranslateValue("editNote"));
              },
            ));
      },
    );
  }

  Widget _createFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
//        debugPrint('clicked');
        navigateToScreenDetails(Note('', '', 2),
            DemoLocalizations.of(context).getTranslateValue("addNote"));
      },
      tooltip: DemoLocalizations.of(context).getTranslateValue("tooltipAdd"),
      backgroundColor: Colors.tealAccent,
      foregroundColor: Colors.black45,
      child: Icon(Icons.note_add),
    );
  }

  void navigateToScreenDetails(Note note, String title) async {
    var res =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return screenDetails(note, title);
    }));

    setState(() {
      if (res == true) {
//        _showSnackBar(context,'Moaaz');
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
      _showSnackBar(
          context, DemoLocalizations.of(context).getTranslateValue("msgDel"));
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Color getPriorityColor(int priority) {
    if (priority == 1) {
      return Colors.lime;
    } else {
      return Colors.white38;
    }
  }

  Icon getPriorityIcon(int priority) {
    if (priority == 1) {
      return Icon(Icons.priority_high);
    } else {
      return Icon(Icons.low_priority);
    }
  }

  Color getCardColor(var favColor) {
    if (favColor == "Red") {
      return Colors.red;
    } else if (favColor == "Green") {
      return Colors.green;
    } else if (favColor == "Pink") {
      return Colors.pink;
    } else {
      return Colors.grey;
    }
  }
}
