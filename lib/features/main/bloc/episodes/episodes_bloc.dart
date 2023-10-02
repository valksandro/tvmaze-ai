import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvmaze/features/main/data/repositories/series_repository_impl.dart';
import '../../data/models/series_model.dart';
import 'index.dart';


class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final SeriesRepository seriesRepository;

  EpisodesBloc(this.seriesRepository) : super(EmptyEpisodeList()) {
    on<ClearEpisodesEvent>((event, emit) async {
      emit(EmptyEpisodeList());
    });
    on<GetEpisodesEvent>((event, emit) async {
      emit(LoadingEpisodes());
      final result = await seriesRepository.getShowEpisodes(event.id);

      if(result.isRight()) {
        List<MapEntry<int, List<Episode>>> episodeList = [];
        var episodes = result.getOrElse(() => []);
        var grp = -1;
        final seasons = episodes.map((ep) {
          if (ep.season != grp) {
            grp = ep.season;
            return ep.season;
          }
          return null;
        }).where((item) => item != null).toList()
          ..sort();
        for (var e in seasons) {
          final part = episodes.where((element) => element.season == e);
          episodeList.add(MapEntry(e!, part.toList()));
        }
        emit(GotEpisodesSuccessfully(episodeList));
      }else{
        result.fold((l) => emit(ErrorEpisodes(l.getMessage())), (r) => r);
      }
    });
  }
}
