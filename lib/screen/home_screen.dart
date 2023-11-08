import 'package:app_movies/api/api.dart';
import 'package:app_movies/models/movies.dart';
import 'package:app_movies/widget/tab_movies.dart';
import 'package:app_movies/widget/trending_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<Movies>> trendingMovies;
  late final TabController _tabController =
      TabController(length: 4, vsync: this);

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242A32),
      appBar: AppBar(
        title: const Text("Home",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: const Color(0xFF242A32),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: const Text("What do you want to watch?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600))),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 25),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                    filled: true,
                    fillColor: Color(0xFF3A3F47),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Color(0xFF67686D)),
                    suffixIcon: Icon(Icons.search),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                height: 230,
                child: FutureBuilder(
                  future: trendingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return TrendingSlider(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Now Playing'),
                Tab(text: 'Upcoming'),
                Tab(text: 'Top Rated'),
                Tab(text: 'Popular'),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
            ),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  TabMovies(initialTab: 0), // Now Playing
                  TabMovies(initialTab: 1), // Upcoming
                  TabMovies(initialTab: 2), // Top Rated
                  TabMovies(initialTab: 3), // Popular
                ],
              ),
            ),

            // Now Playing Tab
          ],
        ),
      ),
    );
  }
}
