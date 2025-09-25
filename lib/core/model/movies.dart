class Movies {
  List<Data>? data;
  Metadata? metadata;

  Movies({this.data, this.metadata});

  Movies.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    metadata = json['metadata'] != null
        ? Metadata.fromJson(json['metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? poster;
  String? year;
  String? country;
  String? imdbRating;
  List<String>? genres;
  List<String>? images;

  Data(
      {this.id,
        this.title,
        this.poster,
        this.year,
        this.country,
        this.imdbRating,
        this.genres,
        this.images});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    poster = json['poster'];
    year = json['year'];
    country = json['country'];
    imdbRating = json['imdb_rating'];
    genres = json['genres'] != null ? List<String>.from(json['genres']) : null;
    images = json['images'] != null ? List<String>.from(json['images']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['poster'] = poster;
    data['year'] = year;
    data['country'] = country;
    data['imdb_rating'] = imdbRating;
    data['genres'] = genres;
    data['images'] = images;
    return data;
  }
}

class Metadata {
  String? currentPage;
  int? perPage;
  int? pageCount;
  int? totalCount;

  Metadata({this.currentPage, this.perPage, this.pageCount, this.totalCount});

  Metadata.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    pageCount = json['page_count'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['per_page'] = perPage;
    data['page_count'] = pageCount;
    data['total_count'] = totalCount;
    return data;
  }
}
