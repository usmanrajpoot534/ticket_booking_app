class MoviesRecord {
  const MoviesRecord({this.dates, this.page, this.movies = const []});

  final Dates? dates;
  final num? page;
  final List<Movie> movies;

  factory MoviesRecord.fromJson(Map<String, dynamic> json) {
    return MoviesRecord(
      dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
      page: json["page"],
      movies: json["results"] == null
          ? []
          : List<Movie>.from(json["results"]!.map((x) => Movie.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "dates": dates?.toJson(),
    "page": page,
    "results": movies.map((x) => x.toJson()).toList(),
  };
}

class Dates {
  const Dates({this.maximum, this.minimum});

  final String? maximum;
  final String? minimum;

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(maximum: json["maximum"], minimum: json["minimum"]);
  }

  Map<String, dynamic> toJson() => {"maximum": maximum, "minimum": minimum};
}

class Movie {
  const Movie({
    this.adult,
    this.backdropPath,
    this.genreIds = const [],
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final List<num> genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final num? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final num? voteAverage;
  final num? voteCount;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: json["genre_ids"] == null
          ? []
          : List<num>.from(json["genre_ids"]!.map((x) => x)),
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"],
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
    );
  }

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": genreIds.map((x) => x).toList(),
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
