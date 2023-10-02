import 'package:flutter/material.dart';

import 'shimmer_general_widget.dart';

class ShimmerEpisodes extends StatelessWidget {
  const ShimmerEpisodes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(children: [
        ...List.generate(
            6,
            (index) => ShimmerGeneral(
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.all(5),
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey,
                    ),
                  ),
                ))
      ]),
    );
  }
}
