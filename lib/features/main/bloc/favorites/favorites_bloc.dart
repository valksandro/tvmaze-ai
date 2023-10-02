import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvmaze/features/main/data/repositories/favorites_repository_impl.dart';
import 'package:tvmaze/features/main/data/repositories/series_repository_impl.dart';
import 'index.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final SeriesRepository seriesRepository;
  final FavoritesRepository favoritesRepository;

  @override
  void onChange(Change<FavoritesState> change) {
    super.onChange(change);
  }

  FavoritesBloc(this.seriesRepository, this.favoritesRepository)
      : super(EmptyFavorites()) {
    on<GetFavoritesShowEvent>((event, emit) async {
      emit(LoadingFavorites());
      final result = await seriesRepository.getShowById(event.id);
      emit(result.fold((l) => ErrorFavorites(l.getMessage()),
          (r) => GotFavoriteShowSuccessfully(r)));
    });
    on<InsertFavoriteEvent>((event, emit) async {
      final result = await favoritesRepository.insertFavorite(event.show);
      emit(result.fold((l) => ErrorFavorites(l.getMessage()),
          (r) => InsertedFavoriteSuccessfully()));
    });
    on<DeleteFavoriteEvent>((event, emit) async {
      final result = await favoritesRepository.delete(event.id);
      emit(result.fold((l) => ErrorFavorites(l.getMessage()),
          (r) => DeletedFavoriteSuccessfully()));
    });
    on<GetAllFavoriteEvent>((event, emit) async {
      final result = await favoritesRepository.getAllFavorites();
      emit(result.fold((l) => ErrorFavorites(l.getMessage()),
          (r) => GotAllFavoritesSuccessfully(r)));
    });
    on<GetFavoriteByIdEvent>((event, emit) async {
      final result = await favoritesRepository.getFavoriteById(event.id);
      emit(result.fold((l) => ErrorFavorites(l.getMessage()),
          (r) => GotFavoriteSuccessfully(r)));
    });
    on<ClearFavoriteEvent>((event, emit) async {
      emit(EmptyFavorites());
    });
  }
}
