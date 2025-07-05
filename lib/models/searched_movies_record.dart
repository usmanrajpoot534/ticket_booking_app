import 'package:ticket_booking_app/models/movies_record.dart';

class SearchedMoviesRecord {
  const SearchedMoviesRecord({this.page, this.movies = const []});

  final num? page;
  final List<Movie> movies;

  factory SearchedMoviesRecord.fromJson(Map<String, dynamic> json) {
    return SearchedMoviesRecord(
      page: json["page"],
      movies: json["results"] == null
          ? []
          : List<Movie>.from(json["results"]!.map((x) => Movie.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": movies.map((x) => x.toJson()).toList(),
  };
}
