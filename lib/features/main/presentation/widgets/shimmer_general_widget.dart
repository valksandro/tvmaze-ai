import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGeneral extends StatefulWidget {
  final Widget child;

  const ShimmerGeneral(this.child, {Key? key}) : super(key: key);

  @override
  _ShimmerGeneralState createState() => _ShimmerGeneralState();
}

class _ShimmerGeneralState extends State<ShimmerGeneral> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: widget.child);
  }
}
