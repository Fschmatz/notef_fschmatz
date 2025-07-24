class Note {
  int? id;
  String? title;
  String? text;
  int? pinned;

  Note(this.id, this.title, this.text, this.pinned);

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      map['id'] as int?,
      map['title'] as String?,
      map['text'] as String?,
      map['pinned'] as int?,
    );
  }

  bool isPinned() => pinned != null && pinned == 1;
}
