import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import 'di.dart';
import 'di.dart' as di;
import 'features/main/bloc/chat/chat_bloc.dart';
import 'features/main/bloc/episodes/episodes_bloc.dart';
import 'features/main/bloc/favorites/favorites_bloc.dart';
import 'features/main/bloc/series/series_bloc.dart';
import 'features/main/presentation/pages/menu_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'env/.env');
  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SeriesBloc>(
          create: (context) => sl<SeriesBloc>(),
        ),
        BlocProvider<EpisodesBloc>(
          create: (context) => sl<EpisodesBloc>(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => sl<FavoritesBloc>(),
        ),
        BlocProvider<ChatSynopsisBloc>(
          create: (context) => sl<ChatSynopsisBloc>(),
        ),
        BlocProvider<ChatEpisodeBloc>(
          create: (context) => sl<ChatEpisodeBloc>(),
        )
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: GoogleFonts.roboto().fontFamily,
              primaryColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: const FlutterEasyLoading(child: MenuPage())),
      ),
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 45.0
    ..indicatorColor = Colors.white
    ..backgroundColor = Colors.transparent
    ..progressColor = Colors.grey
    ..textColor = Colors.white
    ..maskColor = Colors.grey
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false;
}
