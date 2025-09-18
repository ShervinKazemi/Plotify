import 'package:flutter/foundation.dart';
import 'package:plotify/core/model/movies.dart';
import 'package:plotify/core/net/api_service.dart';

class HomeProvider with ChangeNotifier {
  final ApiService _apiService;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Movies? _trending;
  Movies? _newReleases;
  Movies? _newReleaseShows;
  Movies? _recommended;

  Movies? get trending => _trending;
  Movies? get newReleases => _newReleases;
  Movies? get newReleaseShows => _newReleaseShows;
  Movies? get recommended => _recommended;

  HomeProvider(this._apiService) {
    _initializeData();
  }

  Future<void> _initializeData() async {
    await fetchMoviesData();
  }

  Future<void> fetchMoviesData() async {
    if (_isLoading) return;

    _setLoadingState(true);
    _clearError();

    try {
      final results = await Future.wait([
        _apiService.getMovies(1), // Trending
        _apiService.getMovies(2), // New Releases
        _apiService.getMovies(3), // New Shows
        _apiService.getMovies(4), // Recommended
      ]);

      _trending = results[0];
      _newReleases = results[1];
      _newReleaseShows = results[2];
      _recommended = results[3];
      
      _setLoadingState(false);
    } catch (e) {
      _setError('Failed to fetch movies: $e');
      _setLoadingState(false);
    }
  }

  Future<void> refreshCategory(String category) async {
    if (_isLoading) return;

    _setLoadingState(true);
    _clearError();

    try {
      final page = switch (category) {
        'trending' => 1,
        'new_releases' => 2,
        'new_shows' => 3,
        'recommended' => 4,
        _ => throw ArgumentError('Invalid category: $category'),
      };

      final movies = await _apiService.getMovies(page);
      
      switch (category) {
        case 'trending':
          _trending = movies;
        case 'new_releases':
          _newReleases = movies;
        case 'new_shows':
          _newReleaseShows = movies;
        case 'recommended':
          _recommended = movies;
      }

      _setLoadingState(false);
    } catch (e) {
      _setError('Failed to refresh $category: $e');
      _setLoadingState(false);
    }
  }

  void _setLoadingState(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  void clearCache() {
    _trending = null;
    _newReleases = null;
    _newReleaseShows = null;
    _recommended = null;
    notifyListeners();
  }

  @override
  void dispose() {
    clearCache();
    super.dispose();
  }
}