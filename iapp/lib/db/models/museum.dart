import 'dart:convert';

class Museum {
  final int id;
  final String name;
  final String location;
  final List<String> imagePaths;
  final String description;
  final List<String> mainAttractions;

  Museum({
    required this.id,
    required this.name,
    required this.location,
    required this.imagePaths,
    required this.description,
    required this.mainAttractions,
  });

  factory Museum.fromMap(Map<String, dynamic> map) {
    return Museum(
      id: map['museumId'],
      name: map['name'],
      location: map['location'],
      imagePaths: List<String>.from(json.decode(map['imagePaths'])),
      description: map['description'],
      mainAttractions: List<String>.from(json.decode(map['mainAttractions'])),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'museumId': id,
      'name': name,
      'location': location,
      'imagePaths': json.encode(imagePaths),
      'description': description,
      'mainAttractions': json.encode(mainAttractions),
    };
  }
}
