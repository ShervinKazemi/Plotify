class Movie {
  int? id;
  String? title;
  String? poster;
  String? year;
  String? rated;
  String? released;
  String? runtime;
  String? director;
  String? writer;
  String? actors;
  String? plot;
  String? country;
  String? awards;
  String? metascore;
  String? imdbRating;
  String? imdbVotes;
  String? imdbId;
  String? type;
  List<String>? genres;
  List<String>? images;

  Movie(
      {this.id,
      this.title,
      this.poster,
      this.year,
      this.rated,
      this.released,
      this.runtime,
      this.director,
      this.writer,
      this.actors,
      this.plot,
      this.country,
      this.awards,
      this.metascore,
      this.imdbRating,
      this.imdbVotes,
      this.imdbId,
      this.type,
      this.genres,
      this.images});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    poster = json['poster'];
    year = json['year'];
    rated = json['rated'];
    released = json['released'];
    runtime = json['runtime'];
    director = json['director'];
    writer = json['writer'];
    actors = json['actors'];
    plot = json['plot'];
    country = json['country'];
    awards = json['awards'];
    metascore = json['metascore'];
    imdbRating = json['imdb_rating'];
    imdbVotes = json['imdb_votes'];
    imdbId = json['imdb_id'];
    type = json['type'];
    genres = json['genres'].cast<String>();
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['poster'] = poster;
    data['year'] = year;
    data['rated'] = rated;
    data['released'] = released;
    data['runtime'] = runtime;
    data['director'] = director;
    data['writer'] = writer;
    data['actors'] = actors;
    data['plot'] = plot;
    data['country'] = country;
    data['awards'] = awards;
    data['metascore'] = metascore;
    data['imdb_rating'] = imdbRating;
    data['imdb_votes'] = imdbVotes;
    data['imdb_id'] = imdbId;
    data['type'] = type;
    data['genres'] = genres;
    data['images'] = images;
    return data;
  }
}
