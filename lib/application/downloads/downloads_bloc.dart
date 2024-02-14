import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/downloads/i_download_repository.dart';
import 'package:netflix_app/domain/downloads/models/downloads.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';
part 'downloads_bloc.freezed.dart';

@injectable
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  final IDownloadsRepository iDownloadsRepository;

  DownloadsBloc(this.iDownloadsRepository) : super(DownloadsState.initial()) {
    on<_GetDownloadImage>(
      (event, emit) async {
        emit(
          state.copyWith(
            isLoading: true,
            downloadsFailureOrSuccessOption: none(),
          ),
        );
        final Either<MainFailure, List<Downloads>> downloadsOption =
            await iDownloadsRepository.getDownloadImages();
        //  print("satheesh--${downloadsOption.toString()}");
        emit(
          downloadsOption.fold(
            (faillure) => state.copyWith(
                isLoading: false,
                downloadsFailureOrSuccessOption: Some(left(faillure))),
            (success) => state.copyWith(
              isLoading: false,
              downloads: success,
              downloadsFailureOrSuccessOption: Some(right(success)),
            ),
          ),
        );
      },
    );
  }

  @override
  DownloadsState get state {
    return DownloadsState.initial();
  }
}
