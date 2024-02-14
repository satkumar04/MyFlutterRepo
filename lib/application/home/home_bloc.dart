import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/hot_and_new/discover_response/discover_response.dart';
import 'package:netflix_app/domain/hot_and_new/discover_response/result.dart';
import 'package:netflix_app/domain/hot_and_new/hot_and_new_service.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService homeService;

  HomeBloc(this.homeService) : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, isError: false));

      final movieResult = await homeService.getHotAndNewMovieData();
      final tvResult = await homeService.getHotAndNewTvData();
      List<Result> pastYear = state.pastYearMovieList;
      List<Result> trending = state.trendingMovieList;
      List<Result> dramas = state.tenseDramasList;
      List<Result> southIndian = state.southIndianMovieList;

      final state1 = movieResult.fold(
        (MainFailure l) {
          return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: [],
              trendingMovieList: [],
              tenseDramasList: [],
              southIndianMovieList: [],
              trendingTvList: [],
              isLoading: false,
              isError: true);
        },
        (DiscoverResponse r) {
          print('MyUrl - ${r.results?[0].posterPath}');
          pastYear = r.results!;
          trending = r.results!;
          dramas = r.results!;
          southIndian = r.results!;

          return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: pastYear,
              trendingMovieList: trending,
              tenseDramasList: dramas,
              southIndianMovieList: southIndian,
              trendingTvList: state.trendingMovieList,
              isLoading: false,
              isError: false);
        },
      );
      emit(state1);

      final state2 = tvResult.fold((MainFailure l) {
        return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramasList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            isError: true);
      }, (DiscoverResponse r) {
        final top10List = r.results;
        return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: pastYear,
            trendingMovieList: trending,
            tenseDramasList: dramas,
            southIndianMovieList: southIndian,
            trendingTvList: top10List!,
            isLoading: false,
            isError: false);
      });

      emit(state2);
    });
  }

  @override
  HomeState get state {
    return HomeState.initial();
  }
}
