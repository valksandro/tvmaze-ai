import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import '/core/utils/common.dart';
import '/features/main/bloc/series/index.dart';
import '/features/main/data/models/series_model.dart';
import '../widgets/search_input_decoration.dart';
import 'movie_details_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageCount = 0;
  int _totalPageCountByName = 0;
  List<Show> _dataList = [];
  bool _isSearching = false;

  late SeriesBloc _seriesBloc;

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);

  @override
  void initState() {
    super.initState();

    _pageCount = 0;
    _totalPageCountByName = 0;
    _dataList = [];

    _scrollController.addListener(_scrollListener);

    Future.delayed(Duration.zero, () {
      _seriesBloc = BlocProvider.of<SeriesBloc>(context);
      EasyLoading.show();
      _seriesBloc.add(GetShowEvent());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070D2D),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    onChanged: _onSearchPress,
                    cursorColor: Colors.white,
                    decoration: SearchInputDecorator(_onTapClear)),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .85,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: BlocBuilder<SeriesBloc, SeriesState>(
                          builder: (context, state) {
                        _listenCardPurchase(state);
                        return GridView.count(
                          physics: const BouncingScrollPhysics(),
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 2,
                          childAspectRatio: .6,
                          children: _dataList
                              .map((e) => Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => _goToDetails(e),
                                        child: Container(
                                          height: 200,
                                          width: 150,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: e.image.medium
                                                    .toString()
                                                    .isNotEmpty
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                      e.image.medium,
                                                    ),
                                                    fit: BoxFit.fill,
                                                  )
                                                : const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/no-image.png'),
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        e.name,
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                        softWrap: true,
                                        textScaleFactor: 1,
                                      )
                                    ],
                                  ))
                              .toList(),
                        );
                      })),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapClear() {
    _searchController.clear();
    _checkSearchByName();
    EasyLoading.show();
    _seriesBloc.add(GetShowEvent(refresh: true));
  }

  void _goToDetails(Show show) {
    get(context, () => MovieDetailsScreen(show));
  }

  void _checkSearchByName() {
    if (_totalPageCountByName > 0) {
      _pageCount = -1;
      _totalPageCountByName = 0;

      setState(() {
        _dataList.clear();
      });
    }
  }

  void _onSearchPress(String value) {
    if (value.trim().isEmpty) {
      _checkSearchByName();
      EasyLoading.show();
      _seriesBloc.add(GetShowEvent(refresh: true));
      return;
    }

    if (!_isSearching) {
      _isSearching = true;
      Future.delayed(const Duration(milliseconds: 1500), () {
        EasyLoading.show();
        _seriesBloc.add(SearchShowByNameEvent(_searchController.text));
        _isSearching = false;
      });
    }
  }

  void _scrollListener() {
    if (_searchController.text.trim().isEmpty) {
      if ((_scrollController.offset <=
                  _scrollController.position.minScrollExtent &&
              !_scrollController.position.outOfRange) &&
          (_pageCount > 0)) {
        _checkSearchByName();

        _pageCount = 0;

        setState(() {
          _dataList.clear();
        });

        EasyLoading.show();
        _seriesBloc.add(GetShowEvent(page: _pageCount, refresh: true));
      } else if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        _checkSearchByName();

        setState(() {
          EasyLoading.show();
          _pageCount = _pageCount + 1;
          _seriesBloc.add(GetShowEvent(page: _pageCount, refresh: true));
        });
      }
    }
  }

  void _listenCardPurchase(state) {
    if (state is Error) {
      _seriesBloc.add(ClearEvent());
      EasyLoading.dismiss();
      showSnackBar(context, state.message);
    } else if (state is GotShowSuccessfully) {
      _dataList.addAll(state.showList);

      _seriesBloc.add(ClearEvent());
      EasyLoading.dismiss();
    } else if (state is GotShowByNameSuccessfully) {
      _pageCount = 0;
      _dataList.clear();
      _totalPageCountByName = state.showList.length;

      _dataList.addAll(state.showList);

      _seriesBloc.add(ClearEvent());
      EasyLoading.dismiss();
    }
  }
}
