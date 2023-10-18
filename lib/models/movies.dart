class Movies {
  int id;
  String title;
  String backDropPath;
  String originalTitle;
  String overView;
  String posterPath;
  int? runTime;
  String releaseDate;
  double voteAverage;

  Movies({
    required this.id,
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overView,
    required this.posterPath,
    required this.runTime,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      id: json["id"],
      title: json["title"], // Đảm bảo tên trường phù hợp với JSON
      backDropPath:
          json["backdrop_path"], // Đảm bảo tên trường phù hợp với JSON
      originalTitle:
          json["original_title"], // Đảm bảo tên trường phù hợp với JSON
      overView: json["overview"], // Đảm bảo tên trường phù hợp với JSON
      posterPath: json["poster_path"],
      runTime: json["runtime"],
      // Đảm bảo tên trường phù hợp với JSON
      releaseDate: json["release_date"], // Đảm bảo tên trường phù hợp với JSON
      voteAverage: json["vote_average"]
          ?.toDouble(), // Đảm bảo tên trường phù hợp với JSON
    );
  }
}
