import 'package:app_movies/data/constants.dart';
import 'package:app_movies/screen/detal_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: double.infinity,
        child: CarouselSlider.builder(
            itemCount: 10,
            options: CarouselOptions(
              height: 300,
              autoPlay: true,
              viewportFraction: 0.55,
              pageSnapping: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(seconds: 1),
            ),
            itemBuilder: (context, itemIndex, pageViewIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            movies: snapshot.data[itemIndex],
                          ),
                        ));
                  },
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.network(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        '${Constants.imagePath}${snapshot.data[itemIndex].posterPath}'),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
