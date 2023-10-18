import 'package:app_movies/data/constants.dart';
import 'package:app_movies/provider/watch_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchListScreen extends StatelessWidget {
  // Danh sách bộ phim trong Watch List

  const WatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchList = context.read<WatchListProvider>().watchList;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Watch List",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: const Color(0xFF242A32),
        ),
        backgroundColor: const Color(0xFF242A32),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: watchList.length,
            itemBuilder: (context, index) {
              final movie = watchList[index];
              print(movie);
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 110,
                        height: 150,
                        child: Image.network(
                          '${Constants.imagePath}${movie.posterPath}', // Đường dẫn hình ảnh bộ phim
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow
                                .ellipsis, // Đặt hiển thị dấu ba chấm
                            maxLines: 1, // Số dòng tối đa để hiển thị
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_border_outlined,
                                color: Color(0xFFFF8700)),
                            const SizedBox(
                              width: 1,
                            ),
                            Text(
                              '${movie.voteAverage.toStringAsFixed(1)}/10',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFF8700)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Row(
                          children: [
                            Icon(Icons.confirmation_number,
                                color: Colors.white),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              "Action",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                color: Colors.white),
                            const SizedBox(
                              width: 1,
                            ),
                            Text(
                              movie.releaseDate,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.schedule, color: Colors.white),
                            const SizedBox(
                              width: 1,
                            ),
                            Text(
                              ' ${movie.runTime != null ? '${movie.runTime} minutes' : 'N/A'}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
