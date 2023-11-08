import 'package:app_movies/models/review.dart';
import 'package:dio/dio.dart';
import 'package:app_movies/data/constants.dart';
import 'package:app_movies/models/movies.dart';

class Api {
  static const _trendingUrl =
      '${Constants.domain}/trending/movie/day?api_key=${Constants.apiKey}';
  static const _popularUrl =
      '${Constants.domain}/movie/popular?api_key=${Constants.apiKey}';
  static const _nowPlayingUrl =
      '${Constants.domain}/movie/now_playing?api_key=${Constants.apiKey}';
  static const _upComingUrl =
      '${Constants.domain}/movie/upcoming?api_key=${Constants.apiKey}';
  static const _topRateUrl =
      '${Constants.domain}/movie/top_rated?api_key=${Constants.apiKey}';

  Dio dio = Dio();
  Future<List<Movies>> getTrendingMovies() async {
    try {
      final response = await dio.get(_trendingUrl);
      if (response.statusCode == 200) {
        final decodedData = response.data['results'] as List;
        return decodedData.map((movie) => Movies.fromJson(movie)).toList();
      } else {
        throw Exception('Something happened');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Movies>> getPopularMovies() async {
    try {
      final response = await dio.get(_popularUrl);
      if (response.statusCode == 200) {
        final decodedData = response.data['results'] as List;
        return decodedData.map((movie) => Movies.fromJson(movie)).toList();
      } else {
        throw Exception('Something happened');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Movies>> getNowPlayingMovies() async {
    try {
      final response = await dio.get(_nowPlayingUrl);
      if (response.statusCode == 200) {
        final decodedData = response.data['results'] as List;
        return decodedData.map((movie) => Movies.fromJson(movie)).toList();
      } else {
        throw Exception('Something happened');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Movies>> getUpComingMovies() async {
    try {
      final response = await dio.get(_upComingUrl);
      if (response.statusCode == 200) {
        final decodedData = response.data['results'] as List;
        return decodedData.map((movie) => Movies.fromJson(movie)).toList();
      } else {
        throw Exception('Something happened');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Movies>> getTopRatedMovies() async {
    try {
      final response = await dio.get(_topRateUrl);
      if (response.statusCode == 200) {
        final decodedData = response.data['results'] as List;
        return decodedData.map((movie) => Movies.fromJson(movie)).toList();
      } else {
        throw Exception('Something happened');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Movies> getDetailMovie(int movieId) async {
    final String detailUrl =
        'https://api.themoviedb.org/3/movie/$movieId?api_key=${Constants.apiKey}';
    try {
      final response = await dio.get(detailUrl);
      if (response.statusCode == 200) {
        final decodedData = response.data;
        return Movies.fromJson(decodedData);
      } else {
        throw Exception('Something happened');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Review>> getReviewMovie(int movieId) async {
    final String detailUrl =
        'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Constants.apiKey}';
    try {
      final response = await dio.get(detailUrl);
      if (response.statusCode == 200) {
        final decodedData = response.data['results'] as List;
        print('=>>>>>>>>>> res $decodedData');
        return decodedData.map((review) => Review.fromJson(review)).toList();
      } else {
        print('=>>>> error');
        throw Exception('Something happened');
      }
    } catch (e) {
      print('=>>>> error 1 $e');
      throw Exception('Error: $e');
    }
  }
}
