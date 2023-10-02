import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/core/db/database.dart';
import '/features/main/presentation/widgets/favorite_tile_widget.dart';
import '../../../../core/utils/common.dart';
import '../../bloc/favorites/index.dart';
import 'movie_details_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late FavoritesBloc _favoritesBloc;
  List<FavoriteData> _favoriteShows = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
      _favoritesBloc.add(GetAllFavoriteEvent());
    });
  }

  void _processState(state) {
    if (state is GotAllFavoritesSuccessfully) {
      _favoriteShows = state.favoriteShows;
      _favoriteShows.sort((a, b) =>
          a.name?.toLowerCase().compareTo(b.name?.toLowerCase() ?? '') ?? 0);
      _favoritesBloc.add(ClearFavoriteEvent());
    } else if (state is GotFavoriteShowSuccessfully) {
      EasyLoading.dismiss();
      Future.delayed(Duration.zero, () {
        get(context, () => MovieDetailsScreen(state.show));
      });
      _favoritesBloc.add(ClearFavoriteEvent());
    } else if (state is ErrorFavorites) {
      _favoritesBloc.add(ClearFavoriteEvent());
      _showError(state);
    }
  }

  void _showError(ErrorFavorites state) {
    EasyLoading.dismiss();
    showSnackBar(context, state.message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF070D2D),
        title: const Text(
          'Favorite',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xFF070D2D),
      body: Container(
          padding: const EdgeInsets.only(top: 30, bottom: 10),
          child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
            _processState(state);
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _favoriteShows.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(index),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          _favoritesBloc.add(
                              DeleteFavoriteEvent(_favoriteShows[index].id));
                          setState(() {
                            _favoriteShows.removeAt(index);
                          });
                        },
                        backgroundColor: const Color(0xFF070D2D),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      EasyLoading.show();
                      _favoritesBloc
                          .add(GetFavoritesShowEvent(_favoriteShows[index].id));
                    },
                    child: FavoriteTile(
                      _favoriteShows[index].name ?? '',
                      _favoriteShows[index].image ?? '',
                      _favoriteShows[index].summary ?? '',
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox();
              },
            );
          })),
    );
  }
}
