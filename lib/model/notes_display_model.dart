class NotesDisplayModel {
  NotesDisplayModel({
    required this.title,
    required this.description,
    required this.date,
    required this.key,
    required this.category,
  });

  final String title;
  final String description;
  final String date;
  final int category;
  var key;
}
