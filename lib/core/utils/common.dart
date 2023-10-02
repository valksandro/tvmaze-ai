import 'package:flutter/material.dart';
import 'package:html/parser.dart';

const emojiMap = {
  'horror': '😱',
  'food': '🍔',
  'action': '😎',
  'romance': '🥰',
  'comedy': '🤪',
  'drama': '🎭',
  'thriller': '🔪',
  'crime': '👮️',
  'mystery': '🕵️‍️',
  'fantasy': '🧚‍️',
  'supernatural': '👻‍️',
  'adventure': '🏔‍',
  'science-fiction': '🛸‍',
  'family': '👨‍👩‍👧‍'
};

Future<dynamic> get(BuildContext context, Function builder,
    {bool replace = false}) async {
  if (replace) {
    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (b) => builder()));
  }
  await Navigator.of(context)
      .push(MaterialPageRoute(builder: (b) => builder()));
}

String getEmojiByGenre(String genre) => emojiMap[genre.toLowerCase()] ?? '😀';

String htmlToString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

void showSnackBar(BuildContext context, String message, {int seconds = 5}) {
  Future.delayed(Duration.zero, () {
    final snackBar = SnackBar(
      duration: Duration(seconds: seconds),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white54),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}
