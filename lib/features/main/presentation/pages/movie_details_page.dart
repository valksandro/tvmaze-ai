import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/utils/common.dart';
import '../../bloc/chat/index.dart';
import '../../bloc/favorites/index.dart';
import '../widgets/expandable_header_widget.dart';
import '../widgets/translation_button.dart';
import '../../bloc/episodes/index.dart';
import '../../data/models/series_model.dart';
import '../widgets/detail_summary_widget.dart';
import '../widgets/gender_widget.dart';
import '../widgets/image_layer_effect_widget.dart';
import '../widgets/poster_widget.dart';
import '../widgets/schedule_widget.dart';
import '../widgets/shimmer_episodes_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Show show;
  const MovieDetailsScreen(this.show, {Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late EpisodesBloc _episodesBloc;
  late FavoritesBloc _favoritesBloc;
  bool _isShowFavorite = false;
  Map<String, String> _country = {
    'flag': '🇺🇸',
    'code': 'US',
    'language': 'English',
    'lang': 'English'
  };
  @override
  void initState() {
    super.initState();
    _initEvents();
  }

  void _initEvents() {
    Future.delayed(Duration.zero, () {
      _episodesBloc = BlocProvider.of<EpisodesBloc>(context);
      _favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
      _episodesBloc.add(GetEpisodesEvent(widget.show.id));
      _favoritesBloc.add(GetFavoriteByIdEvent(widget.show.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070D2D),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Movie details', style: GoogleFonts.varelaRound()),
        actions: <Widget>[
          _buildFavoriteWidget(),
        ],
        backgroundColor: const Color(0xFF070D2D),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: 375,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ImageLayerEffectWidget(show: widget.show),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel(widget.show.name, 24),
                      const SizedBox(height: 10),
                      ScheduleWidget(show: widget.show),
                      const SizedBox(height: 20),
                      GenderWidget(show: widget.show),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLabel('Synopsis', 19),
                          TranslationButton(_changeLanguage)
                        ],
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<ChatSynopsisBloc, ChatState>(
                          builder: (context, state) {
                        if (state is GotChatSynopsisSuccessfully) {
                          return DetailSummaryWidget(
                              show: widget.show.copyWith(
                                  summary: state.input ??
                                      state.chatCompletion!.choices.first
                                          .message.content));
                        } else if (state is LoadingChatSynopsis) {
                          return Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        }
                        return DetailSummaryWidget(show: widget.show);
                      }),
                      BlocBuilder<EpisodesBloc, EpisodesState>(
                          builder: (context, state) {
                        if (state is ErrorEpisodes) {
                          showSnackBar(context, state.message);
                          _episodesBloc.add(ClearEpisodesEvent());
                          return const SizedBox();
                        }
                        if (state is LoadingEpisodes) {
                          return const ShimmerEpisodes();
                        } else if (state is GotEpisodesSuccessfully) {
                          return Column(
                              children: state.episodeList.map((e) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: const Color(0xFF161A37),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ExpandablePanel(
                                  theme: const ExpandableThemeData(
                                      iconColor: Colors.white),
                                  header: ExpandableHeaderWidget(e),
                                  collapsed: const SizedBox(),
                                  expanded: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: e.value.map((el) {
                                        return InkWell(
                                          onTap: () {
                                            context.read<ChatEpisodeBloc>().add(
                                                GetChatEpisodeCompletionEvent(
                                                    _country, el.summary));
                                            showCupertinoModalBottomSheet(
                                                context: context,
                                                builder: (context) =>
                                                    _buildBottomSheetContent(
                                                        e.key, el));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                              Icons
                                                                  .slow_motion_video,
                                                              color:
                                                                  Colors.white),
                                                          const SizedBox(
                                                              width: 5),
                                                          Flexible(
                                                            child: Text(
                                                                'E${el.number} - ${el.name}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 3,
                                                                softWrap: true,
                                                                style: GoogleFonts.roboto().copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Icon(
                                                        Icons.arrow_right,
                                                        color: Colors.white)
                                                  ],
                                                ),
                                                const Divider(
                                                    thickness: .3,
                                                    color: Colors.white54)
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList())),
                            );
                          }).toList());
                        } else {
                          return const SizedBox();
                        }
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _buildLabel(String text, double fontSize) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      textScaleFactor: 1,
    );
  }

  void _changeLanguage(Map<String, String> country) {
    _country = country;
    context
        .read<ChatSynopsisBloc>()
        .add(GetChatSynopsisCompletionEvent(country, widget.show.summary));
  }

  Widget _buildFavoriteWidget() {
    return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
          if (state is GotFavoriteSuccessfully) {
            _isShowFavorite = state.favorite != null;
            _favoritesBloc.add(ClearFavoriteEvent());
          }
          return InkResponse(
            onTap: _isLiked,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.favorite,
                color: _isShowFavorite ? Colors.red : Colors.white,
                size: 30.0,
              ),
            ),
          );
        }));
  }

  void _isLiked() async {
    _isShowFavorite = !_isShowFavorite;
    if (_isShowFavorite) {
      _favoritesBloc.add(InsertFavoriteEvent(widget.show));
    } else {
      _favoritesBloc.add(DeleteFavoriteEvent(widget.show.id));
    }
    _favoritesBloc.add(GetFavoriteByIdEvent(widget.show.id));
  }

  Widget _buildBottomSheetContent(int key, Episode el) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(30),
        color: const Color(0xFF070D2D),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('S$key:E${el.number} - ${el.name}',
                  style: GoogleFonts.roboto(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 15),
              Poster(el.id, el.image.medium),
              const SizedBox(height: 15),
              Row(children: [
                const SizedBox(width: 5),
                const Icon(
                  Icons.access_time_rounded,
                  size: 17,
                  color: Colors.white54,
                ),
                const SizedBox(width: 5),
                Text(el.airTime,
                    style: GoogleFonts.roboto().copyWith(
                        color: Colors.white, fontWeight: FontWeight.w400)),
                const SizedBox(width: 5),
                const Icon(
                  Icons.calendar_today_rounded,
                  size: 17,
                  color: Colors.white54,
                ),
                const SizedBox(width: 5),
                Text(
                    DateFormat('yyyy-MM-dd')
                        .format(DateTime.tryParse(el.airDate)!),
                    style: GoogleFonts.roboto().copyWith(
                        color: Colors.white, fontWeight: FontWeight.w400))
              ]),
              BlocBuilder<ChatEpisodeBloc, ChatState>(
                  builder: (context, state) {
                if (state is GotChatEpisodeSuccessfully) {
                  return SingleChildScrollView(
                      child: Html(
                          style: {
                        'p': Style(
                            textAlign: TextAlign.justify,
                            fontFamily: 'roboto',
                            color: Colors.white54,
                            fontWeight: FontWeight.w400)
                      },
                          data: state.input ??
                              state.chatCompletion?.choices.first.message
                                  .content));
                } else if (state is LoadingChatEpisode) {
                  return Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
