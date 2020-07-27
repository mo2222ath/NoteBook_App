import 'package:flutter/material.dart';
import 'package:notebook_task_flutter_mhr/localization/demo_localization.dart';
import 'package:notebook_task_flutter_mhr/models/note.dart';
import 'package:notebook_task_flutter_mhr/screens/screenDetails.dart';

class SearchNote extends SearchDelegate<Note> {
  List<Note> noteList;
  SearchNote(this.noteList);

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryTextTheme: theme.textTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchList = query.isEmpty
        ? noteList
        : noteList
            .where((element) =>
                element.titleNote.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return searchList.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "No Result Found !!",
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.builder(
            itemCount: searchList.length,
            itemBuilder: (BuildContext context, int index) {
              final Note note = searchList[index];
              return ListTile(
                title: Text(note.titleNote),
                onTap: () {
                  navigateToScreenDetails(
                      searchList[index],
                      DemoLocalizations.of(context)
                          .getTranslateValue("editNote"),
                      context);
                },
              );
            },
          );
  }

  void navigateToScreenDetails(
      Note note, String title, BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return screenDetails(note, title);
    }));
  }
}
