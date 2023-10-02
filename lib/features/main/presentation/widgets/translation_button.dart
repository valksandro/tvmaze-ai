import 'package:flutter/material.dart';

class TranslationButton extends StatefulWidget {
  final Function(Map<String, String>) onChange;
  const TranslationButton(this.onChange, {Key? key}) : super(key: key);

  @override
  _TranslationButtonState createState() => _TranslationButtonState();
}

class _TranslationButtonState extends State<TranslationButton> {
  String _selectedFlag = 'US';

  final List<Map<String, String>> countries = [
    {'flag': '🇧🇷', 'code': 'BR', 'language': 'Português', 'lang': 'Portuguese'},
    {'flag': '🇺🇸', 'code': 'US', 'language': 'English', 'lang': 'English'},
    {'flag': '🇫🇷', 'code': 'FR', 'language': 'Français', 'lang': 'French'},
    {'flag': '🇪🇸', 'code': 'ES', 'language': 'Español',  'lang': 'Spanish'},
    {'flag': '🇩🇪', 'code': 'DE', 'language': 'Deutsch',  'lang': 'German'},
    {'flag': '🇰🇷', 'code': 'KR', 'language': '한국어', 'lang': 'Korean'},
    {'flag': '🇮🇹', 'code': 'IT', 'language': 'Italiano', 'lang': 'Italian'},
    {'flag': '🇯🇵', 'code': 'JP', 'language': '日本語', 'lang': 'Japanese'},
    {'flag': '🇨🇳', 'code': 'CN', 'language': '中文', 'lang': 'Chinese'},
    {'flag': '🇷🇺', 'code': 'RU', 'language': 'Русский', 'lang': 'Russian'},
    {'flag': '🇮🇳', 'code': 'IN', 'language': 'हिंदी', 'lang': 'Hindi'}
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        selectedItemBuilder: (BuildContext context) {
          return countries.map<Widget>((Map<String, String> item) {
            return Row(
              children: [
                Text(item['flag']!),
                const SizedBox(width: 50)
              ],
            );
          }).toList();
        },
        value: _selectedFlag,
        icon: Row(
          children: const [
            Icon(Icons.translate, color: Colors.white),
            Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
        items: countries.map((country) {
          return DropdownMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(country['flag']!),
                    const SizedBox(width: 8),
                    Text(country['language']!),
                  ],
                ),
                if (country['code'] == _selectedFlag)
                  const Icon(Icons.check, color: Colors.green),
              ],
            ),
            value: country['code'],
          );
        }).toList(),
        onChanged: (value) {
          widget.onChange(countries.firstWhere((country) => country['code'] == value));
          setState(() {
            _selectedFlag = value!;
          });
        },
      ),
    );
  }
}