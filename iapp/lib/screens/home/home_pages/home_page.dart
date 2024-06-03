import 'package:flutter/material.dart';
import 'package:iapp/db/models/museum.dart';
import 'package:iapp/db/queries/museum_queries.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animations/animations.dart';
import 'package:iapp/screens/home/museum/museum_detail_page.dart';

class HomePage extends StatefulWidget {
  final int userId;

  HomePage({required this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  late Future<List<Museum>> _museums;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Museum> _currentMuseums = [];

  @override
  void initState() {
    super.initState();
    _museums = MuseumQueries().getMuseums();
    _populateList();
  }

  Future<void> _populateList() async {
    List<Museum> museums = await _museums;
    for (var i = 0; i < museums.length; i++) {
      _listKey.currentState?.insertItem(i);
      _currentMuseums.add(museums[i]);
      await Future.delayed(Duration(milliseconds: 300)); // delay for animation
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Text(
              'Museos',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              children: [
                Expanded(
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: _currentMuseums.length,
                    itemBuilder: (context, index, animation) {
                      return _buildItem(_currentMuseums[index], animation);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(Museum museum, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        transitionDuration: Duration(milliseconds: 500),
        openBuilder: (context, _) => MuseumDetailPage(museum: museum),
        closedElevation: 5,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        closedColor: Colors.white,
        closedBuilder: (context, openContainer) {
          return GestureDetector(
            onTap: openContainer,
            child: Card(
              margin: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Stack(
                  children: [
                    // Image part
                    Container(
                      width: double.infinity,
                      height: 200, // Ajustado para mayor altura
                      child: Image.asset(
                        museum.imagePaths[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Gradient overlay
                    Container(
                      width: double.infinity,
                      height: 200, // Ajustado para mayor altura
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    // Text part
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            museum.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            museum.location,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
