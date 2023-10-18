import 'package:app_movies/api/api.dart';
import 'package:app_movies/data/constants.dart';
import 'package:app_movies/models/movies.dart';
import 'package:app_movies/models/review.dart';
import 'package:app_movies/provider/watch_list_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.movieId}) : super(key: key);
  // final Movies movies;
  final int movieId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Movies? movieDetails;
  Review? reviewRV;
  bool isList = false;
  List<Review> reviewList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchMovieDetails();
    _fetchMovieReviews();
  }

  Future<void> _fetchMovieDetails() async {
    try {
      final Movies movie = await Api().getDetailMovie(widget.movieId);
      print('Fetched Movie Details: $movie');
      setState(() {
        movieDetails = movie;
      });
    } catch (e) {
      // Handle the error
    }
  }

  Future<void> _fetchMovieReviews() async {
    try {
      final List<Review> reviews = await Api().getReviewMovie(widget.movieId);
      print('Fetched Movie Reviews: $reviews');
      setState(() {
        reviewList = reviews;
        print(reviewList);
      });
    } catch (e) {
      // Handle the error
    }
  }

  void toggleWatchList() {
    final watchListProvider =
        Provider.of<WatchListProvider>(context, listen: false);

    setState(() {
      isList = !isList;
      if (isList) {
        watchListProvider.addToWatchList(movieDetails!);
      } else {
        watchListProvider.removeFromWatchList(movieDetails!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242A32),
      appBar: AppBar(
        title: const Text(
          "Detail",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: toggleWatchList, // Sử dụng hàm để thêm/xóa xem sau
            icon: Icon(
              isList ? Icons.bookmark : Icons.bookmark_outlined,
            ),
          ),
        ],
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
                      '${Constants.imagePath}${movieDetails?.backDropPath ?? ''}',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      child: Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_today,
                                color: Color(0xFF92929D)),
                            const SizedBox(
                              width: 2,
                            ),
                            //calendar
                            Text(
                              movieDetails?.releaseDate ?? '',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF92929D)),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Container(
                              width: 1,
                              height: 20,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            // time
                            const Icon(Icons.calendar_today,
                                color: Color(0xFF92929D)),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              ' ${movieDetails?.runTime != null ? '${movieDetails?.runTime} minutes' : 'N/A'}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF92929D)),
                            ),

                            const SizedBox(
                              width: 2,
                            ),
                            Container(
                              width: 1,
                              height: 20,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            //type film
                            const Icon(Icons.calendar_today,
                                color: Color(0xFF92929D)),
                            const SizedBox(
                              width: 2,
                            ),
                            const Text(
                              'abc',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF92929D)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'About Movie'),
                    Tab(text: 'Reviews'),
                    Tab(text: 'Cast'),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                ),
                Expanded(
                  // Increase the height to accommodate content
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Content for 'About Movie' tab
                      SingleChildScrollView(
                        child: buildTabContent(movieDetails?.overView ?? ''),
                      ),

                      // Content for 'Reviews' tab
                      // Content for 'Reviews' tab
                      // Content for 'Reviews' tab
                      SingleChildScrollView(
                        child: Column(
                          children: reviewList.map((review) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Author: ${review.author}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  review.content,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                // Thêm thông tin khác của đánh giá nếu cần
                              ],
                            );
                          }).toList(),
                        ),
                      ),

                      // Content for 'Cast' tab
                      SingleChildScrollView(
                        child: buildTabContent(""),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 260,
              right: 61,
              child: Container(
                width: 200,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Align(
                  child: Text(
                    movieDetails?.title ?? '',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 110,
                  height: 150,
                  child: Image.network(
                    '${Constants.imagePath}${movieDetails?.posterPath ?? ''}',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 225,
                right: 11,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: const Color(0xFF252836).withOpacity(0.32)),
                    child: Row(
                      children: [
                        const Icon(Icons.star_border_outlined,
                            color: Color(0xFFFF8700)),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${movieDetails?.voteAverage.toStringAsFixed(1)}/10',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFF8700)),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }

  // Replace with your own content for each tab
  Widget buildTabContent(String title) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }
}
