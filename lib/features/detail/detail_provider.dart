import 'package:flutter/material.dart';
import 'package:plotify/core/model/movie.dart';
import 'package:plotify/core/net/api_service.dart';

class DetailProvider with ChangeNotifier {
  final ApiService _apiService;
  DetailProvider(this._apiService);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  int? _id;

  Movie? _movie;
  Movie? get movie => _movie;

  Future<void> getMovieById() async {
    if (_id == null) {
      _setError("Movie ID is required");
      return;
    }

    try {
      _setLoading(true);
      _error = null;
      _movie = await _apiService.getMovieById(_id!);
      _setLoading(false);
      notifyListeners();
    } on Exception catch (e) {
      String errorMessage;
      if (e.toString().contains("Failed to connect to server")) {
        errorMessage = "Unable to connect to the server. Please check your internet connection.";
      } else if (e.toString().contains("Failed to fetch movie")) {
        errorMessage = "Unable to load movie details. Please try again later.";
      } else {
        errorMessage = "An unexpected error occurred: ${e.toString()}";
      }
      _setError(errorMessage);
      _setLoading(false);
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  void setId(int? id) {
    if (id == null || id <= 0) {
      _setError("Invalid movie ID");
      return;
    }
    _id = id;
    notifyListeners();
    getMovieById();
  }

  void _setError(String? newError) {
    if (_error != newError) {
      _error = newError;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _movie = null;
    _error = null;
    _id = null;
    super.dispose();
  }

}