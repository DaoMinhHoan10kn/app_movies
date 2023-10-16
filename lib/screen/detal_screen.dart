import 'package:app_movies/data/constants.dart';
import 'package:app_movies/models/movies.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.movies}) : super(key: key);
  final Movies movies;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final Movies movies = widget.movies;
    return Scaffold(
      backgroundColor: const Color(0xFF242A32),
      appBar: AppBar(
        title: const Text(
          "Detail",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF242A32),
      ),
      body: DefaultTabController(
        length: 4, // Number of tabs
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 415,
                    height: 260,
                    child: Image.network(
                      '${Constants.imagePath}${movies.posterPath}',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      movies.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(
                        width: 5,
                      ),
                      //calendar
                      Text(
                        movies.releaseDate,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      // time
                      const Icon(Icons.calendar_today),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "148 Minutes",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      //type film
                      const Icon(Icons.calendar_today),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Action",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Now Playing'),
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Top Rated'),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                ),
              ],
            ),
            TabBarView(
              controller: _tabController,
              children: [
                // Content for 'Now Playing' tab
                buildTabContent("Now Playing Content"),

                // Content for 'Upcoming' tab
                buildTabContent("Upcoming Content"),

                // Content for 'Top Rated' tab
                buildTabContent("Top Rated Content"),
              ],
            ),
            Positioned(
              top: 180,
              left: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 110,
                  height: 140,
                  child: Container(
                    color: const Color.fromARGB(255, 255, 1, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Replace with your own content for each tab
  Widget buildTabContent(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
