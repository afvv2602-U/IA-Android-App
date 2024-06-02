// search_page.dart
import 'package:flutter/material.dart';
import 'package:iapp/db/queries/painting_queries.dart';
import 'package:iapp/db/models/painting.dart';
import 'package:iapp/widgets/home/painting_card.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<Painting>> _paintings;
  late Future<List<String>> _styles;
  late Future<List<String>> _authors;
  String? _filterStyle;
  String? _filterAuthor;

  @override
  void initState() {
    super.initState();
    _paintings = PaintingQueries().getPaintings();
    _styles = PaintingQueries().getStyles();
    _authors = PaintingQueries().getAuthors();
  }

  void _filterPaintings() {
    setState(() {
      _paintings = PaintingQueries().getPaintings(
        style: _filterStyle,
        author: _filterAuthor,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Obras de Arte'),
      ),
      body: Column(
        children: [
          FutureBuilder<List<String>>(
            future: _styles,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error al cargar los estilos'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No hay estilos disponibles'));
              } else {
                return DropdownButton<String>(
                  hint: Text("Filtrar por estilo"),
                  value: _filterStyle,
                  onChanged: (String? newValue) {
                    setState(() {
                      _filterStyle = newValue;
                      _filterPaintings();
                    });
                  },
                  items: snapshot.data!
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              }
            },
          ),
          FutureBuilder<List<String>>(
            future: _authors,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error al cargar los autores'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No hay autores disponibles'));
              } else {
                return DropdownButton<String>(
                  hint: Text("Filtrar por autor"),
                  value: _filterAuthor,
                  onChanged: (String? newValue) {
                    setState(() {
                      _filterAuthor = newValue;
                      _filterPaintings();
                    });
                  },
                  items: snapshot.data!
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              }
            },
          ),
          Expanded(
            child: FutureBuilder<List<Painting>>(
              future: _paintings,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error al cargar las obras'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No hay obras disponibles'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return PaintingCard(painting: snapshot.data![index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
