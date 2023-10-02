import 'package:flutter/material.dart';

import '../../data/models/series_model.dart';
import 'detail_image_widget.dart';

class ImageLayerEffectWidget extends StatelessWidget {
  const ImageLayerEffectWidget({
    Key? key,
    required this.show,
  }) : super(key: key);

  final Show show;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 390,
      child: Stack(
        children: [
          Positioned(
            left: 20,
            child: Container(
              height: 350,
              width: 230,
              decoration: BoxDecoration(
                color: const Color(0xFF292A46).withOpacity(0.8),
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),
          Positioned(
            left: 15,
            child: Container(
              height: 335,
              width: 240,
              decoration: BoxDecoration(
                color: const Color(0xFF292A46),
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),
          DetailImageWidget(show: show),
        ],
      ),
    );
  }
}
