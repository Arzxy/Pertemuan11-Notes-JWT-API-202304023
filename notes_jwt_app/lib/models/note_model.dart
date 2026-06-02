class Note {

  final String id;
  final String title;
  final String content;

  Note({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Note.fromJson(map) {

    return Note(

      id: map['id'].toString(),

      title: map['title'],

      content: map['content'],
    );
  }
}