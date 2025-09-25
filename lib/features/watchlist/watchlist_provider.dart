import 'package:flutter/cupertino.dart';
import 'package:plotify/core/model/movies.dart';
import 'package:plotify/core/net/api_service.dart';

class WatchlistProvider with ChangeNotifier {
  final ApiService _apiService;
  WatchlistProvider(this._apiService) {
    initializeData();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Movies? _movies;
  Movies? get movies => _movies;

  Future<void> initializeData() async {
    try {
      _setLoading(true);
      _error = null;

      _movies = await _apiService.getMovies(5);

      _setLoading(false);
    } catch (exception) {
      _setError("Failed to load initial data: $exception");
      _setLoading(false);
    }
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
}
