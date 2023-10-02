import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../data/models/series_model.dart';

class DetailSummaryWidget extends StatelessWidget {
  const DetailSummaryWidget({
    Key? key,
    required this.show,
  }) : super(key: key);

  final Show show;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Html(style: {
      'p': Style(
        color: Colors.white54,
        textAlign: TextAlign.justify,
      )
    }, data: show.summary));
  }
}
