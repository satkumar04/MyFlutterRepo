part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required String stateId,
    required List<Result> pastYearMovieList,
    required List<Result> trendingMovieList,
    required List<Result> tenseDramasList,
    required List<Result> southIndianMovieList,
    required List<Result> trendingTvList,
    required bool isLoading,
    required bool isError,
  }) = _Initial;

  factory HomeState.initial() => const HomeState(
      stateId: '0',
      pastYearMovieList: [],
      trendingMovieList: [],
      tenseDramasList: [],
      southIndianMovieList: [],
      trendingTvList: [],
      isLoading: false,
      isError: false);
}
