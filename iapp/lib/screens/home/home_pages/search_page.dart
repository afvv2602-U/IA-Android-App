import 'package:flutter/material.dart';
import 'package:iapp/config/colors.dart';
import 'package:iapp/db/queries/painting_queries.dart';
import 'package:iapp/db/models/painting.dart';
import 'package:iapp/screens/home/painting/painting_card.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<Painting>> _paintings;
  late Future<List<String>> _styles;
  Future<List<String>>? _authors;
  String? _filterStyle;
  String? _filterAuthor;
  String sectionTitle = 'Estilos';

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Painting> _currentPaintings = [];

  @override
  void initState() {
    super.initState();
    _paintings = PaintingQueries().getPaintings();
    _styles = _getStyles();
    _populateList();
  }

  Future<void> _populateList() async {
    List<Painting> paintings = await _paintings;
    for (var i = 0; i < paintings.length; i++) {
      _listKey.currentState?.insertItem(i);
      _currentPaintings.add(paintings[i]);
      await Future.delayed(Duration(milliseconds: 300)); // delay for animation
    }
  }

  Future<List<String>> _getStyles() async {
    List<Painting> paintings = await PaintingQueries().getPaintings();
    return paintings.map((p) => p.style).toSet().toList();
  }

  Future<List<String>> _getAuthors(String style) async {
    List<Painting> paintings =
        await PaintingQueries().getPaintings(style: style);
    return paintings.map((p) => p.author).toSet().toList();
  }

  void _filterPaintings() async {
    List<Painting> paintings = await PaintingQueries().getPaintings(
      style: _filterStyle,
      author: _filterAuthor,
    );

    for (var i = 0; i < _currentPaintings.length; i++) {
      _listKey.currentState?.removeItem(
        0,
        (context, animation) => Container(),
        duration: Duration(milliseconds: 500),
      );
    }

    setState(() {
      _currentPaintings = [];
    });

    for (var i = 0; i < paintings.length; i++) {
      _listKey.currentState?.insertItem(i);
      _currentPaintings.add(paintings[i]);
      await Future.delayed(Duration(milliseconds: 300));
    }
  }

  void _resetFilters() {
    setState(() {
      _filterStyle = null;
      _filterAuthor = null;
      sectionTitle = 'Estilos';
      _paintings = PaintingQueries().getPaintings();
      _authors = null; // Reseteo a null
    });
    _filterPaintings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 40,
                left: 16,
                right: 16,
                bottom: 10), // Ajusta el padding para bajar la sección
            color: Colors.transparent, // Fondo transparente
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sectionTitle,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _resetFilters,
                ),
              ],
            ),
          ),
          FutureBuilder<List<String>>(
            future: _authors ?? _styles,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error al cargar los datos'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No hay datos disponibles'));
              } else {
                return _buildTagsSection(snapshot.data!, sectionTitle,
                    (String? newValue) {
                  setState(() {
                    if (sectionTitle == 'Estilos') {
                      _filterStyle = newValue;
                      _filterAuthor = null;
                      if (newValue != null) {
                        sectionTitle = newValue; // Actualizar el título
                        _authors = _getAuthors(newValue);
                      } else {
                        sectionTitle = 'Estilos';
                        _authors = null;
                      }
                    } else {
                      _filterAuthor = newValue;
                    }
                    _filterPaintings();
                  });
                });
              }
            },
          ),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _currentPaintings.length,
              itemBuilder: (context, index, animation) {
                return _buildItem(_currentPaintings[index], animation);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsSection(
      List<String> tags, String sectionTitle, Function(String?) onSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: Colors.transparent, // Fondo transparente
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tags.length,
              itemBuilder: (context, index) {
                return _buildGradientChip(tags[index], onSelected);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientChip(String tag, Function(String?) onSelected) {
    bool isSelected = (_filterStyle == tag && _filterAuthor == null) ||
        (_filterAuthor == tag);
    return GestureDetector(
      onTap: () {
        onSelected(isSelected ? null : tag);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.acentoSutil, AppColors.acentoPrincipal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tag,
              style: TextStyle(color: Colors.white),
            ),
            if (isSelected) ...[
              SizedBox(width: 8),
              Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildItem(Painting painting, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: PaintingCard(painting: painting),
    );
  }
}
