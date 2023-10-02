import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/series_model.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({Key? key, required this.show}) : super(key: key);

  final Show show;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const Icon(
              Icons.access_time_rounded,
              size: 17,
              color: Colors.white54,
            ),
            const SizedBox(width: 5),
            Text(
              show.schedule.time,
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white54,
              ),
              textScaleFactor: 1,
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.calendar_today_rounded,
              size: 17,
              color: Colors.white54,
            ),
            const SizedBox(width: 5),
            Row(
              children: [
                Text(
                    show.schedule.days
                        .map((e) => e + ' - ')
                        .join()
                        .replaceAll(RegExp(r'\s*-\s$'), ''),
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white54))
              ],
            ),
          ],
        ));
  }
}
