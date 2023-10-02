import 'package:flutter/material.dart';

import '/core/utils/common.dart';

class FavoriteTile extends StatelessWidget {
  final String name;
  final String image;
  final String summary;

  const FavoriteTile(this.name, this.image, this.summary, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: Container(
              height: 100.0,
              width: 80.0,
              decoration: BoxDecoration(
                image: image.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(
                          image,
                        ),
                        fit: BoxFit.fill,
                      )
                    : const DecorationImage(
                        image: AssetImage('assets/images/no-image.png'),
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )),
                  Flexible(
                    child: Text(
                      htmlToString(summary),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      softWrap: true,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
