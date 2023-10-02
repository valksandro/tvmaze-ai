import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/series_model.dart';

class ExpandableHeaderWidget extends StatelessWidget {
  final MapEntry<int, List<Episode>> episode;
  const ExpandableHeaderWidget(this.episode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(Icons.movie_creation_outlined, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            'Season: ' + episode.key.toString(),
            style: GoogleFonts.roboto()
                .copyWith(color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
