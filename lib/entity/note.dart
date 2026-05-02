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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'pinned': pinned,
    };
  }

  bool isPinned() => pinned != null && pinned == 1;
}
