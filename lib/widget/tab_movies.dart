import 'package:app_movies/api/api.dart';
import 'package:app_movies/data/constants.dart';
import 'package:app_movies/models/movies.dart';
import 'package:app_movies/screen/detal_screen.dart';
import 'package:flutter/material.dart';

class TabMovies extends StatefulWidget {
  const TabMovies({super.key, required this.initialTab});

  final int initialTab;

  @override
  State<TabMovies> createState() => _TabMoviesState();
}

class _TabMoviesState extends State<TabMovies> {
  late Future<List<Movies>> moviesData;
  @override
  void initState() {
    super.initState();
    moviesData = _fetchMoviesData(widget.initialTab);
  }

  Future<List<Movies>> _fetchMoviesData(int tab) {
    switch (tab) {
      case 0:
        return Api().getNowPlayingMovies();
      case 1:
        return Api().getUpComingMovies();
      case 2:
        return Api().getTopRatedMovies();
      case 3:
        return Api().getPopularMovies();
      default:
        throw Exception("Invalid tab index");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Column(children: [
        Expanded(
          child: FutureBuilder<List<Movies>>(
            future: moviesData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                List<Movies> movies = snapshot.data!;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    movieId: snapshot.data![index].id,
                                  ),
                                ));
                          },
                          child: Image.network(
                            '${Constants.imagePath}${movies[index].posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text("No data available"));
              }
            },
          ),
        ),
      ]),
    );
  }
}
