class Album {
  final String id;
  final String title;
  final String originalTitle;
  final String originalTitleRomanized;
  final String image;
  final String movieBanner;
  final String description;
  final String director;
  final String producer;
  final String releaseDate;
  final String runningTime;
  final String rtScore;

  Album({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.originalTitleRomanized,
    required this.image,
    required this.movieBanner,
    required this.description,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.runningTime,
    required this.rtScore});

    factory Album.fromMap(Map<String, dynamic> e) {
      return Album(
        id: e['id'] ?? (throw 'Missing id'),
        title: e['title'] ?? (throw 'Missing title'), 
        originalTitle: e['original_title'] ?? (throw 'Missing jp title'), 
        originalTitleRomanized: e['original_title_romanised'] ?? (throw 'Missing romanized title'), 
        image: e['image'] ?? (throw 'Missing image'), 
        movieBanner: e['movie_banner'] ?? (throw 'Missing banner'),
        description: e['description'] ?? (throw 'Missing description'), 
        director: e['director'] ?? (throw 'missing director'), 
        producer: e['producer'] ?? (throw 'missing producer'), 
        releaseDate: e['release_date'] ?? (throw 'missing date'), 
        runningTime: e['running_time'] ?? (throw 'missing time'), 
        rtScore: e['rt_score'] ?? (throw 'missing score')
      );
    }

    
}