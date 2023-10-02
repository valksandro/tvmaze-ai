import 'package:flutter/material.dart';

import 'poster_widget.dart';

class CardImageWidget extends StatelessWidget {
  final String name;
  final String image;
  final GestureTapCallback onTap;
  final int id;

  const CardImageWidget(this. id, this.name, this.image, this.onTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100.0,
              height: 150.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Poster(id, image),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(name),
            ),
          ],
        ),
      ),
    );
  }
}
