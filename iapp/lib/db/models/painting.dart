// painting.dart
class Painting {
  final int id;
  final String title;
  final String imagePath;
  final String style;
  final String author;

  Painting({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.style,
    required this.author,
  });

  factory Painting.fromMap(Map<String, dynamic> map) {
    return Painting(
      id: map['paintingId'],
      title: map['title'],
      imagePath: map['imagePath'],
      style: map['style'],
      author: map['author'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paintingId': id,
      'title': title,
      'imagePath': imagePath,
      'style': style,
      'author': author,
    };
  }
}
