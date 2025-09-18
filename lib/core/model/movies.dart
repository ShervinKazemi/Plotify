class Movies {
  final List<Movie> data;
  final Metadata metadata;

  const Movies({
    required this.data,
    required this.metadata,
  });

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      data: (json['data'] as List)
          .map((movieJson) => Movie.fromJson(movieJson as Map<String, dynamic>))
          .toList(),
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.map((movie) => movie.toJson()).toList(),
        'metadata': metadata.toJson(),
      };
}

class Movie {
  final int id;
  final String title;
  final String poster;
  final String year;
  final String country;
  final String imdbRating;  
  final List<String> genres;
  final List<String>? images;

  const Movie({
    required this.id,
    required this.title,
    required this.poster,
    required this.year,
    required this.country,
    required this.imdbRating,
    required this.genres,
    this.images,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      poster: json['poster'] as String,
      year: json['year'] as String,
      country: json['country'] as String,
      imdbRating: json['imdbRating'] as String,
      genres: List<String>.from(json['genres'] as List),
      images: json['images'] != null 
          ? List<String>.from(json['images'] as List)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'poster': poster,
        'year': year,
        'country': country,
        'imdbRating': imdbRating,
        'genres': genres,
        if (images != null) 'images': images,
      };
}
class Metadata {
  final String currentPage;
  final int perPage;
  final int pageCount;
  final int totalCount;

  const Metadata({
    required this.currentPage,
    required this.perPage,
    required this.pageCount,
    required this.totalCount,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      currentPage: json['currentPage'] as String,
      perPage: json['perPage'] as int,
      pageCount: json['pageCount'] as int,
      totalCount: json['totalCount'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'currentPage': currentPage,
        'perPage': perPage,
        'pageCount': pageCount,
        'totalCount': totalCount,
      };
}
