import 'package:dartz/dartz.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/hot_and_new/discover_response/discover_response.dart';

abstract class HotAndNewService {
  Future<Either<MainFailure, DiscoverResponse>> getHotAndNewMovieData();
  Future<Either<MainFailure, DiscoverResponse>> getHotAndNewTvData();
}
