class TrailersRecord {
  const TrailersRecord({this.id, this.trailers = const []});

  final int? id;
  final List<Trailer> trailers;

  factory TrailersRecord.fromJson(Map<String, dynamic> json) {
    return TrailersRecord(
      id: json["id"],
      trailers: json["results"] == null
          ? []
          : List<Trailer>.from(
              json["results"]!.map((x) => Trailer.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "results": trailers.map((x) => x.toJson()).toList(),
  };
}

class Trailer {
  const Trailer({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  final String? iso6391;
  final String? iso31661;
  final String? name;
  final String? key;
  final String? site;
  final num? size;
  final String? type;
  final bool? official;
  final DateTime? publishedAt;
  final String? id;

  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
      iso6391: json["iso_639_1"],
      iso31661: json["iso_3166_1"],
      name: json["name"],
      key: json["key"],
      site: json["site"],
      size: json["size"],
      type: json["type"],
      official: json["official"],
      publishedAt: DateTime.tryParse(json["published_at"] ?? ""),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "iso_639_1": iso6391,
    "iso_3166_1": iso31661,
    "name": name,
    "key": key,
    "site": site,
    "size": size,
    "type": type,
    "official": official,
    "published_at": publishedAt?.toIso8601String(),
    "id": id,
  };
}
