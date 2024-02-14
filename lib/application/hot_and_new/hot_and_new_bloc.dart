import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failure.dart';
import 'package:netflix_app/domain/hot_and_new/discover_response/discover_response.dart';
import 'package:netflix_app/domain/hot_and_new/discover_response/result.dart';
import 'package:netflix_app/domain/hot_and_new/hot_and_new_service.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService hotAndNewService;

  HotAndNewBloc(this.hotAndNewService) : super(HotAndNewState.initial()) {
    on<LoadDataInComingSoon>((event, emit) async {
      emit(const HotAndNewState(
          comingSoonList: [],
          everyOneList: [],
          isLoading: true,
          isError: false));

      final result = await hotAndNewService.getHotAndNewMovieData();

      final newState = result.fold(
          (l) => const HotAndNewState(
                comingSoonList: [],
                everyOneList: [],
                isLoading: false,
                isError: true,
              ),
          (r) => HotAndNewState(
                comingSoonList: r.results!,
                everyOneList: state.everyOneList,
                isLoading: false,
                isError: false,
              ));
      emit(newState);
    });

    on<LoadDataInEveryOne>((event, emit) async {
      emit(const HotAndNewState(
          comingSoonList: [],
          everyOneList: [],
          isLoading: true,
          isError: false));

      final result = await hotAndNewService.getHotAndNewTvData();
      print('My-result-- ${result.toString()}');

      final newState = result.fold(
          (l) => const HotAndNewState(
                comingSoonList: [],
                everyOneList: [],
                isLoading: false,
                isError: true,
              ),
          (r) => HotAndNewState(
                comingSoonList: state.comingSoonList,
                everyOneList: r.results!,
                isLoading: false,
                isError: false,
              ));
      emit(newState);
    });
  }

  @override
  HotAndNewState get state => HotAndNewState.initial();
}
