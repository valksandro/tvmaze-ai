class Show {
  final int id;
  final String url;
  final String name;
  final String type;
  final String language;
  final List<String> genres;
  final Schedule schedule;
  final Image image;
  final String summary;

  Show(
      {this.id = 0,
      this.url = '',
      this.name = '',
      this.type = '',
      this.language = '',
      this.genres = const <String>[],
      this.schedule = const Schedule(),
      this.image = const Image(),
      this.summary = ''});

  Show copyWith({
    int? id,
    String? url,
    String? name,
    String? type,
    String? language,
    List<String>? genres,
    Schedule? schedule,
    Image? image,
    String? summary,
  }) {
    return Show(
      id: id ?? this.id,
      url: url ?? this.url,
      name: name ?? this.name,
      type: type ?? this.type,
      language: language ?? this.language,
      genres: genres ?? this.genres,
      schedule: schedule ?? this.schedule,
      image: image ?? this.image,
      summary: summary ?? this.summary,
    );
  }


  factory Show.fromJson(Map<String, dynamic> json) {
    final id = json['id'] ?? 0;
    final url = json['url'] ?? '';
    final name = json['name'] ?? '';
    final type = json['type'] ?? '';
    final language = json['language'] ?? '';
    final genres = json['genres']?.cast<String>() ?? <String>[];
    final schedule = json['schedule'] != null
        ? Schedule.fromJson(json['schedule'])
        : const Schedule();
    final image =
        json['image'] != null ? Image.fromJson(json['image']) : const Image();
    final summary = json['summary'] ?? '';
    return Show(
        id: id,
        url: url,
        name: name,
        type: type,
        language: language,
        genres: genres,
        schedule: schedule,
        image: image,
        summary: summary);
  }
}

class Schedule {
  final String time;
  final List<String> days;

  const Schedule([this.time = '', this.days = const <String>[]]);

  factory Schedule.fromJson(Map<String, dynamic> json) {
    final time = json['time'] ?? '';
    final days = json['days']?.cast<String>() ?? const <String>[];
    return Schedule(time, days);
  }
}

class Image {
  final String medium;
  final String original;

  const Image([this.medium = '', this.original = '']);

  factory Image.fromJson(Map<String, dynamic> json) {
    final medium = json['medium'] ?? '';
    final original = json['original'] ?? '';
    return Image(medium, original);
  }
}

class Episode {
  final int id;
  final String name;
  final int season;
  final int number;
  final String airDate;
  final String airTime;
  final String airStamp;
  final Image image;
  final String summary;

  Episode(
      {this.id = 0,
      this.name = '',
      this.season = 0,
      this.number = 0,
      this.airDate = '',
      this.airTime = '',
      this.airStamp = '',
      this.image = const Image(),
      this.summary = ''});

  factory Episode.fromJson(Map<String, dynamic> json) {
    final id = json['id'] ?? 0;
    final name = json['name'] ?? '';
    final season = json['season'] ?? 0;
    final number = json['number'] ?? 0;
    final airDate = json['airdate'] ?? '';
    final airTime = json['airtime'] ?? '';
    final airStamp = json['airstamp'] ?? '';
    final image =
        json['image'] != null ? Image.fromJson(json['image']) : const Image();
    final summary = json['summary'] ?? '';
    return Episode(
        id: id,
        name: name,
        season: season,
        number: number,
        airDate: airDate,
        airTime: airTime,
        airStamp: airStamp,
        image: image,
        summary: summary);
  }
}
