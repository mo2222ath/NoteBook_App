import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notebook_task_flutter_mhr/Dialog/confirmation_dialog.dart';
import 'package:notebook_task_flutter_mhr/db_helpers/note_helper.dart';
import 'package:notebook_task_flutter_mhr/models/note.dart';
import 'package:notebook_task_flutter_mhr/screens/screenListNote.dart';

// ignore: camel_case_types, must_be_immutable
class screenDetails extends StatefulWidget {
  final String _titleAppBar;
  final Note note;

  screenDetails(this.note, this._titleAppBar);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return screenDetailsState(this.note, this._titleAppBar);
  }
}

// ignore: camel_case_types
class screenDetailsState extends State<screenDetails> {
  List<String> priority = ["Low", "High"];
  var prioritySelected;
  String _titleAppBar;
  String resultSave;
  Note note;
  var listToLastScreen = ['true'];

  screenDetailsState(this.note, this._titleAppBar);

  NoteHelper noteHelper = NoteHelper();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prioritySelected = priority[0];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = this.note.titleNote;
    descriptionController.text = this.note.descriptionNote;

    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          // Write some code to control things, when user press Back navigation button in device navigationBar
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(this._titleAppBar, style: textStyle),
          ),
          body: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: _createDropdownButton(priority, prioritySelected),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: _createTextFormFiled("Title", "Write Your title here",
                    textStyle, titleController, 1),
              ),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: _createTextFormFiled(
                      "Description",
                      "Write Your description here",
                      textStyle,
                      descriptionController,
                      15)),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: _createButton("Save"),
                      ),
                      Container(
                        width: 10.0,
                      ),
                      Expanded(
                        child: _createButton("Delete"),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  Widget _createDropdownButton(List<String> list, String selected) {
    return DropdownButton<String>(
      items: list.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      value: getPriorityAsString(note.priorityNote),
      onChanged: (String select) {
        setState(() {
          updatePriorityAsInt(select);
        });
      },
    );
  }

  Widget _createTextFormFiled(String label, String hint, TextStyle textStyle,
      var controllerName, var maxLines) {
    return TextFormField(
      style: textStyle,
      maxLines: maxLines,
      controller: controllerName,
      onChanged: (value) {
        if (label == "Title") {
          updateTitle();
        } else {
          updateDescription();
        }
      },
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          )),
    );
  }

  Widget _createButton(String nameOfButton) {
    return RaisedButton(
      color: Theme.of(context).primaryColorDark,
      textColor: Theme.of(context).primaryColorLight,
      child: Text(
        nameOfButton,
        textScaleFactor: 1.5,
      ),
      onPressed: () {
        setState(() {
          if (nameOfButton == "Save") {
            _save();
          } else if (nameOfButton == "Delete") {
            if (note.idNote == null) {
              _delete();
            } else {
              var res = showDialog(
                  context: context,
                  builder: (context) => ConfirmationDialog("Do You Want To Delete !!" ));
              setState(() {
                res.then((value) {
                  if (value == true) {
                    _delete();
                  }
                });
              });
            }
          }
        });
      },
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priorityNote = 1;
        break;
      case 'Low':
        note.priorityNote = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = this.priority[1]; // 'High'
        break;
      case 2:
        priority = this.priority[0]; // 'Low'
        break;
    }
    return priority;
  }

  void updateTitle() {
    note.titleNote = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    note.descriptionNote = descriptionController.text;
  }

  void _save() async {
    note.dateNote = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.idNote != null) {
      // Case 1: Update operation
      result = await noteHelper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      result = await noteHelper.insertNote(note);
    }

    if (result != 0) {
      // Success
      resultSave = 'Status :  Note Saved Successfully';

//      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      resultSave = 'Status : Problem Saving Note';
//      _showAlertDialog('Status', 'Problem Saving Note');
    }
    listToLastScreen.add(resultSave);
//    _showSnackBar(context,resultSave);
    moveToLastScreen();
  }

  void _delete() async {
    moveToLastScreen();
    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (note.idNote == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await noteHelper.deleteNote(note.idNote);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      elevation: 0.5,
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
