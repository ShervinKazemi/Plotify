class Movies {
    final List<Datum> data;
    final Metadata metadata;

    Movies({
        required this.data,
        required this.metadata,
    });

    factory Movies.fromJson(Map<String, dynamic> json) {
      return Movies(
        data: json["data"],
        metadata: json["metadata"]
      );
    }

}

class Datum {
    final int id;
    final String title;
    final String poster;
    final String year;
    final String country;
    final String imdbRating;
    final List<String> genres;
    final List<String>? images;

    Datum({
        required this.id,
        required this.title,
        required this.poster,
        required this.year,
        required this.country,
        required this.imdbRating,
        required this.genres,
        this.images,
    });

}

class Metadata {
    final String currentPage;
    final int perPage;
    final int pageCount;
    final int totalCount;

    Metadata({
        required this.currentPage,
        required this.perPage,
        required this.pageCount,
        required this.totalCount,
    });

}
