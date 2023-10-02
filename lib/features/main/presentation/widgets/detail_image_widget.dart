import 'package:flutter/material.dart';

import '../../data/models/series_model.dart';

class DetailImageWidget extends StatelessWidget {
  const DetailImageWidget({
    Key? key,
    required this.show,
  }) : super(key: key);

  final Show show;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        image: show.image.original.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(
                  show.image.original,
                ),
                fit: BoxFit.fill,
              )
            : const DecorationImage(
                image: AssetImage('assets/images/no-image.png'),
                fit: BoxFit.fill,
              ),
      ),
    );
  }
}
