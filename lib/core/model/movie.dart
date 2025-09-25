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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['poster'] = this.poster;
    data['year'] = this.year;
    data['rated'] = this.rated;
    data['released'] = this.released;
    data['runtime'] = this.runtime;
    data['director'] = this.director;
    data['writer'] = this.writer;
    data['actors'] = this.actors;
    data['plot'] = this.plot;
    data['country'] = this.country;
    data['awards'] = this.awards;
    data['metascore'] = this.metascore;
    data['imdb_rating'] = this.imdbRating;
    data['imdb_votes'] = this.imdbVotes;
    data['imdb_id'] = this.imdbId;
    data['type'] = this.type;
    data['genres'] = this.genres;
    data['images'] = this.images;
    return data;
  }
}
