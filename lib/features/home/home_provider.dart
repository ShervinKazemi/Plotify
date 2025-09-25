import 'package:flutter/widgets.dart';
import 'package:plotify/core/model/movies.dart';
import 'package:plotify/core/net/api_service.dart';

class HomeProvider with ChangeNotifier {
  final ApiService _apiService;
  HomeProvider(this._apiService) {
    initializeData();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  String _query = '';
  String get query => _query;

  Movies? _nowPlaying;
  Movies? get nowPlaying => _nowPlaying;

  Movies? _trending;
  Movies? get trending => _trending;

  Movies? _newReleases;
  Movies? get newReleases => _newReleases;

  Movies? _newReleaseShows;
  Movies? get newReleaseShows => _newReleaseShows;

  Movies? _recommended;
  Movies? get recommended => _recommended;

  Movies? _searches;
  Movies? get searches => _searches;

  Future<void> initializeData() async {
    try {
      _setLoading(true);
      _error = null;

      final futures = await Future.wait([
        _apiService.getMovies(1),
        _apiService.getMovies(2),
        _apiService.getMovies(3),
        _apiService.getMovies(4),
        _apiService.getMovies(5),
      ]);

      _trending = futures[0];
      _newReleases = futures[1];
      _newReleaseShows = futures[2];
      _recommended = futures[3];
      _nowPlaying = futures[4];

      _setLoading(false);
    } catch (exception) {
      _setError("Failed to load initial data: $exception");
      _setLoading(false);
    }
  }

  Future<void> getSearchMovies() async {
    try {
      _setLoading(true);
      _error = null;
      _searches = await _apiService.getSearchMovies(_query);
      _setLoading(false);
    } catch (exception) {
      _setError("Search failed: $exception");
      _setLoading(false);
    }
  }

  List<String> getNowPlayingImages() {
    if (_nowPlaying?.data == null) return [];

    return _nowPlaying!.data!
        .where((movie) => movie.poster != null && movie.poster!.isNotEmpty)
        .map((movie) => movie.poster!)
        .toList();
  }

  List<String> getNowPlayingRating() {
    if (_nowPlaying?.data == null) return [];

    return _nowPlaying!.data!
        .where(
          (movie) => movie.imdbRating != null && movie.imdbRating!.isNotEmpty,
        )
        .map((movie) => movie.imdbRating!)
        .toList();
  }

  List<String> getNowPlayingTitle() {
    if (_nowPlaying!.data == null) return [];
    return _nowPlaying!.data!
        .where((movie) => movie.title != null && movie.title!.isNotEmpty)
        .map((movie) => movie.title!)
        .toList();
  }

  List<String> getCategories() {
    return [
      "All Category",
      "Action",
      "Adventure",
      "Crime",
      "Drama",
      "Biography",
      "History",
      "Fantasy",
      "Western",
      "Comedy",
      "Family"
    ];
  }

  void updateQuery(String newQuery) {
    if (_isLoading) return;

    final trimmedQuery = newQuery.trim();
    if (_query == trimmedQuery) return;

    _query = trimmedQuery;
    _error = null;

    if (_query.isEmpty) {
      _searches = null;
      notifyListeners();
      return;
    }

    getSearchMovies();
  }

  void _setLoading(bool isLoading) {
    if (_isLoading != isLoading) {
      _isLoading = isLoading;
      notifyListeners();
    }
  }

  void _setError(String error) {
    if (_error != error) {
      _error = error;
      notifyListeners();
    }
  }

  void cleanSearches() {
    _query = '';
    _error = null;
    _searches = null;
    notifyListeners();
  }
}
