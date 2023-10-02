import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/main/data/repositories/series_repository_impl.dart';
import 'series_event.dart';
import 'series_state.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final SeriesRepository seriesRepository;
  SeriesState? _seriesState;

  SeriesBloc(this.seriesRepository) : super(Empty()) {
    on<GetShowEvent>((event, emit) async {
      emit(Loading());
      if (_seriesState == null || event.refresh) {
        final result = await seriesRepository.getShow(page: event.page);
        _seriesState = result.fold(
            (l) => Error(l.getMessage()), (r) => GotShowSuccessfully(r));
      }

      emit(_seriesState!);
    });
    on<SearchShowByNameEvent>((event, emit) async {
      emit(Loading());
      final result = await seriesRepository.searchShowByName(event.name);
      _seriesState = result.fold(
          (l) => Error(l.getMessage()), (r) => GotShowByNameSuccessfully(r));
      emit(_seriesState!);
    });

    on<ClearEvent>((event, emit) async {
      emit(Empty());
    });
  }
}
