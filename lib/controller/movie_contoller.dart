import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/popular_movies_model.dart';
import '../services/constants.dart';

class MovieController
{
  static Future<List<PopularMovies>> getMovies() async {

    List<PopularMovies> popularMoviesList = [];
    http.Response response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    // print(jsonData['results']);
    jsonData['results'].forEach((movie) {
      PopularMovies popularMovies = PopularMovies.fromJson(movie);
      popularMoviesList.add(popularMovies);
    });

    return popularMoviesList;
  }
}