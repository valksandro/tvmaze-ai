import 'package:flutter/material.dart';

import '../../../../core/utils/common.dart';
import '../../data/models/series_model.dart';
import 'categories_filter_widget.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    Key? key,
    required this.show,
  }) : super(key: key);

  final Show show;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: show.genres
                  .map(
                    (el) => Row(
                      children: [
                        CategoriesFilter(
                            emoji: getEmojiByGenre(el), filterName: el),
                        const SizedBox(width: 6)
                      ],
                    ),
                  )
                  .toList()),
        ));
  }
}
