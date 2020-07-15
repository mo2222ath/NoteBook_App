import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:notebook_task_flutter_mhr/models/note.dart';



class NoteHelper{

  static NoteHelper _noteHelper ;
  static Database _database ;

  String tableNote = 'table_note';
  String idNote = 'id';
  String priorityNote = 'priority';
  String titleNote = 'title';
  String descriptionNote = 'description';
  String dateNote = 'date';

  NoteHelper._createInstance();

  factory NoteHelper(){
    if(_noteHelper == null) {
      _noteHelper = NoteHelper._createInstance();
    }
    return _noteHelper;
  }

  Future<Database> getDatabase() async {
    if(_database == null){
      _database = await initializeDB();
    }
    return _database;
  }

  Future<Database> initializeDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var path = directory.path + "NoteMhr.db";

    var databaseNote = await openDatabase(path, version: 1, onCreate: _createDb);
    return databaseNote;
  }

//   Create Database
  void _createDb(Database database, int version) async {
    await database.execute('CREATE TABLE $tableNote($idNote INTEGER PRIMARY KEY AUTOINCREMENT, $titleNote TEXT, '
        '$descriptionNote TEXT, $priorityNote INTEGER, $dateNote TEXT)');
  }

//  Get all Notes from Database ..
  Future<List<Map<String, dynamic>>> getAllNotesFromDB() async {
    Database db = await getDatabase();
    var noteMapList = await db.query(tableNote, orderBy: '$priorityNote ASC');
    return noteMapList;
  }

//  Insert a Note to Database
  Future<int> insertNote(Note note) async {
    Database db = await this.getDatabase();
    var rowNumbers = await db.insert(tableNote, note.toMap());
    return rowNumbers;
  }

//   Update a Note and save it to Database
  Future<int> updateNote(Note note) async {
    var db = await this.getDatabase();
    var rowNumbers = await db.update(tableNote, note.toMap(), where: '$idNote = ?', whereArgs: [note.idNote]);
    return rowNumbers;
  }

//    Delete a Note from Database
  Future<int> deleteNote(int id) async {
    var db = await this.getDatabase();
    int rowNumbers = await db.rawDelete('DELETE FROM $tableNote WHERE $idNote = $id');
    return rowNumbers;
  }

//  Get number of Note in Database
  Future<int> getCount() async {
    Database db = await this.getDatabase();
    List<Map<String, dynamic>> result = await db.rawQuery('SELECT COUNT (*) from $tableNote');
    int rowNumbers = Sqflite.firstIntValue(result);
    return rowNumbers;
  }

  Future<List<Note>> getNotesAsList() async {

    var noteListMap = await getAllNotesFromDB();
    int countNoteList = noteListMap.length;

    List<Note> allNoteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < countNoteList; i++) {
      allNoteList.add(Note.fromMapObject(noteListMap[i]));
    }
    return allNoteList;
  }



}
