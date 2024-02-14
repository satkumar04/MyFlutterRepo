import 'package:dartz/dartz.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/search/model/search_image_response/search_image_response.dart';

abstract class SearchService {
  Future<Either<MainFailure, SearchImageResponse>> searchMovies({
    required String movieQuery,
  });
}
