import 'package:flutter/material.dart';
import 'package:notebook_task_flutter_mhr/screens/screenDetails.dart';
import 'package:notebook_task_flutter_mhr/screens/screenListNote.dart';



void main() => runApp(MyApp());


class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "NoteBook",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
          brightness: Brightness.dark
      ),
      home: screenListNote(),
    );
  }

}
