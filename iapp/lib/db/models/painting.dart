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

  factory Painting.fromMap(Map<String, dynamic> json) => new Painting(
        id: json['paintingId'],
        title: json['title'],
        imagePath: json['imagePath'],
        style: json['style'],
        author: json['author'],
      );

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
