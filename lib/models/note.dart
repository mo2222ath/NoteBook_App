


class Note {

  int _idNote;
  String _titleNote;
  String _descriptionNote;
  String _dateNote;
  int _priorityNote;
  String _colorNote;


  Note(this._titleNote, this._dateNote, this._priorityNote, [this._descriptionNote , this._colorNote]);

  Note.withId(this._idNote, this._titleNote, this._dateNote, this._priorityNote, [this._descriptionNote, this._colorNote]);



  int get idNote => _idNote;

  String get titleNote => _titleNote;

  String get descriptionNote => _descriptionNote;

  int get priorityNote => _priorityNote;

  String get dateNote => _dateNote;

  String get colorNote => _colorNote;

  set titleNote(String newTitle) {
    if (newTitle.length <= 255) {
      this._titleNote = newTitle;
    }
  }

  set descriptionNote(String newDescription) {
    if (newDescription.length <= 255) {
      this._descriptionNote = newDescription;
    }
  }

  set priorityNote(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priorityNote = newPriority;
    }
  }

  set dateNote(String newDate) {
    this._dateNote = newDate;
  }

  set colorNote(String newColor) {
    this._colorNote = newColor;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (idNote != null) {
      map['id'] = _idNote;
    }
    map['title'] = _titleNote;
    map['description'] = _descriptionNote;
    map['priority'] = _priorityNote;
    map['date'] = _dateNote;
    map['color'] = _colorNote;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._idNote = map['id'];
    this._titleNote = map['title'];
    this._descriptionNote = map['description'];
    this._priorityNote = map['priority'];
    this._dateNote = map['date'];
    this._colorNote = map['color'];
  }

  @override
  String toString() {
    return 'Note{_idNote: $_idNote, _titleNote: $_titleNote, _descriptionNote: $_descriptionNote, _dateNote: $_dateNote, _priorityNote: $_priorityNote, _colorNote: $_colorNote}';
  }
}