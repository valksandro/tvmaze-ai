import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesFilter extends StatefulWidget {
  final String emoji;
  final String filterName;
  const CategoriesFilter({
    Key? key,
    required this.emoji,
    required this.filterName,
  }) : super(key: key);

  @override
  State<CategoriesFilter> createState() => _CategoriesFilterState();
}

class _CategoriesFilterState extends State<CategoriesFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF161A37),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.emoji,
            style: const TextStyle(fontSize: 22),
            textScaleFactor: 1,
          ),
          Text(
            widget.filterName,
            style: GoogleFonts.varelaRound(
              fontSize: 12,
              color: Colors.white,
            ),
            textScaleFactor: 1,
          )
        ],
      ),
    );
  }
}
