import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/downloads/i_download_repository.dart';
import 'package:netflix_app/domain/downloads/models/downloads.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final videoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
];

ValueNotifier<Set<int>> likedVideoNotifier = ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(IDownloadsRepository iDownloadsRepository)
      : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      emit(
        FastLaughState(
          videoList: [],
          isLoading: true,
          isError: false,
        ),
      );
      final result = await iDownloadsRepository.getDownloadImages();
      final stateValue = result.fold(
        (l) => FastLaughState(
          videoList: [],
          isLoading: false,
          isError: true,
        ),
        (r) => FastLaughState(
          videoList: r,
          isLoading: false,
          isError: false,
        ),
      );
      emit(stateValue);
    });

    on<LikeVideo>((event, emit) {
      likedVideoNotifier.value.add(event.id);
    });

    on<UnLikevideo>((event, emit) {
      likedVideoNotifier.value.remove(event.id);
    });
  }

  @override
  FastLaughState get state => FastLaughState.initial();
}
