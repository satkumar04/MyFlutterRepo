import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/api_end_points.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/downloads/i_download_repository.dart';
import 'package:netflix_app/domain/downloads/models/downloads.dart';
import 'package:dio/dio.dart';

@LazySingleton(as: IDownloadsRepository)
class DownloadRepository implements IDownloadsRepository {
  @override
  Future<Either<MainFailure, List<Downloads>>> getDownloadImages() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.downloadUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final downLoadList = (response.data['results'] as List).map((e) {
          return Downloads.fromJson(e);
        }).toList();
        print("satheeshDownload--${downLoadList.toString()}");
        return Right(downLoadList);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return const Left(MainFailure.clientFailure());
    }
  }
}
