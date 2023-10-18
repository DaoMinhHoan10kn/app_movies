import 'package:app_movies/models/movies.dart';
import 'package:flutter/material.dart';

class WatchListProvider extends ChangeNotifier {
  List<Movies> watchList = [];

  void addToWatchList(Movies movie) {
    watchList.add(movie);
    notifyListeners();
  }

  void removeFromWatchList(Movies movie) {
    watchList.remove(movie);
    notifyListeners();
  }
}
