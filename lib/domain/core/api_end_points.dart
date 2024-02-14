import 'package:netflix_app/core/utils.dart';
import 'package:netflix_app/infrastructure/api_key.dart';

class ApiEndPoints {
  static const downloadUrl = "$baseUrl/trending/all/day?api_key=$apiKey";
  static const searchUrl = '$baseUrl/search/movie?api_key=$apiKey';
  static const hotAndNewMovieUrl = '$baseUrl/discover/movie?api_key=$apiKey';
  static const hotAndNewTvUrl = '$baseUrl/discover/tv?api_key=$apiKey';
}
